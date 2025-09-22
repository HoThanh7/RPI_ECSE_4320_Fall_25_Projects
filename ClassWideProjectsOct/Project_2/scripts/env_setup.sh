#!/usr/bin/env bash
# Set system to "performance" governor and optionally turn SMT off.
# Run with sudo: sudo ./env_setup.sh
set -euo pipefail

echo "Setting CPU governor to performance for all online CPUs..."
if [ -d /sys/devices/system/cpu ]; then
  for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
    gov="$cpu/cpufreq/scaling_governor"
    if [ -f "$gov" ]; then
      echo performance > "$gov" || echo "failed to set $gov (you might need cpupower/permissions)"
    fi
  done
fi

# Optional: disable SMT (hyperthreading)
if [ -w /sys/devices/system/cpu/smt/control ]; then
  echo "Disabling SMT (writing 'off' to /sys/devices/system/cpu/smt/control)..."
  echo off > /sys/devices/system/cpu/smt/control
else
  echo "SMT control not available on this system or requires different method. Skipping."
fi

echo "Environment setup done. Remember to re-enable SMT / change governor back when finished."
