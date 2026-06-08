#!/bin/bash

# =============================================================================
# SRA to FASTQ Conversion Pipeline
#
# Converts .sra files to compressed FASTQ files using fasterq-dump.
#
# Usage:
#   bash convert_sra_to_fastq.sh [SRA_DIR] [FASTQ_DIR]
#
# Example:
#   bash convert_sra_to_fastq.sh data/sra data/fastq
#
# Requirements:
#   - SRA Toolkit (fasterq-dump)
#   - gzip
# =============================================================================

set -euo pipefail

# Directories (defaults)
SRA_DIR=${1:-data/sra}
FASTQ_DIR=${2:-data/fastq}

# Log file
LOG_FILE="conversion.log"

# Check dependencies
command -v fasterq-dump >/dev/null 2>&1 || {
    echo "ERROR: fasterq-dump not found in PATH."
    exit 1
}

command -v gzip >/dev/null 2>&1 || {
    echo "ERROR: gzip not found."
    exit 1
}

# Create output directory
mkdir -p "$FASTQ_DIR"

echo "==================================================" | tee -a "$LOG_FILE"
echo "Conversion started: $(date)" | tee -a "$LOG_FILE"
echo "SRA directory: $SRA_DIR" | tee -a "$LOG_FILE"
echo "FASTQ directory: $FASTQ_DIR" | tee -a "$LOG_FILE"
echo "==================================================" | tee -a "$LOG_FILE"

# Check if SRA files exist
if ! ls "$SRA_DIR"/*.sra >/dev/null 2>&1; then
    echo "No .sra files found in $SRA_DIR" | tee -a "$LOG_FILE"
    exit 0
fi

# Process files
for sra_file in "$SRA_DIR"/*.sra; do

    base=$(basename "$sra_file" .sra)

    echo "Processing $base..." | tee -a "$LOG_FILE"

    if fasterq-dump \
        "$sra_file" \
        --split-files \
        -O "$FASTQ_DIR" \
        -e 8 \
        -f >> "$LOG_FILE" 2>&1
    then

        echo "FASTQ generated for $base" | tee -a "$LOG_FILE"
        echo "Compressing FASTQ files..." | tee -a "$LOG_FILE"

        for fq in "$FASTQ_DIR/${base}"*.fastq; do
            [ -f "$fq" ] && gzip "$fq"
        done

        echo "Compression completed for $base" | tee -a "$LOG_FILE"

        rm -f "$sra_file"

        echo "Removed original file: ${base}.sra" | tee -a "$LOG_FILE"

    else

        echo "ERROR: Failed to convert $base" | tee -a "$LOG_FILE"
        echo "Original SRA file preserved." | tee -a "$LOG_FILE"

    fi

    echo "--------------------------------------------------" | tee -a "$LOG_FILE"

done

echo "Conversion completed: $(date)" | tee -a "$LOG_FILE"
