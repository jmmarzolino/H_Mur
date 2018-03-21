#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --mem-per-cpu=20G
#SBATCH --time=168:00:00
#SBATCH --output=/rhome/jmarz001/bigdata/Master/Scripts/mur_filter.stdout
#SBATCH --mail-user=jmarz001@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name='mur_filter'
#SBATCH -p intel



######                  Filtering                       ######

gunzip /rhome/jmarz001/bigdata/Master/calls/mur_calls.vcf.gz

module load vcftools

vcftools --vcf /rhome/jmarz001/bigdata/Master/calls/mur_calls.vcf \
--minQ 30 --out /rhome/jmarz001/bigdata/Master/filtered/mur_rawsnpsQUAL30 --recode
