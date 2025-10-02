#!/usr/bin/env python3
"""plot_mlc_results.py

Small helper to parse MLC text outputs (idle_latency, loaded_latency, bandwidth_matrix)
and create simple plots. This script is intentionally lightweight; adjust parsing depending
on your MLC version output format.
"""
from pathlib import Path
import re
import sys
import matplotlib.pyplot as plt
import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
IN_DIR = ROOT / 'MLC_Results'
OUT_DIR = ROOT / 'data' / 'graphs'
OUT_DIR.mkdir(parents=True, exist_ok=True)

def parse_idle_latency(path: Path):
    text = path.read_text()
    # find the line with "Each iteration took X base frequency clocks (... ns)"
    m = re.search(r'Each iteration took .*?\((\s*[0-9\.]+)\s*ns\)', text)
    if m:
        return float(m.group(1))
    return None

def main():
    idle_files = list(IN_DIR.glob('idle_*.txt'))
    rows = []
    for f in idle_files:
        lvl = f.stem.replace('idle_','')
        v = parse_idle_latency(f)
        rows.append({'level':lvl, 'ns':v})

    if rows:
        df = pd.DataFrame(rows).sort_values('ns')
        df.plot.bar(x='level', y='ns', legend=False, rot=0, title='Zero-queue latency (ns)')
        out = OUT_DIR / 'zero_queue_latency_ns.png'
        plt.ylabel('ns')
        plt.tight_layout()
        plt.savefig(out, dpi=150)
        print('Saved', out)

if __name__ == '__main__':
    main()
