#!/bin/sh
#SBATCH --job-name="nf-core"
#SBATCH -o RNAseq.o%j
#SBATCH -e RNAseq.e%j
#SBATCH --mail-user=<>
#SBATCH --mail-type=ALL
#SBATCH --partition="highmem"
#SBATCH -N 1
#SBATCH --mem=50G


module load Anaconda3/2024.02-1 
module load java/1.8.0
conda activate nfcore

# Ensure mamba is installed (safe to run multiple times)
#conda will take care of all the requirements 
conda install -y -c conda-forge mamba

#or nfcore/rnaseq
nextflow run nf-core/rnaseq --input samples.csv --remove_ribo_rna --outdir results_rnaseq --genome GRCh38 -c local.config -profile conda -c local.config 

# --remove_ribo_rna because the libraries are prepared using rRNA depletion method
