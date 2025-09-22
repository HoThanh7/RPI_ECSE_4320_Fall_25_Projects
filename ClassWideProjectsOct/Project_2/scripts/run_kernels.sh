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
