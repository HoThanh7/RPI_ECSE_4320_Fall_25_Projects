# mem-bench-project (scaffold)

This repo contains kernel microbenchmarks (SAXPY, dot, elementwise multiply), build scripts,
run scripts and a simple plotting helper. Designed to be developed on laptop and run
(for final measurements) on an Arch Linux desktop.

## Quick start (dev machine)
1. `make`
2. `./scripts/run_kernels.sh`  # runs default sweep and writes CSVs to data/
3. `python3 analysis/plot.py saxpy`  # produce plot

## On Arch Linux (recommended for Project 2 real runs)
1. `sudo ./scripts/env_setup.sh`
2. `make`
3. `./scripts/run_kernels.sh 0 5`  # pin to core 0, 5 repeats
4. Use `sudo ./scripts/collect_perf.sh bin/saxpy_simd 1048576 0` to gather perf counters.

## Notes
* Edit `scripts/run_kernels.sh` to change sizes, kernel list, repeats and the pinned core.
* Vectorization reports for simd builds are written to `build/reports/*.vec.txt`.
