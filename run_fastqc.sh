#!/bin/bash

# =============================================================================
# FastQC Analysis Pipeline
# Runs quality control on FASTQ files
# =============================================================================

FASTQ_DIR=${1:-data/fastq}
OUT_DIR=${2:-data/qc/fastqc}

mkdir -p "$OUT_DIR"

# Check dependency
command -v fastqc >/dev/null 2>&1 || {
    echo "ERROR: FastQC not found in PATH"
    exit 1
}

# Check input
if ! ls "$FASTQ_DIR"/*.fastq.gz >/dev/null 2>&1; then
    echo "No FASTQ files found in $FASTQ_DIR"
    exit 0
fi

echo "Starting FastQC analysis..."

for fq in "$FASTQ_DIR"/*.fastq.gz; do
    echo "Processing $fq"

    fastqc "$fq" -o "$OUT_DIR" -t 4

    if [ $? -eq 0 ]; then
        echo "OK: $(basename "$fq")"
    else
        echo "ERROR: $(basename "$fq")"
    fi

done

echo "FastQC completed."
