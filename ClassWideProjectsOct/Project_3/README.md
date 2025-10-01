# Project 3 — SSD Performance Profiling

## System / testbed
- **CPU:** [AMD Ryzen 7 7800X3D]
- **RAM:** [size + speed]
- **SSD:** [vendor/model, interface (NVMe PCIe x4 / SATA), capacity]
- **OS:** Arch Linux x86_64 
- **Kernel:** 6.16.8-arch3-1 
- **Test device used:** `/dev/nvme0n1` (dedicated test device) with test file: `~/fio-tests/fio_testfile`
- **fio version:** 3.39
- **nvme version:** 2.15 (git 2.15)
- **libnvme version:** 1.15 (git 1.15)
- **smartctl version:** 7.5 2025-04-30 r5714 [x86_64-linux-6.16.8-arch3-1] (local build)

## Safety / methodology
- Tests performed on spare device `/dev/…` / large file on empty FS.
- `--direct=1` used to bypass page cache.
- Preconditioning details (time, iodepth, pattern).
- CPU governor fixed to `performance` and test pinned to core(s) where appropriate.
- Repeats: N = [3] runs; report mean ± std.
- Time-based runs (durations): [30 s / 60 s / 120 s] as indicated.

## Tools & scripts
- `scripts/precondition_write.sh` — precondition SSD (random writes).
- `scripts/zero_queue.sh` — QD=1 latency runs for 4KiB rand and 128KiB seq.
- `scripts/block_size_sweep.sh` — block size sweep for rand/seq.
- `scripts/rw_mix_sweep.sh` — 100%R, 100%W, 70/30, 50/50 at 4KiB.
- `scripts/qd_sweep.sh` — QD sweep (e.g., 1→128).
- `scripts/tail_latency.sh` — p50/p95/p99/p99.9 capture.
- `scripts/collect_drive_info.sh` — SMART & nvme logs.
- All fio runs write JSON to `data/fio/...`.

## Experiments
1. Zero-queue (QD=1) latencies — table (avg, p95, p99).
2. Block-size sweep — plot + analysis.
3. Read/write mixes — plot + analysis.
4. QD sweep (throughput vs latency) — plot with knee marked + Little’s Law check.
5. Tail latencies — p50/p95/p99/p99.9 + discussion.
6. Working-set / LBA-range effects — results and explanation (SLC cache, controller behavior).
7. Anomalies / limitations — e.g., thermal throttling, SLC caching, device busy background tasks.

## How to reproduce (example)
```bash
# 1) Preconditions
sudo ./scripts/precondition_write.sh /dev/nvme0n1 300

# 2) Zero-queue latencies
sudo ./scripts/zero_queue.sh /dev/nvme0n1 30

# 3) Block-size sweep
sudo ./scripts/block_size_sweep.sh /dev/nvme0n1 30

# 4) QD sweep
sudo ./scripts/qd_sweep.sh /dev/nvme0n1 30

# 5) collect SMART
sudo ./scripts/collect_drive_info.sh /dev/nvme0n1
```

## Process

For project 3, either make an empty partition to test the SSD, or make a file to test against.

### Test File
For this project, a test file will be used. Below is a shell script to make a 20GB file for testing.
```bash
mkdir -p ~/fio-tests

# allocate a 20 GB file for testing
dd if=/dev/zero of=~/fio-tests/testfile bs=1M count=20480 status=progress
```
### Tasks 1-4
After making the test file, tasks 1 through 4 can be run using the Task1_4.sh bash shell script. To use the script, input the path of the test file and the output directory as so:
```bash
./Task1_4.sh <testfile> <output_dir>
```

here are some example command lines:
```bash
./Task1_4.sh ~/fio-tests/testfile results/
```
