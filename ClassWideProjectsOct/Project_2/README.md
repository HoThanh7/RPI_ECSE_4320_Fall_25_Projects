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
Run the following script to researve hugepages for the memory latency checker to be able to perform well:
```bash
echo 4000 | sudo tee /proc/sys/vm/nr_hugepages
```
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
The result written to the Idle_Latency.txt is:
```
L1 Cache (64 KB per core)
Intel(R) Memory Latency Checker - v3.11b
Command line parameters: --idle_latency -b64

Using buffer size of 0.062MiB
Each iteration took 12.2 base frequency clocks (        2.9     ns)

L2 Cache (1 MB per core)
Intel(R) Memory Latency Checker - v3.11b
Command line parameters: --idle_latency -b1024

Using buffer size of 1.000MiB
Each iteration took 30.9 base frequency clocks (        7.4     ns)

L3 Cache (96 MB shared)
Intel(R) Memory Latency Checker - v3.11b
Command line parameters: --idle_latency -b98304

Using buffer size of 96.000MiB
Each iteration took 55.1 base frequency clocks (        13.1    ns)

DRAM (~1.8 GB)
Intel(R) Memory Latency Checker - v3.11b
Command line parameters: --idle_latency -b1800000

Using buffer size of 1757.812MiB
Each iteration took 318.3 base frequency clocks (       75.8    ns)
```

## 2. Pattern & granularity sweep
### Commands

The following script will run the strides with idle latency
```bash
# L1-size footprint (use ~32KB or 64KB)
sudo ./mlc --idle_latency -b32      > mlc_idle_b32_seq.txt 2>&1
sudo ./mlc --idle_latency -b32 -r   > mlc_idle_b32_rand.txt 2>&1

# L2 footprint (~256 KB)
sudo ./mlc --idle_latency -b256     > mlc_idle_b256_seq.txt 2>&1
sudo ./mlc --idle_latency -b256 -r  > mlc_idle_b256_rand.txt 2>&1

# L3 footprint (~96 MB on your CPU) — pick slightly under or the full size:
sudo ./mlc --idle_latency -b98304   > mlc_idle_b98304_seq.txt 2>&1
sudo ./mlc --idle_latency -b98304 -r> mlc_idle_b98304_rand.txt 2>&1

# DRAM (1.8 GB)
sudo ./mlc --idle_latency -b1800000 > mlc_idle_b1800000_seq.txt 2>&1
sudo ./mlc --idle_latency -b1800000 -r> mlc_idle_b1800000_rand.txt 2>&1
```

The following script is for loaded latency tests

<!--
```bash
# 64B stride (typical cacheline)
sudo ./mlc --loaded_latency -l64 -t5 -W5 > mlc_loaded_l64_1to1.txt 2>&1

# 256B stride
sudo ./mlc --loaded_latency -l256 -t5 -W5 > mlc_loaded_l256_1to1.txt 2>&1

# 1024B stride
sudo ./mlc --loaded_latency -l1024 -t5 -W5 > mlc_loaded_l1024_1to1.txt 2>&1
```
-->

```bash
# Sequential, 64B stride (default cache line)
sudo ./mlc --loaded_latency -l64 > ../MLC_Tests/SeqLoaded/Seq64B.txt

# Sequential, 256B stride
sudo ./mlc --loaded_latency -l256 > ../MLC_Tests/SeqLoaded/Seq256B.txt

# Sequential, 1024B stride
sudo ./mlc --loaded_latency -l1024 > ../MLC_Tests/SeqLoaded/Seq1024B.txt

# Random access, 64B stride
sudo ./mlc --loaded_latency -l64 -r > ../MLC_Tests/RandLoaded/Rand64B.txt

# Random access, 256B stride
sudo ./mlc --loaded_latency -l256 -r > ../MLC_Tests/RandLoaded/Rand256B.txt

# Random access, 1024B stride
sudo ./mlc --loaded_latency -l1024 -r > ../MLC_Tests/RandLoaded/Rand1024B.txt
```

Peak streaming badnwidth matrix
```bash
sudo ./mlc --bandwidth_matrix > ../MLC_Tests/bandwidth_matrix.txt
```

## 3. Read/Write mix sweep
### Commands

```bash
# 100% read
sudo ./mlc --peak_injection_bandwidth -R

# 100% write
sudo ./mlc --peak_injection_bandwidth -W6

# 70/30 (≈2:1)
sudo ./mlc --peak_injection_bandwidth -W2

# 50/50
sudo ./mlc --peak_injection_bandwidth -W5
```