#!/usr/bin/env bash
set -euo pipefail
# run_mlc.sh
# Helper to run MLC tests for Project 2. Adjust paths and parameters as needed.

DEFAULT_OUT_DIR="../MLC_Results"
OUT_DIR="$DEFAULT_OUT_DIR"
MLC_BIN=${MLC_BIN:-}

# Locate MLC: prefer MLC_BIN env var, then look in PATH, otherwise default to ./mlc
if [[ -n "$MLC_BIN" ]]; then
	: # user provided MLC_BIN
else
	if command -v mlc >/dev/null 2>&1; then
		MLC_BIN=$(command -v mlc)
	else
		MLC_BIN=./mlc
	fi
fi

# Validate MLC binary exists and is executable
if [[ ! -x "$MLC_BIN" ]]; then
	echo "MLC binary not found or not executable: $MLC_BIN"
	echo "Set MLC_BIN to the full path of the mlc binary or ensure 'mlc' is in your PATH."
	echo "Example: MLC_BIN=/path/to/mlc $0 results_dir"
	exit 2
fi

usage() {
		cat <<EOF
Usage: $0 [OPTIONS] [out_dir]

Runs MLC experiments and writes results into out_dir (default: ../MLC_Results).
Options:
  -m, --mlc PATH    Path to the mlc binary (overrides MLC_BIN env)
  -h, --help        Show this help and exit

Examples:
  MLC_BIN=/path/to/mlc $0 results_dir
  $0 -m /path/to/mlc results_dir
  $0 --mlc /opt/mlc/bin/mlc

If neither MLC_BIN nor --mlc is provided the script will look for 'mlc' in PATH
and finally fall back to ./mlc.
EOF
}

OUT_DIR_SET=0
while [[ $# -gt 0 ]]; do
	case "$1" in
		-m|--mlc)
			if [[ -z "${2:-}" ]]; then
				echo "Error: $1 requires an argument"
				usage
				exit 1
			fi
			MLC_BIN="$2"
			shift 2
			;;
		-h|--help)
			usage
			exit 0
			;;
		--)
			shift
			break
			;;
		-*)
			echo "Unknown option: $1"
			usage
			exit 1
			;;
		*)
			if [[ $OUT_DIR_SET -eq 0 ]]; then
				OUT_DIR="$1"
				OUT_DIR_SET=1
				shift
			else
				echo "Unexpected argument: $1"
				usage
				exit 1
			fi
			;;
	esac
done

mkdir -p "$OUT_DIR"

# Zero-queue baselines (idle latency)
echo "Running zero-queue baselines (L1/L2/L3/DRAM) using $MLC_BIN"
sudo "$MLC_BIN" --idle_latency -b64 > "$OUT_DIR"/idle_L1.txt
sudo "$MLC_BIN" --idle_latency -b1024 > "$OUT_DIR"/idle_L2.txt
sudo "$MLC_BIN" --idle_latency -b98304 > "$OUT_DIR"/idle_L3.txt
sudo "$MLC_BIN" --idle_latency -b1800000 > "$OUT_DIR"/idle_DRAM.txt

echo "Pattern & granularity sweep (loaded latency & bandwidth_matrix)"
# Example loaded-latency runs for strides / granularities
sudo "$MLC_BIN" --loaded_latency -l64 > "$OUT_DIR"/loaded_l64_seq.txt
sudo "$MLC_BIN" --loaded_latency -l64 -r > "$OUT_DIR"/loaded_l64_rand.txt
sudo "$MLC_BIN" --loaded_latency -l256 > "$OUT_DIR"/loaded_l256_seq.txt
sudo "$MLC_BIN" --loaded_latency -l256 -r > "$OUT_DIR"/loaded_l256_rand.txt
sudo "$MLC_BIN" --loaded_latency -l1024 > "$OUT_DIR"/loaded_l1024_seq.txt
sudo "$MLC_BIN" --loaded_latency -l1024 -r > "$OUT_DIR"/loaded_l1024_rand.txt

echo "Bandwidth matrix (peak streaming bandwidth)"
sudo "$MLC_BIN" --bandwidth_matrix > "$OUT_DIR"/bandwidth_matrix.txt

echo "Done. Results in $OUT_DIR"
