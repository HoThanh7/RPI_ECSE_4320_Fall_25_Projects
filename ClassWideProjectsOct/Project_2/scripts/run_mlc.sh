#!/usr/bin/env bash
set -euo pipefail
# run_mlc.sh
# Helper to run MLC tests for Project 2. Adjust paths and parameters as needed.

OUT_DIR=${1:-../MLC_Results}
mkdir -p "$OUT_DIR"

# Zero-queue baselines (idle latency)
echo "Running zero-queue baselines (L1/L2/L3/DRAM)"
sudo ./mlc --idle_latency -b64 > "$OUT_DIR"/idle_L1.txt
sudo ./mlc --idle_latency -b1024 > "$OUT_DIR"/idle_L2.txt
sudo ./mlc --idle_latency -b98304 > "$OUT_DIR"/idle_L3.txt
sudo ./mlc --idle_latency -b1800000 > "$OUT_DIR"/idle_DRAM.txt

echo "Pattern & granularity sweep (loaded latency & bandwidth_matrix)"
# Example loaded-latency runs for strides / granularities
sudo ./mlc --loaded_latency -l64 > "$OUT_DIR"/loaded_l64_seq.txt
sudo ./mlc --loaded_latency -l64 -r > "$OUT_DIR"/loaded_l64_rand.txt
sudo ./mlc --loaded_latency -l256 > "$OUT_DIR"/loaded_l256_seq.txt
sudo ./mlc --loaded_latency -l256 -r > "$OUT_DIR"/loaded_l256_rand.txt
sudo ./mlc --loaded_latency -l1024 > "$OUT_DIR"/loaded_l1024_seq.txt
sudo ./mlc --loaded_latency -l1024 -r > "$OUT_DIR"/loaded_l1024_rand.txt

echo "Bandwidth matrix (peak streaming bandwidth)"
sudo ./mlc --bandwidth_matrix > "$OUT_DIR"/bandwidth_matrix.txt

echo "Done. Results in $OUT_DIR"
