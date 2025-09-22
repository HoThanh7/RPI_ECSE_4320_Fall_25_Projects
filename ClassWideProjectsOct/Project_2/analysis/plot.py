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
