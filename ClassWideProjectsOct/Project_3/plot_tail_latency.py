#!/usr/bin/env python3
"""plot_tail_latency.py

Extract p50/p95/p99/p99.9 (in us) from fio JSON files for qd sweep and plot them.
Targets QDs: 1, 8, 32, 128 by default (adjustable).
"""
from pathlib import Path
import json
import matplotlib.pyplot as plt
import numpy as np
import sys

ROOT = Path(__file__).resolve().parent
FOLDER = ROOT / 'fio-results'
OUT = ROOT / 'plots'
OUT.mkdir(exist_ok=True)

TARGET_QDS = [1,8,32,128]

def read_percentiles(json_path: Path):
    with open(json_path, 'r') as f:
        j = json.load(f)
    jobs = j.get('jobs', [])
    if not jobs:
        return None
    job = jobs[0]
    # only consider read percentiles for randread
    read = job.get('read', {})
    clat = read.get('clat_ns', {})
    percent = clat.get('percentile', {})
    # Helpers to fetch keys with fallbacks
    def getp(k):
        for key in (f"{k}.000000", f"{k}.000", f"{k}.00", f"{k}"):
            if key in percent:
                return percent[key] / 1000.0
        return None
    p50 = getp('50')
    p95 = getp('95')
    p99 = getp('99')
    p999 = getp('99.900000') or getp('99.9')
    return {'p50':p50, 'p95':p95, 'p99':p99, 'p999':p999, 'jobname': job.get('jobname')}

results = []
for q in TARGET_QDS:
    path = FOLDER / f'qd_{q}.json'
    if not path.exists():
        print('Missing', path)
        continue
    r = read_percentiles(path)
    if not r:
        print('No job data in', path)
        continue
    r['qd'] = q
    results.append(r)

if not results:
    print('No results found for target QDs')
    sys.exit(1)

# Create CSV
csv_path = OUT / 'tail_latency_summary.csv'
with open(csv_path, 'w') as f:
    f.write('qd,jobname,p50_us,p95_us,p99_us,p99.9_us\n')
    for r in results:
        f.write(f"{r['qd']},{r['jobname']},{r.get('p50',0)},{r.get('p95',0)},{r.get('p99',0)},{r.get('p999',0)}\n")
print('Wrote', csv_path)

# Plot grouped bar chart for percentiles
labels = [str(r['qd']) for r in results]
p50 = [r.get('p50') or 0 for r in results]
p95 = [r.get('p95') or 0 for r in results]
p99 = [r.get('p99') or 0 for r in results]
p999 = [r.get('p999') or 0 for r in results]

x = np.arange(len(labels))
width = 0.2

plt.figure(figsize=(8,5))
plt.bar(x - 1.5*width, p50, width, label='p50', color='C0')
plt.bar(x - 0.5*width, p95, width, label='p95', color='C1')
plt.bar(x + 0.5*width, p99, width, label='p99', color='C2')
plt.bar(x + 1.5*width, p999, width, label='p99.9', color='C3')
plt.xticks(x, labels)
plt.xlabel('Queue depth (qd)')
plt.ylabel('Latency (µs)')
plt.title('Tail latency percentiles vs queue depth (4 KiB randread)')
plt.legend()
plt.grid(axis='y', linestyle='--', alpha=0.6)
out = OUT / 'tail_latency_percentiles.png'
plt.tight_layout()
plt.savefig(out, dpi=150)
plt.close()
print('Saved', out)

print('Done')
