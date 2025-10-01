#!/bin/bash
# Project 3: SSD Performance Profiling (Steps 1–4)
# Usage: ./Task1_4.sh <testfile> <output_dir>
# Example: ./Task1_4.sh ~/fio-tests/testfile results/

TESTFILE=$1
OUTDIR=$2

mkdir -p "$OUTDIR"

# Global settings
RUNTIME=30
SIZE=10G
ENGINE=libaio
DIRECT=1
NUMJOBS=1

# -----------------------------
# 1. Zero-queue baselines (QD=1)
# -----------------------------
echo "Running zero-queue baselines..."
for RW in randread randwrite read write; do
    for BS in 4k 128k; do
        fio --name=baseline_${RW}_${BS} \
            --filename=$TESTFILE \
            --rw=$RW --bs=$BS \
            --ioengine=$ENGINE --iodepth=1 \
            --direct=$DIRECT --size=$SIZE \
            --runtime=$RUNTIME --numjobs=$NUMJOBS \
            --time_based --group_reporting \
            --output-format=json \
            --output=${OUTDIR}/baseline_${RW}_${BS}.json
    done
done

# -----------------------------
# 2. Block-size sweep
# -----------------------------
echo "Running block-size sweeps..."
BLOCK_SIZES="4k 16k 32k 64k 128k 256k"
for PATTERN in randread read; do
    for BS in $BLOCK_SIZES; do
        fio --name=bsweep_${PATTERN}_${BS} \
            --filename=$TESTFILE \
            --rw=$PATTERN --bs=$BS \
            --ioengine=$ENGINE --iodepth=1 \
            --direct=$DIRECT --size=$SIZE \
            --runtime=$RUNTIME --numjobs=$NUMJOBS \
            --time_based --group_reporting \
            --output-format=json \
            --output=${OUTDIR}/bsweep_${PATTERN}_${BS}.json
    done
done

# -----------------------------
# 3. Read/Write mix sweep (4K random)
# -----------------------------
echo "Running R/W mix sweeps..."
for MIX in 100 70 50; do
    fio --name=mix_${MIX}r \
        --filename=$TESTFILE \
        --rw=randrw --rwmixread=$MIX \
        --bs=4k \
        --ioengine=$ENGINE --iodepth=1 \
        --direct=$DIRECT --size=$SIZE \
        --runtime=$RUNTIME --numjobs=$NUMJOBS \
        --time_based --group_reporting \
        --output-format=json \
        --output=${OUTDIR}/mix_${MIX}r.json
done

# -----------------------------
# 4. Queue-depth sweep
# -----------------------------
echo "Running queue-depth sweeps..."
QDEPTHS="1 2 4 8 16 32 64 128"
for QD in $QDEPTHS; do
    fio --name=qd_${QD} \
        --filename=$TESTFILE \
        --rw=randread --bs=4k \
        --ioengine=$ENGINE --iodepth=$QD \
        --direct=$DIRECT --size=$SIZE \
        --runtime=$RUNTIME --numjobs=$NUMJOBS \
        --time_based --group_reporting \
        --output-format=json \
        --output=${OUTDIR}/qd_${QD}.json
done

echo "All tests complete. Results saved to $OUTDIR/"
