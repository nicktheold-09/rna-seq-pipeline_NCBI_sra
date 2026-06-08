#!/bin/bash

# =============================================================================
# SRA Download Pipeline
#
# Usage:
#   bash download_accessions.sh accessions.txt
#
#   accessions.txt
#   SRA00000000
#   SRA00000001
#   SRA00000002
#   etc...
# =============================================================================

OUTPUT_DIR="sra"

if [ $# -ne 1 ]; then
    echo "Usage: $0"
    exit 1
fi

ACCESSION_FILE="$1"

if [ ! -f "$ACCESSION_FILE" ]; then
    echo "Error: File '$ACCESSION_FILE' not found."
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

TOTAL=$(grep -cv '^$' "$ACCESSION_FILE")

echo "Found $TOTAL accession(s)."
echo "Starting downloads:"

while read -r srr; do

    # Ignora linhas vazias
    [[ -z "$srr" ]] && continue

    echo "Downloading $srr[...]"

    prefetch "$srr" -O "$OUTPUT_DIR"

    if [ $? -eq 0 ]; then
        echo "$srr downloaded successfully."
    else
        echo "Failed to download $srr."
    fi

    echo "----------------------------------------"

done < "$ACCESSION_FILE"

echo "All downloads completed."
