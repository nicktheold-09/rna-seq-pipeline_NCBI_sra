#!/bin/bash

FASTQC_DIR=${1:-data/qc/fastqc}
OUT_DIR=${2:-data/qc/multiqc}

mkdir -p "$OUT_DIR"

command -v multiqc >/dev/null 2>&1 || {
    echo "ERROR: multiqc not found in PATH"
    exit 1
}

echo "Running MultiQC on $FASTQC_DIR..."

multiqc "$FASTQC_DIR" -o "$OUT_DIR"

echo "MultiQC report generated in $OUT_DIR"
