#!/usr/bin/env bash
set -euo pipefail
# collect_perf_counters.sh
# Usage: ./collect_perf_counters.sh <output-file> -- <command to profile>

OUTFILE="$1"
shift
if [[ "$1" != "--" ]]; then
  echo "Usage: $0 <output-file> -- <command>"
  exit 1
fi
shift
CMD=("$@")

echo "Running: ${CMD[*]} and collecting perf counters to $OUTFILE"

# Example events: LLC-load-misses, LLC-loads, dTLB-load-misses, cycles, instructions
perf stat -e cache-references,cache-misses,LLC-loads,LLC-load-misses,dTLB-loads,dTLB-load-misses,cycles,instructions -o "$OUTFILE" -- "${CMD[@]}"

echo "Perf data saved to $OUTFILE"
