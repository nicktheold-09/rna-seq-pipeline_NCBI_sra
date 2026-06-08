# rna-seq-pipeline_NCBI_sra
Automated Bash pipeline for downloading sequencing data from the SRA using SRA Toolkit and performing quality control analysis with FastQC and MultiQC.

This repository provides a simple and reproducible Bash-based workflow for downloading high-throughput sequencing data from the Sequence Read Archive (SRA) using the SRA Toolkit and performing quality control analysis with FastQC and MultiQC.

The pipeline automates the initial steps of NGS data processing, allowing researchers to efficiently retrieve public datasets and assess sequencing quality before downstream analyses.

## Features

- Download sequencing datasets from SRA using accession numbers (SRR IDs)
- Convert SRA files to FASTQ format
- Run quality control analysis with FastQC
- Generate consolidated quality reports with MultiQC
- Organize outputs into structured directories
- Designed for Linux and HPC environments

## Requirements

- Bash
- SRA Toolkit
- FastQC
- MultiQC

## Project Structure

```text
.
├── download_sra.sh
├── convert_fastq.sh
├── run_fastqc.sh
├── run_multiqc.sh
├── config/
│   └── srr_list.txt
└── results/
```

## Usage

### 1. Download SRA files

```bash
bash download_sra.sh
```

### 2. Convert SRA to FASTQ

```bash
bash convert_fastq.sh
```

### 3. Run FastQC

```bash
bash run_fastqc.sh
```

### 4. Generate MultiQC report

```bash
bash run_multiqc.sh
```

## Workflow

```text
SRR Accessions
      ↓
download_sra.sh
      ↓
convert_fastq.sh
      ↓
run_fastqc.sh
      ↓
run_multiqc.sh
      ↓
QC Report
```
