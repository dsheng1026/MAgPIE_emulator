#!/bin/bash
# =============================================================================
# emulator.sh  --  run the whole matrix pipeline as ONE serial SLURM job.
#
#
# Submit from the directory containing MM_linkage_emulator.R:
#     sbatch emulator.sh
# =============================================================================

#SBATCH --job-name=MMemultr
#SBATCH --output=mp2msg_%j.log      # combined stdout+stderr (%j = job id)
#SBATCH --qos=priority            # e.g. the QOS your MAgPIE runs use
#SBATCH --time=02:00:00            # generous; serial map+matrix over 84 mifs
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1          # the pipeline is single-threaded
#SBATCH --mem=8G                   # peak is reading one 8-9 MB mif via iamc

set -euo pipefail

module purge
# Load the standard PIAM R environment and shared package library.
module load defaults/piam/1.27
module load gcc/15.2.0    

module list
Rscript -e 'library(Rcpp); library(iamc)'

Rscript createMatrix_MM.R