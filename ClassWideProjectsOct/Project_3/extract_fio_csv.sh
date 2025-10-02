#!/usr/bin/env bash
# extract_fio_csv.sh
# Usage: ./extract_fio_csv.sh <fio-json-directory> <output-csv-file>

JSON_DIR="$1"
OUTPUT_CSV="$2"

if [[ -z "$JSON_DIR" ]]; then
        echo "Usage: $0 <fio-json-directory> [output-csv-file]"
        exit 1
fi

if [[ ! -d "$JSON_DIR" ]]; then
        echo "Directory not found: $JSON_DIR"
        exit 1
fi

if [[ -z "$OUTPUT_CSV" ]]; then
        OUTPUT_CSV="$(pwd)/fio_summary.csv"
        echo "No output file provided; defaulting to $OUTPUT_CSV"
fi

# Check for jq
if ! command -v jq >/dev/null 2>&1; then
        echo "This script requires 'jq' to be installed."
        exit 1
fi

# Write CSV header
echo "job,filename,rw,iops,bw_mib,latency_mean_us,latency_p95_us,latency_p99_us" > "$OUTPUT_CSV"

# Loop over all JSON files
for json_file in "$JSON_DIR"/*.json; do
        if [[ ! -f "$json_file" ]]; then
                continue
        fi

        filename=$(basename -- "$json_file")

        # Use jq to extract any and all jobs in the file. For each job compute combined iops/bw and a
        # weighted mean latency (by iops). For percentiles we try a few common key formats and prefer
        # read values when present, falling back to write.
        jq -r --arg filename "$filename" '
        .jobs[] as $job |
        (
            ($job.read.iops // 0) + ($job.write.iops // 0)
        ) as $iops |
        (
            ((($job.read.bw // 0) + ($job.write.bw // 0)) / 1024)
        ) as $bw_mib |
        (
            ( ($job.read.clat_ns.mean // 0) * ($job.read.iops // 0) + ($job.write.clat_ns.mean // 0) * ($job.write.iops // 0) ) as $num
            | (if $iops == 0 then 0 else ($num / $iops) end)
        ) as $lat_mean_ns |
        (
            ($job.read.clat_ns.percentile // {}) as $rpr |
            ($job.write.clat_ns.percentile // {}) as $wpr |
            (
                ($rpr["95.000000"] // $rpr["95.000"] // $rpr["95.00"] // $rpr["95"] // $wpr["95.000000"] // $wpr["95.000"] // $wpr["95.00"] // $wpr["95"] // 0)
            ) as $p95_ns |
            (
                ($rpr["99.000000"] // $rpr["99.000"] // $rpr["99.00"] // $rpr["99"] // $wpr["99.000000"] // $wpr["99.000"] // $wpr["99.00"] // $wpr["99"] // 0)
            ) as $p99_ns |
            (
                if ($job.read // null) != null and ($job.write // null) != null then "mixed"
                elif ($job.read // null) != null then "read"
                elif ($job.write // null) != null then "write"
                else "unknown" end
            ) as $rw_mode |
            [($job.jobname // ""), $filename, $rw_mode, $iops, ($bw_mib), ($lat_mean_ns/1000), ($p95_ns/1000), ($p99_ns/1000)]
        ) | @csv
        ' "$json_file" >> "$OUTPUT_CSV"
done

echo "CSV summary written to $OUTPUT_CSV"
