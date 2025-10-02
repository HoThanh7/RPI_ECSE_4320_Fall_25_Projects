#!/usr/bin/env python3
"""plot_fio_bsweep.py

Reads Project_3/fio-results.csv and produces two PNGs in Project_3/plots:
- bsweep_iops.png (IOPS vs block size)
- bsweep_latency_mean_us.png (mean latency (us) vs block size)

Filters rows whose job starts with 'bsweep' and splits by read/write and random/seq.
"""
from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt
import re
import sys

ROOT = Path(__file__).resolve().parent
CSV = ROOT / 'fio-results.csv'
OUTDIR = ROOT / 'plots'
OUTDIR.mkdir(exist_ok=True)

if not CSV.exists():
    print(f"Missing {CSV}")
    sys.exit(1)

df = pd.read_csv(CSV)

# Keep only jobs starting with bsweep
bs = df[df['job'].str.startswith('bsweep')].copy()
if bs.empty:
    print('No bsweep rows found in', CSV)
    sys.exit(1)

def parse_size_token(tok: str):
    """Convert size token like '4k' or '128k' to integer bytes."""
    m = re.match(r"^(\d+)([kKmM]?)$", tok)
    if not m:
        # fallback: try to extract digits
        num = ''.join(ch for ch in tok if ch.isdigit())
        try:
            return int(num)
        except Exception:
            return None
    n = int(m.group(1))
    suf = m.group(2).lower()
    if suf == 'k':
        return n * 1024
    if suf == 'm':
        return n * 1024 * 1024
    return n

def classify_job(jobname: str):
    # pattern: bsweep[_rand]?(read|write)_(<size>)
    op = 'unknown'
    if 'read' in jobname:
        op = 'read'
    if 'write' in jobname:
        op = 'write'
    kind = 'rand' if 'rand' in jobname else 'seq'
    # extract trailing token
    parts = jobname.split('_')
    size_tok = parts[-1] if parts else ''
    size_bytes = parse_size_token(size_tok)
    return op, kind, size_tok, size_bytes

rows = []
for _, r in bs.iterrows():
    job = r['job']
    op, kind, size_tok, size_bytes = classify_job(job)
    if size_bytes is None:
        continue
    rows.append({
        'job': job,
        'op': op,
        'kind': kind,
        'size_tok': size_tok,
        'size_bytes': size_bytes,
        'iops': float(r.get('iops', 0)),
        'latency_mean_us': float(r.get('latency_mean_us', 0)),
    })

pbs = pd.DataFrame(rows)
if pbs.empty:
    print('No parsable bsweep rows')
    sys.exit(1)

def plot_metric(metric: str, ylabel: str, outname: str, logx=True):
    plt.figure(figsize=(8,5))
    # plot grouped lines for each (op, kind)
    combos = pbs.groupby(['op','kind'])
    markers = {'read':'o','write':'s','unknown':'x'}
    colors = {'rand':'C1','seq':'C0'}
    for (op,kind), g in combos:
        g2 = g.sort_values('size_bytes')
        label = f"{op} ({kind})"
        plt.plot(g2['size_bytes'], g2[metric], marker=markers.get(op,'o'), linestyle='-', label=label, color=colors.get(kind))

    if logx:
        plt.xscale('log', base=2)
    plt.xlabel('block size (bytes)')
    plt.ylabel(ylabel)
    plt.title(outname.replace('_',' ').replace('.png',''))
    plt.grid(True, which='both', linestyle='--', linewidth=0.4, alpha=0.6)
    plt.legend()
    plt.tight_layout()
    out = OUTDIR / outname
    plt.savefig(out, dpi=150)
    plt.close()
    print('Saved', out)

plot_metric('iops', 'IOPS', 'bsweep_iops.png')
plot_metric('latency_mean_us', 'latency mean (us)', 'bsweep_latency_mean_us.png')

print('Done')
