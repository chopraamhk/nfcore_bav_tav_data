#!/bin/sh
#SBATCH --job-name="nf-core_snRNAseq"
#SBATCH -o snRNAseq.o%j
#SBATCH -e snRNAseq.e%j
#SBATCH --mail-user=m.chopra1@universityofgalway.ie
#SBATCH --mail-type=ALL
#SBATCH --partition="highmem"
#SBATCH -N 1
#SBATCH --mem-per-cpu=20G
#SBATCH --time=120:00:00

module load Anaconda3/2024.02-1 
module load apptainer
conda activate nfcore

#code
nextflow run nf-core/scrnaseq -r 4.1.0 --input samplesheet.csv --outdir results_snrnaseq --genome GRCh38 --protocol 10XV4 --aligner cellranger -profile apptainer -c local.config_customised --fasta /data4/mchopra/genewiz_azenta/90-1155124233/analysis_mc/GRCh38.primary_assembly.genome.fa.gz --gtf /data4/mchopra/genewiz_azenta/90-1155124233/analysis_mc/gencode.v44.annotation.gtf.gz

#protocol - chemistry used for library preparation 
#aligner - cellranger which is closer to 10x genomics protocol 
#if you dont specify aligner, then By default (i.e. --aligner simpleaf), the pipeline uses piscem to perform pseudo-alignment of reads to the reference genome and Alevin-fry to perform the downstream BAM-level quantification. 
#Then QC reports are generated with AlevinQC.
