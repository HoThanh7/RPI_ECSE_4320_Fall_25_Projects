#!/usr/bin/env python3
"""
plot_project2_kernels.py

Scans Project_2/data/{scalar,simd} for CSVs for kernels (saxpy, dot, element), normalizes columns,
and generates raw-sample and aggregated (median per n) plots into Project_2/data/graphs.

Usage: python3 plot_project2_kernels.py
"""
import sys
from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt
import glob

ROOT = Path(__file__).resolve().parents[1] / 'data'
OUTPUT_DIR = ROOT / 'graphs'
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

# Kernels we expect
KERNELS = ['saxpy', 'dot', 'element']

# Possible column name mappings to normalize across CSVs
COLUMN_NORMALIZATION = {
    # common names in provided CSVs
    'kernel': 'kernel',
    'n': 'n',
    'time_s': 'time_s',
    'gflops': 'gflops',
    'checksum': 'checksum',
    # alternate names some scripts use
    'datatype': 'datatype',
    'stride': 'stride',
    'aligned': 'aligned',
}

def find_csv_files():
    files = []
    for sub in ['scalar', 'simd']:
        folder = ROOT / sub
        if not folder.exists():
            continue
        for f in folder.glob('*.csv'):
            files.append((sub, f))
    return files

def read_and_normalize(path: Path):
    try:
        df = pd.read_csv(path)
    except Exception as e:
        print(f"Failed to read {path}: {e}")
        return None

    # Normalize column names to lower-case stripped
    df.columns = [c.strip() for c in df.columns]

    # Ensure 'n' and 'gflops' present or try common alternatives
    if 'n' not in df.columns or 'gflops' not in df.columns:
        print(f"Skipping {path.name}: missing required 'n' or 'gflops' columns")
        return None

    # Coerce numeric columns
    df = df.replace([float('inf'), float('-inf')], pd.NA)
    df = df.dropna(subset=['n', 'gflops'])
    df['n'] = pd.to_numeric(df['n'], errors='coerce')
    df['gflops'] = pd.to_numeric(df['gflops'], errors='coerce')
    df = df.dropna(subset=['n', 'gflops'])

    return df

def plot_raw(df: pd.DataFrame, kernel: str, variant: str, src_name: str):
    plt.figure(figsize=(6,4))
    plt.scatter(df['n'], df['gflops'], s=30, alpha=0.7, edgecolor='k', linewidth=0.3)
    plt.xscale('log', base=2)
    plt.xlabel('n (vector length, log2 scale)')
    plt.ylabel('gflops (raw samples)')
    plt.title(f'{kernel} ({variant}) - {src_name} - raw samples')
    plt.grid(True, which='both', linestyle='--', linewidth=0.5, alpha=0.6)
    out = OUTPUT_DIR / f"{kernel}_{variant}_{src_name}_raw.png"
    plt.tight_layout()
    plt.savefig(out, dpi=150)
    plt.close()
    print(f"Saved {out}")

def plot_aggregated(df: pd.DataFrame, kernel: str, variant: str, src_name: str):
    # Aggregate by n (median gflops)
    agg = df.groupby('n', as_index=False)['gflops'].median().sort_values('n')
    plt.figure(figsize=(6,4))
    plt.plot(agg['n'], agg['gflops'], marker='o')
    plt.xscale('log', base=2)
    plt.xlabel('n (vector length, log2 scale)')
    plt.ylabel('gflops (median per n)')
    plt.title(f'{kernel} ({variant}) - {src_name} - median per n')
    plt.grid(True, which='both', linestyle='--', linewidth=0.5, alpha=0.6)
    out = OUTPUT_DIR / f"{kernel}_{variant}_{src_name}_median.png"
    plt.tight_layout()
    plt.savefig(out, dpi=150)
    plt.close()
    print(f"Saved {out}")

def main():
    files = find_csv_files()
    if not files:
        print(f"No CSV files found under {ROOT}. Ensure Project_2/data/scalar or /simd exists.")
        return 1

    # Map kernel -> list of dataframes per variant (scalar/simd)
    for variant, path in files:
        df = read_and_normalize(path)
        if df is None:
            continue

        # Determine kernel column or assume single kernel per file
        kernel_name = None
        if 'kernel' in df.columns:
            kernel_name = df['kernel'].astype(str).iloc[0]
        else:
            # try to infer from filename
            kernel_name = path.stem.split('_')[0]

        kernel_name = kernel_name.lower()
        if kernel_name not in KERNELS:
            print(f"Skipping {path.name}: kernel '{kernel_name}' not in expected {KERNELS}")
            continue

        src = path.stem.replace('.', '_')
        plot_raw(df, kernel_name, variant, src)
        plot_aggregated(df, kernel_name, variant, src)

    print("Done.")
    return 0

if __name__ == '__main__':
    sys.exit(main())
