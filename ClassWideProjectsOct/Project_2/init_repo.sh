#!/usr/bin/env bash
set -euo pipefail

echo "Initializing repo scaffold in $(pwd)..."

# directories
mkdir -p kernels scripts data/scalar data/simd analysis build/reports bin asm

#############################
# Makefile
#############################
cat > Makefile <<'EOF'
CC = gcc
SRCDIR = kernels
BINDIR = bin
ASMDIR = asm
REPORTDIR = build/reports
CFLAGS_COMMON = -D_POSIX_C_SOURCE=200112L -Wall -Wextra -std=c11
CFLAGS_SCALAR = -O0 -fno-tree-vectorize $(CFLAGS_COMMON)
CFLAGS_SIMD   = -O3 -march=native -ffast-math -funroll-loops $(CFLAGS_COMMON)
LDFLAGS =

KERNELS = saxpy dot element

.PHONY: all scalar simd clean asm dirs

all: dirs scalar simd

dirs:
    mkdir -p $(BINDIR) $(ASMDIR) $(REPORTDIR)

# scalar: builds *_scalar executables
scalar: dirs $(patsubst %,$(BINDIR)/%_scalar,$(KERNELS))

# simd: builds *_simd executables and emits vec reports + assembly
simd: dirs $(patsubst %,$(BINDIR)/%_simd,$(KERNELS))

$(BINDIR)/%_scalar: $(SRCDIR)/%.c
	$(CC) $(CFLAGS_SCALAR) $< -o $@ $(LDFLAGS)

$(BINDIR)/%_simd: $(SRCDIR)/%.c
	$(CC) $(CFLAGS_SIMD) $< -o $@ \
		-fopt-info-vec-optimized=$(REPORTDIR)/$*_vec.txt $(LDFLAGS)
	$(CC) $(CFLAGS_SIMD) -S $< -o $(ASMDIR)/$*_simd.s


asm: dirs
    @echo "asm dir: $(ASMDIR)"

clean:
    rm -rf $(BINDIR) $(ASMDIR) $(REPORTDIR) data/*.csv
EOF

#############################
# kernels/saxpy.c
#############################
cat > kernels/saxpy.c <<'EOF'
#define _POSIX_C_SOURCE 200112L
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

/**
 * saxpy_scalar - baseline scalar implementation of SAXPY
 * @a: scalar multiplier
 * @x: input array of floats
 * @y: in/out array of floats (modified in place)
 * @n: number of elements
 *
 * Performs y[i] = a*x[i] + y[i] for i = 0..n-1
 */
void saxpy_scalar(float a, const float *x, float *y, size_t n) {
    for (size_t i = 0; i < n; i++) {
        y[i] = a * x[i] + y[i];
    }
}

static inline double wall_time_s(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + ts.tv_nsec * 1e-9;
}

int main(int argc, char **argv) {
    size_t n = (argc > 1) ? strtoull(argv[1], NULL, 10) : 10000000;
    float a = 2.5f;

    float *x = NULL, *y = NULL;
    if (posix_memalign((void**)&x, 64, n * sizeof(float)) != 0 ||
        posix_memalign((void**)&y, 64, n * sizeof(float)) != 0) {
        perror("posix_memalign failed");
        return 1;
    }

    srand(42);
    for (size_t i = 0; i < n; ++i) {
        x[i] = (float)rand() / RAND_MAX;
        y[i] = (float)rand() / RAND_MAX;
    }

    // Warm-up
    saxpy_scalar(a, x, y, n);

    double t0 = wall_time_s();
    saxpy_scalar(a, x, y, n);
    double t1 = wall_time_s();

    double seconds = t1 - t0;
    double flops = 2.0 * (double)n; // 1 mul + 1 add per element
    double gflops = (flops / seconds) / 1e9;

    // checksum to prevent optimizer removing loop
    double checksum = 0.0;
    for (size_t i = 0; i < n; ++i) checksum += y[i];

    // CSV row: kernel,n,time_s,gflops,checksum
    printf("saxpy,%zu,%.9f,%.6f,%.6e\n", n, seconds, gflops, checksum);

    free(x);
    free(y);
    return 0;
}
EOF

#############################
# kernels/dot.c
#############################
cat > kernels/dot.c <<'EOF'
#define _POSIX_C_SOURCE 200112L
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

/**
 * dot - dot product reduction s = sum_i x[i]*y[i]
 */
float dot_scalar(const float *x, const float *y, size_t n) {
    float s = 0.0f;
    for (size_t i = 0; i < n; ++i) s += x[i] * y[i];
    return s;
}

static inline double wall_time_s(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + ts.tv_nsec * 1e-9;
}

int main(int argc, char **argv) {
    size_t n = (argc > 1) ? strtoull(argv[1], NULL, 10) : 10000000;

    float *x = NULL, *y = NULL;
    if (posix_memalign((void**)&x, 64, n * sizeof(float)) != 0 ||
        posix_memalign((void**)&y, 64, n * sizeof(float)) != 0) {
        perror("posix_memalign failed");
        return 1;
    }

    srand(42);
    for (size_t i = 0; i < n; ++i) {
        x[i] = (float)rand() / RAND_MAX;
        y[i] = (float)rand() / RAND_MAX;
    }

    // warmup
    volatile float warm = dot_scalar(x, y, n);
    (void)warm;

    double t0 = wall_time_s();
    float s = dot_scalar(x, y, n);
    double t1 = wall_time_s();

    double seconds = t1 - t0;
    double flops = 2.0 * (double)n; // each iteration: 1 mul + 1 add
    double gflops = (flops / seconds) / 1e9;

    // print checkpoint checksum and timing
    double checksum = 0.0;
    for (size_t i = 0; i < n; ++i) checksum += y[i];

    printf("dot,%zu,%.9f,%.6f,%.6e\n", n, seconds, gflops, checksum);

    free(x);
    free(y);
    return 0;
}
EOF

#############################
# kernels/element.c
#############################
cat > kernels/element.c <<'EOF'
#define _POSIX_C_SOURCE 200112L
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/**
 * element - elementwise multiply z[i] = x[i] * y[i]
 */
void element_scalar(float *z, const float *x, const float *y, size_t n) {
    for (size_t i = 0; i < n; ++i) z[i] = x[i] * y[i];
}

static inline double wall_time_s(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + ts.tv_nsec * 1e-9;
}

int main(int argc, char **argv) {
    size_t n = (argc > 1) ? strtoull(argv[1], NULL, 10) : 10000000;
    float *x = NULL, *y = NULL, *z = NULL;
    if (posix_memalign((void**)&x, 64, n * sizeof(float)) != 0 ||
        posix_memalign((void**)&y, 64, n * sizeof(float)) != 0 ||
        posix_memalign((void**)&z, 64, n * sizeof(float)) != 0) {
        perror("posix_memalign failed");
        return 1;
    }

    srand(42);
    for (size_t i = 0; i < n; ++i) {
        x[i] = (float)rand() / RAND_MAX;
        y[i] = (float)rand() / RAND_MAX;
        z[i] = 0.0f;
    }

    element_scalar(z, x, y, n); // warmup

    double t0 = wall_time_s();
    element_scalar(z, x, y, n);
    double t1 = wall_time_s();

    double seconds = t1 - t0;
    double flops = 1.0 * (double)n; // 1 mul per element
    double gflops = (flops / seconds) / 1e9;

    double checksum = 0.0;
    for (size_t i = 0; i < n; ++i) checksum += z[i];

    printf("element,%zu,%.9f,%.6f,%.6e\n", n, seconds, gflops, checksum);

    free(x);
    free(y);
    free(z);
    return 0;
}
EOF

#############################
# scripts/env_setup.sh
#############################
cat > scripts/env_setup.sh <<'EOF'
#!/usr/bin/env bash
# Set system to "performance" governor and optionally turn SMT off.
# Run with sudo: sudo ./env_setup.sh
set -euo pipefail

echo "Setting CPU governor to performance for all online CPUs..."
if [ -d /sys/devices/system/cpu ]; then
  for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
    gov="$cpu/cpufreq/scaling_governor"
    if [ -f "$gov" ]; then
      echo performance > "$gov" || echo "failed to set $gov (you might need cpupower/permissions)"
    fi
  done
fi

# Optional: disable SMT (hyperthreading)
if [ -w /sys/devices/system/cpu/smt/control ]; then
  echo "Disabling SMT (writing 'off' to /sys/devices/system/cpu/smt/control)..."
  echo off > /sys/devices/system/cpu/smt/control
else
  echo "SMT control not available on this system or requires different method. Skipping."
fi

echo "Environment setup done. Remember to re-enable SMT / change governor back when finished."
EOF
chmod +x scripts/env_setup.sh

#############################
# scripts/run_kernels.sh
#############################
cat > scripts/run_kernels.sh <<'EOF'
#!/usr/bin/env bash
# Compile (make) and run kernel sweeps, producing CSVs in data/.
# Usage: ./run_kernels.sh [pin_core] [repeats]
set -euo pipefail

PIN_CORE="${1:-0}"
REPEATS="${2:-3}"

echo "Compiling (make all)..."
make -j

KERNELS=("saxpy" "dot" "element")
SIZES=(1024 2048 4096 8192 16384 32768 65536 131072 262144 524288 1048576 2097152 4194304)

# create CSV headers
for variant in scalar simd; do
  for k in "${KERNELS[@]}"; do
    out="data/${variant}/${k}.csv"
    mkdir -p "$(dirname "$out")"
    echo "kernel,n,time_s,gflops,checksum" > "$out"
  done
done

for variant in scalar simd; do
  for k in "${KERNELS[@]}"; do
    exe="bin/${k}_${variant}"
    if [ ! -x "$exe" ]; then
      echo "Executable $exe not found; skipping."
      continue
    fi

    out="data/${variant}/${k}.csv"
    echo "Running $exe (writing to $out)"
    for n in "${SIZES[@]}"; do
      for ((r=0;r<REPEATS;++r)); do
        # pin to core with taskset for reproducibility
        cmd=(taskset -c "$PIN_CORE" "$exe" "$n")
        # capture the CSV line printed by the binary and append to file
        "${cmd[@]}" >> "$out"
      done
    done
  done
done

echo "All runs complete. CSV files live in data/ (data/scalar and data/simd)."
EOF
chmod +x scripts/run_kernels.sh

#############################
# scripts/collect_perf.sh
#############################
cat > scripts/collect_perf.sh <<'EOF'
#!/usr/bin/env bash
# Run perf stat while executing a kernel once.
# Usage: sudo ./collect_perf.sh <binary> <n> [pin_core]
set -euo pipefail
if ! command -v perf >/dev/null 2>&1; then
  echo "perf not found. Install 'perf' or linux-tools package and run again."
  exit 1
fi

BIN="${1:-}"
N="${2:-1000000}"
PIN="${3:-0}"

if [ -z "$BIN" ]; then
  echo "Usage: $0 <binary> <n> [pin_core]"
  exit 1
fi

OUT="data/perf_$(basename "$BIN")_${N}.txt"
echo "Running perf stat on $BIN (n=$N) -> $OUT"
sudo perf stat -e cycles,instructions,cache-references,cache-misses,LLC-loads,LLC-load-misses -x, -o "$OUT" -- taskset -c "$PIN" "$BIN" "$N"
echo "perf output -> $OUT"
EOF
chmod +x scripts/collect_perf.sh

#############################
# analysis/plot.py
#############################
cat > analysis/plot.py <<'EOF'
#!/usr/bin/env python3
"""
Simple plotter: read data/scalar/<kernel>.csv and data/simd/<kernel>.csv and plot GFLOP/s vs n.
Requires: pandas, matplotlib
Usage: python3 analysis/plot.py saxpy
"""
import sys
import os
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

if len(sys.argv) < 2:
    print("Usage: python3 analysis/plot.py <kernel> [out.png]")
    sys.exit(1)

kernel = sys.argv[1]
out = sys.argv[2] if len(sys.argv) > 2 else f"analysis/{kernel}_gflops.png"

scalar_file = f"data/scalar/{kernel}.csv"
simd_file   = f"data/simd/{kernel}.csv"

if not os.path.exists(scalar_file) or not os.path.exists(simd_file):
    print("Missing CSVs. Run scripts/run_kernels.sh first.")
    sys.exit(1)

df_s = pd.read_csv(scalar_file, names=["kernel","n","time_s","gflops","checksum"], header=0)
df_v = pd.read_csv(simd_file,   names=["kernel","n","time_s","gflops","checksum"], header=0)

agg_s = df_s.groupby("n")["gflops"].agg(['median','std','count']).reset_index()
agg_v = df_v.groupby("n")["gflops"].agg(['median','std','count']).reset_index()

plt.figure(figsize=(8,5))
plt.errorbar(agg_s['n'], agg_s['median'], yerr=agg_s['std'], label='scalar', marker='o', linestyle='-')
plt.errorbar(agg_v['n'], agg_v['median'], yerr=agg_v['std'], label='simd', marker='s', linestyle='--')
plt.xscale('log', base=2)
plt.xlabel("N (log2 scale)")
plt.ylabel("GFLOP/s")
plt.title(f"{kernel} : scalar vs simd")
plt.legend()
plt.grid(True, which='both', ls='--', alpha=0.5)
plt.tight_layout()
plt.savefig(out, dpi=150)
print("Saved plot to", out)
EOF
chmod +x analysis/plot.py

#############################
# README.md
#############################
cat > README.md <<'EOF'
# mem-bench-project (scaffold)

This repo contains kernel microbenchmarks (SAXPY, dot, elementwise multiply), build scripts,
run scripts and a simple plotting helper. Designed to be developed on laptop and run
(for final measurements) on an Arch Linux desktop.

## Quick start (dev machine)
1. `make`
2. `./scripts/run_kernels.sh`  # runs default sweep and writes CSVs to data/
3. `python3 analysis/plot.py saxpy`  # produce plot

## On Arch Linux (recommended for Project 2 real runs)
1. `sudo ./scripts/env_setup.sh`
2. `make`
3. `./scripts/run_kernels.sh 0 5`  # pin to core 0, 5 repeats
4. Use `sudo ./scripts/collect_perf.sh bin/saxpy_simd 1048576 0` to gather perf counters.

## Notes
* Edit `scripts/run_kernels.sh` to change sizes, kernel list, repeats and the pinned core.
* Vectorization reports for simd builds are written to `build/reports/*.vec.txt`.
EOF

#############################
# .gitignore
#############################
cat > .gitignore <<'EOF'
/bin/
/asm/
/build/
/data/
/*.pyc
*.o
*~
EOF

chmod +x scripts/run_kernels.sh scripts/collect_perf.sh

echo "Repo scaffold created in $(pwd)"
echo ""
echo "Next steps:"
echo "  make"
echo "  sudo ./scripts/env_setup.sh   # on the Arch desktop"
echo "  ./scripts/run_kernels.sh      # run sweeps"