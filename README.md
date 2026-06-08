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

## Example Usage

```bash
bash sra_qc_pipeline.sh SRRXXXXXXX
