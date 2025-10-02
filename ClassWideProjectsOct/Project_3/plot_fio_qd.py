#!/usr/bin/env python3
"""plot_fio_qd.py

Generate a throughput vs latency trade-off curve from Project_3/fio-results.csv for qd sweep
(jobs like qd_1, qd_2, ..., qd_128). Detect the knee using max-distance-to-chord method and
compare to Little's Law: Concurrency ≈ Throughput (IOPS) * Latency (s).

Produces:
- Project_3/plots/qd_tradeoff.png
- Project_3/plots/qd_little_law.txt

Usage: python3 plot_fio_qd.py
"""
from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import re
import sys

ROOT = Path(__file__).resolve().parent
CSV = ROOT / 'fio-results.csv'
OUT = ROOT / 'plots'
OUT.mkdir(exist_ok=True)

if not CSV.exists():
    print('Missing', CSV)
    sys.exit(1)

df = pd.read_csv(CSV)

# select qd rows
qd_df = df[df['job'].str.startswith('qd_')].copy()
if qd_df.empty:
    print('No qd_* rows found in', CSV)
    sys.exit(1)

def parse_qd(jobname: str):
    m = re.match(r'qd_(\d+)', jobname)
    return int(m.group(1)) if m else None

qd_df['qd'] = qd_df['job'].apply(parse_qd)
qd_df = qd_df.dropna(subset=['qd'])
qd_df['qd'] = qd_df['qd'].astype(int)

# Use throughput in MiB/s and latency in us
qd_df['bw_mib'] = pd.to_numeric(qd_df['bw_mib'], errors='coerce')
qd_df['iops'] = pd.to_numeric(qd_df['iops'], errors='coerce')
qd_df['lat_us'] = pd.to_numeric(qd_df['latency_mean_us'], errors='coerce')

# Sort by qd number
qd_df = qd_df.sort_values('qd')

# For tradeoff plot we'll use bandwidth (MiB/s) on x and latency (us) on y
x = qd_df['bw_mib'].values
y = qd_df['lat_us'].values
labels = qd_df['qd'].astype(str).values

# Remove NaNs
mask = ~np.isnan(x) & ~np.isnan(y)
x = x[mask]
y = y[mask]
labels = labels[mask]

if len(x) < 2:
    print('Not enough points for tradeoff plot')
    sys.exit(1)

# Ensure monotonic x for chord method: sort by x
order = np.argsort(x)
x = x[order]
y = y[order]
labels = labels[order]

def find_knee(x, y):
    # chord from first to last
    x0, y0 = x[0], y[0]
    x1, y1 = x[-1], y[-1]
    # normalize to avoid scale issues
    dx = x1 - x0
    dy = y1 - y0
    if dx == 0 and dy == 0:
        return 0
    # compute distance of each point to the chord
    distances = np.abs(dy*(x - x0) - dx*(y - y0)) / np.hypot(dy, dx)
    idx = int(np.argmax(distances))
    return idx

knee_idx = find_knee(x, y)
knee_x = x[knee_idx]
knee_y = y[knee_idx]

# Little's Law: concurrency_est = IOPS * latency_s
lat_s = qd_df['lat_us'].values / 1e6
iops_vals = qd_df['iops'].values
concurrency_est = iops_vals * lat_s

# Compute table for summary
summary_lines = []
summary_lines.append('qd,iops,bw_mib,lat_us,concurrency_est,qd_ratio')
for qd,iopsv,bwv,latv,conc in zip(qd_df['qd'].values, iops_vals, qd_df['bw_mib'].values, qd_df['lat_us'].values, concurrency_est):
    ratio = conc / qd if qd != 0 else float('nan')
    summary_lines.append(f"{qd},{iopsv:.2f},{bwv:.2f},{latv:.3f},{conc:.3f},{ratio:.3f}")

# Write summary
summary_path = OUT / 'qd_little_law.txt'
summary_path.write_text('\n'.join(summary_lines))
print('Wrote', summary_path)

# Plot trade-off: bandwidth vs latency
plt.figure(figsize=(8,5))
plt.plot(x, y, marker='o', linestyle='-')
for xi, yi, lab in zip(x, y, labels):
    plt.annotate(lab, (xi, yi), textcoords='offset points', xytext=(5,5))
plt.scatter([knee_x], [knee_y], color='red', zorder=5, label=f'knee (qd={labels[knee_idx]})')
plt.xlabel('Throughput (MiB/s)')
plt.ylabel('Latency mean (µs)')
plt.title('QD sweep: throughput vs latency trade-off')
plt.grid(True, which='both', linestyle='--', linewidth=0.4, alpha=0.6)
plt.legend()
outp = OUT / 'qd_tradeoff.png'
plt.tight_layout()
plt.savefig(outp, dpi=150)
plt.close()
print('Saved', outp)

print('Knee detected at qd=', labels[knee_idx], 'throughput=', knee_x, 'MiB/s, latency=', knee_y, 'us')
print('Summary saved to', summary_path)
