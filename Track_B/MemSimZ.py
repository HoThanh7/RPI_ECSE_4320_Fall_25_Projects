# Save this as tiered_simulator_experiments.py or paste into a Jupyter cell.
import threading, time, random, math, statistics, traceback
from collections import Counter, deque
from dataclasses import dataclass, field

# --- Simulator classes (Tier, Block, KVStore with instrumentation) ---
@dataclass
class Tier:
    name: str
    latency: float
    capacity: int = None
    members: set = field(default_factory=set)

@dataclass
class Block:
    key: int
    value: int = 0
    tier: str = None
    lock: threading.Lock = field(default_factory=threading.Lock)
    last_migrated_at: float = 0.0

class KVStore:
    def __init__(self, num_keys, tiers, config, metrics):
        self.blocks = {}
        self.tiers = tiers
        self.num_keys = num_keys
        self.config = config
        self.metrics = metrics
        self._init_blocks()
    def _init_blocks(self):
        hot_count = max(1, int(self.config["hot_fraction"] * self.num_keys))
        hot_keys = set(random.sample(range(self.num_keys), hot_count))
        for k in range(self.num_keys):
            if self.config["initial_placement"] == "hot_in_ddr" and k in hot_keys:
                tier_name = "DDR"
            else:
                tier_name = random.choices(["DDR", "CXL", "SSD"], weights=[0.2, 0.3, 0.5])[0]
            self.blocks[k] = Block(key=k, value=0, tier=tier_name)
            self.tiers[tier_name].members.add(k)
        self.hot_keys = hot_keys
    def access(self, key, op="r"):
        blk = self.blocks[key]
        tier = self.tiers[blk.tier]
        overhead = 0.0
        if blk.tier == "CXL":
            overhead = self.config.get("cxl_decompress_overhead", 0.0)
        access_time = tier.latency + overhead
        time.sleep(access_time)
        if op == "w":
            blk.value += 1
        return blk.tier, access_time
    def migrate_key(self, key, target_tier, now=None):
        if now is None:
            now = time.time()
        src = self.blocks[key].tier
        if src == target_tier:
            return 0.0, False
        copy_cost = self.tiers[src].latency + self.tiers[target_tier].latency
        if src == "CXL" or target_tier == "CXL":
            copy_cost += self.config.get("cxl_decompress_overhead", 0.0)
        time.sleep(copy_cost)
        self.tiers[src].members.discard(key)
        self.blocks[key].tier = target_tier
        self.tiers[target_tier].members.add(key)
        last = self.blocks[key].last_migrated_at
        ping = False
        if last and (now - last) < self.config.get("ping_pong_window_s", 1.0):
            ping = True
            self.metrics.ping_pongs += 1
        self.blocks[key].last_migrated_at = now
        self.metrics.migrations += 1
        if target_tier == "DDR":
            self.metrics.promotions += 1
        else:
            self.metrics.demotions += 1
        self.metrics.migration_time += copy_cost
        return copy_cost, ping

# --- Zipf sampler and workload generator ---
class ZipfSampler:
    def __init__(self, n, theta):
        self.n = n
        self.theta = theta
        ranks = list(range(1, n+1))
        weights = [1.0 / (r ** theta) for r in ranks]
        total = sum(weights)
        self.probs = [w/total for w in weights]
        c = 0.0
        self.cum = []
        for p in self.probs:
            c += p
            self.cum.append(c)
    def sample(self):
        u = random.random()
        lo, hi = 0, self.n-1
        while lo < hi:
            mid = (lo+hi)//2
            if self.cum[mid] >= u:
                hi = mid
            else:
                lo = mid+1
        return lo

class WorkloadGenerator:
    def __init__(self, num_keys, hot_keys, hot_fraction, hot_bias, zipf_theta=0.0, read_ratio=0.9):
        self.num_keys = num_keys
        self.hot_keys = hot_keys
        self.hot_fraction = hot_fraction
        self.hot_bias = hot_bias
        self.zipf_theta = zipf_theta
        self.read_ratio = read_ratio
        self.hot_list = list(hot_keys)
        self.cold_list = [k for k in range(num_keys) if k not in hot_keys]
        if zipf_theta and num_keys>1:
            self.zsampler = ZipfSampler(num_keys, zipf_theta)
        else:
            self.zsampler = None
    def sample_key_and_op(self):
        op = "r" if random.random() < self.read_ratio else "w"
        if self.zsampler:
            idx = self.zsampler.sample()
            return idx, op
        if self.hot_list and random.random() < self.hot_bias:
            return random.choice(self.hot_list), op
        else:
            return random.choice(self.cold_list) if self.cold_list else random.choice(self.hot_list), op

# --- Metrics & Simulator ---
class Metrics:
    def __init__(self):
        self.lock = threading.Lock()
        self.op_latencies = []
        self.lock_waits = []
        self.per_tier_counts = Counter()
        self.total_ops = 0
        self.migrations = 0
        self.promotions = 0
        self.demotions = 0
        self.migration_time = 0.0
        self.ping_pongs = 0
        self.ops_start_time = None
        self.ops_end_time = None
    def record_op(self, op_latency, lock_wait, tier):
        with self.lock:
            self.op_latencies.append(op_latency)
            self.lock_waits.append(lock_wait)
            self.per_tier_counts[tier] += 1
            self.total_ops += 1
    def snapshot(self):
        with self.lock:
            return {
                "ops": self.total_ops,
                "per_tier": dict(self.per_tier_counts),
                "latencies_ms": [x*1000 for x in self.op_latencies],
                "lock_waits_ms": [x*1000 for x in self.lock_waits],
                "migrations": self.migrations,
                "promotions": self.promotions,
                "demotions": self.demotions,
                "migration_time_s": self.migration_time,
                "ping_pongs": self.ping_pongs,
            }

class Simulator:
    def __init__(self, config, seed=42):
        random.seed(seed)
        self.config = config
        self.tiers = {
            "DDR": Tier("DDR", config["tier_latencies"]["DDR"]),
            "CXL": Tier("CXL", config["tier_latencies"]["CXL"]),
            "SSD": Tier("SSD", config["tier_latencies"]["SSD"]),
        }
        self.metrics = Metrics()
        self.kv = KVStore(config["num_keys"], self.tiers, config, self.metrics)
        self.wg = WorkloadGenerator(config["num_keys"], self.kv.hot_keys,
                                    config["hot_fraction"], config["hot_access_bias"],
                                    zipf_theta=config.get("zipf_theta",0.0),
                                    read_ratio=config.get("read_ratio",0.9))
        self.threads = []
        self.stop_flag = threading.Event()
        self.mode = config["mode"].upper()
        self.access_counter = Counter()
        self.access_counter_lock = threading.Lock()
        self.migrator_thread = None

    def worker(self, wid):
        cfg = self.config
        measure_after = cfg["measure_after_s"]
        while not self.stop_flag.is_set():
            key, op = self.wg.sample_key_and_op()
            t_request = time.time()
            blk = self.kv.blocks[key]
            t0 = time.time()
            acquired = blk.lock.acquire(timeout=1.0)
            t_acquire = time.time()
            lock_wait = t_acquire - t0 if acquired else 1.0
            with self.access_counter_lock:
                self.access_counter[key] += 1
            tier_name, access_time = self.kv.access(key, op=op)
            try:
                blk.lock.release()
            except Exception:
                pass
            t_done = time.time()
            op_latency = t_done - t_request
            if t_request >= (self.start_time + measure_after):
                self.metrics.record_op(op_latency, lock_wait, tier_name)
            time.sleep(random.random() * 0.0002)

    def start_workers(self):
        for i in range(self.config["num_threads"]):
            th = threading.Thread(target=self.worker, args=(i,), daemon=True)
            self.threads.append(th)
            th.start()

    def sampler_and_migrator(self):
        cfg = self.config
        interval = cfg["migration_interval_s"]
        recent_promoted = deque(maxlen=10000)
        while not self.stop_flag.is_set():
            time.sleep(interval)
            with self.access_counter_lock:
                snapshot = dict(self.access_counter)
                self.access_counter.clear()
            if not snapshot:
                continue
            top_k = sorted(snapshot.items(), key=lambda kv: kv[1], reverse=True)[:cfg["migration_batch"]]
            promoted = 0
            demoted = 0
            now = time.time()
            for key, cnt in top_k:
                if cnt >= cfg["migrate_threshold"] and self.kv.blocks[key].tier != "DDR":
                    blk = self.kv.blocks[key]
                    acquired = blk.lock.acquire(timeout=1.0)
                    try:
                        self.kv.migrate_key(key, "DDR", now=now)
                        recent_promoted.append((key, now))
                        promoted += 1
                    except Exception:
                        pass
                    finally:
                        if acquired:
                            try:
                                blk.lock.release()
                            except Exception:
                                pass
            ddr_members = list(self.tiers["DDR"].members)
            if ddr_members:
                sample_n = min(len(ddr_members), cfg.get("demotion_sample", 50))
                candidates = random.sample(ddr_members, sample_n)
                for key in candidates:
                    if snapshot.get(key, 0) < cfg.get("demote_threshold", 1):
                        blk = self.kv.blocks[key]
                        acquired = blk.lock.acquire(timeout=1.0)
                        try:
                            target = "CXL" if random.random() < 0.7 else "SSD"
                            self.kv.migrate_key(key, target, now=now)
                            demoted += 1
                        except Exception:
                            pass
                        finally:
                            if acquired:
                                try:
                                    blk.lock.release()
                                except Exception:
                                    pass
            if cfg.get("print_progress"):
                print(f"[migrator] promoted={promoted} demoted={demoted} top_k={len(top_k)}")

    def run(self):
        try:
            self.start_time = time.time()
            self.metrics.ops_start_time = self.start_time
            if self.mode == "TAL":
                self.migrator_thread = threading.Thread(target=self.sampler_and_migrator, daemon=True)
                self.migrator_thread.start()
            self.start_workers()
            total_dur = self.config["duration_s"]
            end_time = self.start_time + total_dur
            while time.time() < end_time:
                time.sleep(0.1)
            self.stop_flag.set()
            time.sleep(0.3)
            self.metrics.ops_end_time = time.time()
        except Exception:
            traceback.print_exc()
            self.stop_flag.set()

    def summarize(self):
        s = self.metrics.snapshot()
        total_ops = s["ops"]
        duration = max(1e-9, (self.metrics.ops_end_time - self.metrics.ops_start_time - self.config["measure_after_s"]))
        throughput = total_ops / duration if duration>0 else 0.0
        lat_ms = s["latencies_ms"]
        wait_ms = s["lock_waits_ms"]
        def pctile(arr, p):
            if not arr:
                return None
            arr_sorted = sorted(arr)
            k = (len(arr_sorted)-1) * (p/100.0)
            f = math.floor(k); c = math.ceil(k)
            if f==c:
                return arr_sorted[int(k)]
            d0 = arr_sorted[int(f)]*(c-k); d1 = arr_sorted[int(c)]*(k-f)
            return d0+d1
        p50 = pctile(lat_ms, 50)
        p95 = pctile(lat_ms, 95)
        p99 = pctile(lat_ms, 99)
        wait_p95 = pctile(wait_ms, 95)
        return {
            "mode": self.mode,
            "throughput": throughput,
            "p50_ms": p50,
            "p95_ms": p95,
            "p99_ms": p99,
            "lock_wait_p95_ms": wait_p95,
            "per_tier": s['per_tier'],
            "total_ops": total_ops,
            "migrations": s['migrations'],
            "promotions": s['promotions'],
            "demotions": s['demotions'],
            "migration_time_s": s['migration_time_s'],
            "ping_pongs": s['ping_pongs'],
        }

# --- Experiment harness and plotting ---
if __name__ == "__main__":
    import pandas as pd
    import matplotlib.pyplot as plt

    base_cfg = {
        "num_keys": 2000,
        "num_threads": 24,
        "duration_s": 8,
        "measure_after_s": 1.5,
        "hot_fraction": 0.05,
        "hot_access_bias": 0.9,
        "zipf_theta": 0.0,
        "read_ratio": 0.9,
        "tier_latencies": {"DDR": 0.00012, "CXL": 0.0008, "SSD": 0.0100},
        "cxl_decompress_overhead": 0.0004,
        "migration_interval_s": 0.5,
        "migration_batch": 200,
        "migrate_threshold": 8,
        "demote_threshold": 1,
        "demotion_sample": 60,
        "ping_pong_window_s": 0.8,
        "initial_placement": "random",
        "mode": "BASELINE",
        "print_progress": False,
    }

    results = []
    thread_values = [8, 24, 48]
    for threads in thread_values:
        for mode in ["BASELINE", "TAL"]:
            cfg = dict(base_cfg)
            cfg["num_threads"] = threads
            cfg["mode"] = mode
            print(f"Running threads={threads}, mode={mode}")
            sim = Simulator(cfg, seed=threads*17 + (0 if mode=="BASELINE" else 1))
            sim.run()
            res = sim.summarize()
            res.update({"num_threads": threads, "hot_fraction": cfg["hot_fraction"], "zipf_theta": cfg["zipf_theta"]})
            results.append(res)

    hot_values = [0.01, 0.05, 0.2]
    for hf in hot_values:
        for mode in ["BASELINE", "TAL"]:
            cfg = dict(base_cfg)
            cfg["hot_fraction"] = hf
            cfg["mode"] = mode
            cfg["zipf_theta"] = 0.8
            print(f"Running hot_fraction={hf}, mode={mode}, zipf_theta={cfg['zipf_theta']}")
            sim = Simulator(cfg, seed=int(hf*1000)+11)
            sim.run()
            res = sim.summarize()
            res.update({"num_threads": cfg["num_threads"], "hot_fraction": hf, "zipf_theta": cfg["zipf_theta"]})
            results.append(res)

    df = pd.DataFrame(results)
    print(df.to_string())

    # Save CSV for later analysis
    df.to_csv("tiered_sim_results.csv", index=False)

    # Simple plots
    plt.figure(figsize=(6,4))
    for mode in ["BASELINE", "TAL"]:
        sub = df[df['mode']==mode]
        plt.plot(sub['num_threads'], sub['throughput'], marker='o', label=mode)
    plt.xlabel("Number of worker threads")
    plt.ylabel("Throughput (ops/s)")
    plt.title("Throughput vs threads (BASELINE vs TAL)")
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    # plt.show()
    plt.savefig("plot_threads_throughput.png", dpi=150)
    plt.close()

    plt.figure(figsize=(6,4))
    for mode in ["BASELINE", "TAL"]:
        sub = df[df['mode']==mode]
        plt.plot(sub['num_threads'], sub['p95_ms'], marker='o', label=mode)
    plt.xlabel("Number of worker threads")
    plt.ylabel("p95 latency (ms)")
    plt.title("p95 latency vs threads")
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    # plt.show()
    plt.savefig("plot_threads_p95_latency.png", dpi=150)
    plt.close()


    # Plot promotions vs hot_fraction for TAL rows
    tal_rows = df[df['mode']=='TAL']
    if not tal_rows.empty:
        plt.figure(figsize=(6,4))
        plt.bar(tal_rows['hot_fraction'].astype(str), tal_rows['promotions'].astype(int))
        plt.xlabel("hot_fraction (TAL runs)")
        plt.ylabel("Promotions (count)")
        plt.title("Promotions observed in TAL runs (by hot_fraction)")
        plt.grid(True)
        plt.tight_layout()
        # plt.show()
        plt.savefig("plot_promotions_vs_hot_fraction.png", dpi=150)
        plt.close()

