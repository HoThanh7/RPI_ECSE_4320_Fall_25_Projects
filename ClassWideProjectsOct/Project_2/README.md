# Project 2: Cache & Memory Performance Profiling

## System Information
- **CPU:** AMD Ryzen 7 7800X3D  
- **Cores / Threads:** 8 cores / 16 threads  
- **L1 / L2 / L3 / DRAM configuration:**  
  - L1: 32 KB / core  
  - L2: 1 MB / core  
  - L3: 96 MB shared (3D V-Cache)  
  - DRAM: DDR5, measured latency ~76 ns  
- **OS:** [Your Linux distro & version]  
- **Kernel:** [Kernel version]  
- **MLC version:** 3.11b  
- **perf version:** [version]  
- **Other settings:** CPU governor, SMT state, prefetchers  

---

## Experimental Methodology
### Tools
- Intel Memory Latency Checker (MLC)  
- Linux `perf`  

### Experimental Knobs
1. **Access pattern / granularity:** sequential vs. random, strides ≈64B / 256B / 1024B  
2. **Read/write ratio:** 100%R, 100%W, 70/30, 50/50  
3. **Access intensity:** multiple outstanding requests or threads (MLC loaded-latency)  

### Procedure
- Pin threads using `taskset` or `numactl` to avoid interference  
- Warm-up runs to stabilize caches and CPU frequency  
- Repeat each measurement ≥3 times for mean ± std dev  
- Use hugepages where applicable (`/proc/sys/vm/nr_hugepages`)  
- Randomize experiment order  

---

## 1. Zero-Queue Baselines
### Commands
The following script will create an Idle_Latency.txt file and append results for the initial baseline test.
For the AMD Ryzen 7 7800x3D, the tests are configured with the size of each cache level.
```bash
echo "L1 Cache (64 KB per core)" > ../MLC_Tests/Idle_Latency.txt
sudo ./mlc --idle_latency -b64 >> ../MLC_Tests/Idle_Latency.txt

echo "L2 Cache (1 MB per core)" >> ../MLC_Tests/Idle_Latency.txt
sudo ./mlc --idle_latency -b1024 >> ../MLC_Tests/Idle_Latency.txt

echo "L3 Cache (96 MB shared)" >> ../MLC_Tests/Idle_Latency.txt
sudo ./mlc --idle_latency -b98304 >> ../MLC_Tests/Idle_Latency.txt

echo "DRAM (~1.8 GB)" >> ../MLC_Tests/Idle_Latency.txt
sudo ./mlc --idle_latency -b1800000 >> ../MLC_Tests/Idle_Latency.txt
```
