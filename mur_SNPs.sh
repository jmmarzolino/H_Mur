#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --mem-per-cpu=20G
#SBATCH --time=168:00:00
#SBATCH --output=/rhome/jmarz001/bigdata/Master/Scripts/mur_SNPs.stdout
#SBATCH --mail-user=jmarz001@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name='mur_SNPs'
#SBATCH -p intel



###/////###                   Calling SNP's                    ###/////###
##samtools mpileup -uf reference.fa align.bam | bcftools call -mv -Oz > calls.vcf.gz

module load samtools
module load bcftools

samtools mpileup -uf \
/rhome/jmarz001/bigdata/Practice/Hordeum_vulgare.Hv_IBSC_PGSB_v2.dna.toplevel/Hordeum_vulgare.Hv_IBSC_PGSB_v2.dna.toplevel.fa \
/rhome/jmarz001/bigdata/Master/dupfree_aligns/mur_dupfree_aligned.bam \
| bcftools call -mv -Oz > /rhome/jmarz001/bigdata/Master/calls/mur_calls.vcf.gz