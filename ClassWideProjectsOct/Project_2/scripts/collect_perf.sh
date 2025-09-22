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
