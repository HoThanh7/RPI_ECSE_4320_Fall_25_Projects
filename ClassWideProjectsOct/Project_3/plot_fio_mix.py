#!/usr/bin/env python3
"""plot_fio_mix.py

Reads Project_3/fio-results.csv and plots throughput and mean latency for mix_100r,
mix_70r, mix_50r (and optionally mix_100w if present). Saves PNGs to Project_3/plots.
"""
from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt
import sys

ROOT = Path(__file__).resolve().parent
CSV = ROOT / 'fio-results.csv'
OUTDIR = ROOT / 'plots'
OUTDIR.mkdir(exist_ok=True)

if not CSV.exists():
    print('Missing', CSV)
    sys.exit(1)

df = pd.read_csv(CSV)

# select mix rows
mix_keys = ['mix_100r','mix_100w','mix_70r','mix_50r']
mix = df[df['job'].isin(mix_keys)].copy()
if mix.empty:
    print('No mix rows found in', CSV)
    sys.exit(1)

# normalize order
mix['job'] = pd.Categorical(mix['job'], categories=[k for k in mix_keys if k in mix['job'].values], ordered=True)
mix = mix.sort_values('job')

labels = mix['job'].tolist()
iops = mix['iops'].astype(float).tolist()
bw = mix['bw_mib'].astype(float).tolist()
lat = mix['latency_mean_us'].astype(float).tolist()

def plot_throughput_bar(outname='mix_throughput.png'):
    plt.figure(figsize=(6,4))
    x = range(len(labels))
    plt.bar(x, bw, color=['C0','C1','C2','C3'][:len(x)])
    plt.xticks(x, labels)
    plt.ylabel('Bandwidth (MiB/s)')
    plt.title('Mix sweep: throughput (fixed block size)')
    plt.grid(axis='y', linestyle='--', alpha=0.6)
    out = OUTDIR / outname
    plt.tight_layout()
    plt.savefig(out, dpi=150)
    plt.close()
    print('Saved', out)

def plot_latency_and_iops(outname='mix_latency_iops.png'):
    fig, ax1 = plt.subplots(figsize=(7,4))
    x = range(len(labels))
    color = 'tab:blue'
    ax1.set_xlabel('mix')
    ax1.set_ylabel('Latency mean (us)', color=color)
    ax1.plot(x, lat, marker='o', color=color)
    ax1.tick_params(axis='y', labelcolor=color)
    ax1.set_xticks(x)
    ax1.set_xticklabels(labels)

    ax2 = ax1.twinx()
    color = 'tab:red'
    ax2.set_ylabel('IOPS', color=color)
    ax2.plot(x, iops, marker='s', linestyle='--', color=color)
    ax2.tick_params(axis='y', labelcolor=color)

    plt.title('Mix sweep: latency (us) and IOPS')
    fig.tight_layout()
    out = OUTDIR / outname
    plt.savefig(out, dpi=150)
    plt.close()
    print('Saved', out)

plot_throughput_bar()
plot_latency_and_iops()

print('Done')
