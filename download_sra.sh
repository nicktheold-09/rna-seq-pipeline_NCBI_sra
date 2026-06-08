#!/bin/bash

# =============================================================================
# SRA Download Pipeline
# Downloads sequencing datasets from NCBI SRA using SRA Toolkit
#
# Usage:
#   bash download_sra.sh SRR######## SRR######## SRR########
# =============================================================================

OUTPUT_DIR="sra"

# Verifica se pelo menos um SRR foi informado
if [ $# -eq 0 ]; then
    echo "Error: No SRR accession provided."
    echo "Usage: $0 SRR_ID [SRR_ID ...]"
    exit 1
fi

# Cria diretório de saída
mkdir -p "$OUTPUT_DIR"

echo "Starting download of $# accession(s)"

# Itera sobre todos os argumentos recebidos
for srr in "$@"; do
    echo "Downloading $srr..."

    prefetch "$srr" -O "$OUTPUT_DIR"

    if [ $? -eq 0 ]; then
        echo " $srr downloaded successfully"
    else
        echo "Failed to download $srr"
    fi

    echo "----------------------------------------"
done

echo "All downloads completed"
