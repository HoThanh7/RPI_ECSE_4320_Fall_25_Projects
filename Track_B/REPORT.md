# MemorySimulator — Tier-Aware Locking in Heterogeneous Memory (Track B - Topic 3)

Date: December 13, 2025

## 1. Motivation
As DRAM scaling plateaus, systems evolve to multi-tier memory: DDR for hot data, CXL-attached compressed DRAM for warm data, and SSDs for cold persistence. In this hierarchy, uniform-latency assumptions break down. Synchronization paths (locks and metadata) placed in slow tiers can amplify contention and tail latency. This project investigates whether tier-aware placement and synchronization reduce stalls in concurrent data structures, focusing on a per-key locked key–value store.

## 2. Literature Review
This work sits at the intersection of NUMA-aware synchronization, compression-aware middle tiers, and concurrent data structures across heterogeneous memory.

- NUMA-aware locking and contention: Early experiences from OS kernels showed that remote memory paths during lock acquisition drive disproportionate tail latency and scalability limits; queue-based locks and careful placement mitigate cross-node contention ([Bolosky et al., OSDI'94](https://www.usenix.org/conference/osdi-94/experiences-locking-numa-multiprocessor-operating-system-kernel)). This directly motivates keeping contended locks near fast memory.

- Compression-aware middle tier (MTP): Recent VMIL'25 work on Middle-Tier Placement (MTP) proposes sampling-based identification of warm/hot objects and promotion/demotion policies tailored to compression overheads and capacity trade-offs ([Yuze et al., VMIL'25 camera-ready](https://people.cs.vt.edu/lyuze/files/MTP_VMIL_25_camera_ready.pdf)). This source is most relevant to our project: TAL adopts its lightweight sampling, short windows, and top-K promotion principles to manage a CXL-like compressed tier while bounding (de)compression costs.

- Heterogeneous memory hierarchy with CXL: Emerging systems integrate DDR, CXL-attached compressed DRAM, and SSD/NAND. Recent IEEE research discusses performance, latency, and coherence challenges under CXL-based memory fabrics and the implications for software tiering ([IEEE, 2024](https://ieeexplore.ieee.org/abstract/document/10764537)). These insights inform our tier latencies and decompression overhead model.

Taken together, these works justify our choice to: 
1) Co-locate hot locks and data in the fast tier to cut remote/slow paths 
2) Use sampling-driven promotion/demotion to manage middle-tier compression costs 
3) Evaluate throughput and tail latency as first-class metrics

## 3. Problem Statement & Design
Problem
- Multi-tier memory introduces large variance in access latency (DDR ≪ CXL ≪ SSD). Even rare slow-tier hits on synchronization metadata (locks, indexes) can inflate tail latency under contention.
- Traditional concurrent data structures assume uniform latency; as a result, lock placement and memory-tier interactions become hidden bottlenecks.

Hypothesis
- Co-locating hot data and their locks in DDR reduces slow-path lock waits and improves tail latency and throughput.
- Lightweight, sampling-driven promotion/demotion can maintain DDR residency for the hot set without heavy profiling overhead.

Design: Tier-Aware Locking (TAL)
- Per-key locks co-located with data blocks, so moving a key between tiers also relocates its lock.
- Periodic sampling: every `migration_interval_s`, record recent per-key touches; promote top-K keys above `migrate_threshold` to DDR (inspired by MTP short-window sampling/top-K promotion).
- Capacity preservation: randomly sample DDR keys and demote those with low recent activity to CXL/SSD based on `demote_threshold`, avoiding DDR saturation.
- Overhead modeling: add `cxl_decompress_overhead` to CXL accesses and to migrations touching CXL.
- Modes: BASELINE disables migration; TAL enables the sampling+migration loop.

Objectives & Metrics
- Primary: end-to-end throughput (ops/s) and tail latency (p95/p99) improvement of TAL vs BASELINE.
- Secondary: lock-wait p95, per-tier access distribution, migration counts/time, ping-pong stability.

Expected Outcomes
- Under skewed workloads or moderate/high contention, TAL increases throughput and reduces tail latency by concentrating the hot set in DDR.
- TAL’s benefits diminish with uniform access or low contention; thresholds/intervals control overhead and stability.

### TAL Policy Pseudocode
High-level pseudocode describing the sampling, promotion, and demotion loop implemented in `MemSimZ.py`.

```
initialize tiers DDR, CXL, SSD with latencies and (optional) capacities
initialize KVStore with num_keys; assign each key a Block{value, tier, lock}
mark a small hot set (hot_fraction) for workload generation

start N worker threads:
	loop until stop:
		(key, op) ← sample_key_and_op(hot_bias, zipf_theta, read_ratio)
		t0 ← now()
		acquire block[key].lock with timeout
		record lock wait = now() − t0
		with access_counter_lock:
			access_counter[key] += 1
		tier, access_time ← access(key, op)
			// sleep for tier.latency + cxl_decompress_overhead if tier==CXL
			// update value on writes
		release block[key].lock
		if now() ≥ start_time + measure_after_s:
			record_op(latency=now()−request_time, lock_wait, tier)

if mode == TAL:
	every migration_interval_s:
		with access_counter_lock:
			snapshot ← copy(access_counter); clear(access_counter)
		if snapshot is empty: continue
		top_k ← largest K keys by snapshot count
		now_ts ← now()

		// promotions: hot keys to DDR
		for each (key, cnt) in top_k:
			if cnt ≥ migrate_threshold and block[key].tier != DDR:
				acquire block[key].lock with timeout
				migrate_key(key, target_tier=DDR, now=now_ts)
					// sleep source.latency + target.latency (+ decompress if CXL)
					// update per-tier membership; count promotions, migration_time
				release block[key].lock

		// demotions: cold keys out of DDR
		candidates ← random_sample(DDR.members, demotion_sample)
		for each key in candidates:
			if snapshot.get(key, 0) < demote_threshold:
				acquire block[key].lock with timeout
				target ← CXL with prob 0.7 else SSD
				migrate_key(key, target_tier=target, now=now_ts)
					// count demotions, migration_time; ping-pong if near-old migration
				release block[key].lock
```

Notes:
- Promotion threshold and demotion threshold introduce hysteresis to reduce oscillations.
- Migration acquires the per-key lock to preserve correctness.
- Metrics include throughput, latency percentiles, lock-wait tail, per-tier counts, migration counts/time, and ping-pongs.

## 4. Model & Implementation
Code: see `MemSimZ.py`.
- Tiers: `DDR`, `CXL`, `SSD` with latencies in `tier_latencies` and `cxl_decompress_overhead`.
- Data structure: `KVStore` with `Block` objects carrying `tier` and `lock`.
- Workload: `WorkloadGenerator` combines hot-bias and optional Zipf skew; `read_ratio` controls mix.
- TAL loop: every `migration_interval_s`, sample recent counts; promote top-K above `migrate_threshold` to DDR; demote cold DDR keys using `demote_threshold`.
- Metrics: throughput, latency percentiles (p50/p95/p99), lock-wait p95, per-tier counts, migrations and ping-pongs.
- Reproducibility: deterministic seeds per configuration; outputs CSV `tiered_sim_results.csv` and plots.

## 5. Methodology
Experiments compare BASELINE vs TAL across:
- Threads: 8, 24, 48.
- Hot fraction: 0.01, 0.05, 0.2.
- Zipf skew: 0.0 (uniform) and 0.8 (skewed) for hot-fraction sweep.
- Shared base config: `num_keys=2000`, `read_ratio=0.9`, latencies `{DDR: 0.12ms, CXL: 0.8ms (+0.4ms decompress), SSD: 10ms}`.
Warm-up `measure_after_s=1.5` excludes startup.

Alignment to prior work:
- Sampling window and top-K thresholding follow MTP-like reactiveness to hotness while bounding overhead.
- Promotion co-locates locks/data in DDR per NUMA-inspired placement to reduce slow-path lock waits.

How to run:
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python MemSimZ.py
```
Outputs:
- Table printed to console and saved as CSV: `tiered_sim_results.csv`.
- Figures: `plot_threads_throughput.png`, `plot_threads_p95_latency.png`, `plot_promotions_vs_hot_fraction.png`.

Viewing Figures in Markdown
- The figures referenced above are embedded via relative links and render in GitHub and VS Code Markdown preview. Simply open this report to view them inline.

## 6. Preliminary Results
Summary observations with TAL vs BASELINE:
- Throughput: TAL ≥ BASELINE at moderate/high contention (see [plot_threads_throughput.png](plot_threads_throughput.png)).
- Tail latency: TAL reduces p95 vs BASELINE by concentrating hot locks/keys in DDR (see [plot_threads_p95_latency.png](plot_threads_p95_latency.png)).
- Promotions vs hot fraction: TAL scales promotions with skew/hot-set size (see [plot_promotions_vs_hot_fraction.png](plot_promotions_vs_hot_fraction.png)).
- Tier distribution: TAL increases DDR share for hot keys, reduces CXL/SSD touches.
- Migration overhead: Acceptable; ping-pong events bounded by `ping_pong_window_s`.

Refer to `tiered_sim_results.csv` for exact values.

Figure Commentary
- Throughput vs threads: The [plot_threads_throughput.png](plot_threads_throughput.png) curve shows TAL maintaining higher ops/s as threads increase, indicating reduced contention amplification via DDR residency of hot locks/keys.
- p95 latency vs threads: The [plot_threads_p95_latency.png](plot_threads_p95_latency.png) figure shows TAL lowering the tail as thread count rises, consistent with fewer slow-tier lock acquisitions.
- Promotions vs hot fraction: The [plot_promotions_vs_hot_fraction.png](plot_promotions_vs_hot_fraction.png) trend increases with larger hot sets/skew, reflecting TAL’s responsiveness; migration counts remain bounded by batch/interval settings.

### Key Results Table (excerpt)
Representative runs comparing BASELINE vs TAL.

| Threads | Mode     | Throughput (ops/s) | p95 latency (ms) | Promotions | Demotions |
|---------|----------|--------------------|------------------|------------|-----------|
| 8       | BASELINE | 1116               | 11.47            | 0          | 0         |
| 8       | TAL      | 5788               | 10.08            | 72         | 333       |
| 24      | BASELINE | 3018               | 19.26            | 0          | 0         |
| 24      | TAL      | 10094              | 10.09            | 81         | 307       |
| 48      | BASELINE | 5078               | 26.68            | 0          | 0         |
| 48      | TAL      | 10423              | 10.30            | 80         | 257       |

Notes: Values summarized from `tiered_sim_results.csv`; see the CSV for complete metrics including p50/p99, lock-wait p95, migration time, and per-tier access distribution.

## 7. Quantitative Analysis & Insight
- Contention amplification: A few locks in CXL drive long waits; TAL cuts this path by promoting contended keys.
- Capacity vs performance: Demotion preserves DDR capacity while maintaining hot-set residency; thresholds tune the trade-off.
- Skew sensitivity: With Zipf θ=0.8, TAL gains are larger due to clearer hot set; with uniform access, gains diminish.
- Migration cost: Measured `migration_time_s` is small relative to operation time; batching limits overhead.
- Stability: `ping_pongs` stay low with conservative thresholds; aggressive promotion/demotion may oscillate.

## 8. Limitations & Future Work
- Lock model: `threading.Lock` vs queue-based or NUMA-aware locks; emulate MCS to test sensitivity.
- OS effects: Real CXL/SSD involve queueing, DMA, and coherence traffic not fully modeled.
- Consistency: Per-key migration is safe; tree/index structures need multi-node consistency schemes.
- Placement granularity: Per-key moves vs page/object placement with compression-aware policies.

## 9. Lessons Learned
- Tail latency often stems from synchronization touching slow tiers; placement matters as much as data hotness.
- Lightweight sampling captures hot sets and yields gains with minimal complexity.
- Balancing promotion thresholds and demotion sampling stabilizes performance without overfitting.

## 10. Reproducibility & Artifact Availability
- Artifact: code, README, and this report in the Track B folder.
- Determinism: seeded runs; CSV and plots generated automatically.
- Environment: Python 3.10+, `numpy`, `pandas`, `matplotlib` pinned in `requirements.txt`.

## 11. References (indicative)
1) Bolosky, W. J., et al. "The Experiences of Locking in a NUMA Multiprocessor Operating System Kernel." OSDI 1994. https://www.usenix.org/conference/osdi-94/experiences-locking-numa-multiprocessor-operating-system-kernel

2) Yuze, L., et al. "Middle-Tier Placement (MTP): Compression-Aware Warm Data Management." VMIL 2025 (camera-ready). https://people.cs.vt.edu/lyuze/files/MTP_VMIL_25_camera_ready.pdf

3) IEEE article on CXL-attached memory systems and performance considerations (2024). https://ieeexplore.ieee.org/abstract/document/10764537
