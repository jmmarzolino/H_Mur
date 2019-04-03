#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=200G
#SBATCH --time=1-0:00:00
#SBATCH --output=/rhome/auyeh/bigdata/H_mur/results/trbl_Hmur_003_mrkDup+indx.stdout
#SBATCH --error=/rhome/auyeh/bigdata/H_mur/results/trbl_Hmur_003_mrkDup+indx.stderr
#SBATCH --mail-user=auyeh002@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name="mrkdup+index"
#SBATCH -p highmem 	 #Options:  intel, batch, highmem (200 Gb memory), gpu, short (jobs with wall time of 2 h) check with squeue -p PARTITIONNAME

module load picard/2.18.3
module load samtools/1.8

cd /rhome/auyeh/bigdata/H_mur/results/aligned/TrblSht


java -jar /opt/linux/centos/7.x/x86_64/pkgs/picard/2.18.3/lib/picard.jar MarkDuplicates INPUT=mapped_sorted_TEST1.bam OUTPUT=mapped_sorted_mrkdup_TEST1.bam METRICS_FILE=TEST1_index.txt CREATE_INDEX=true TAGGING_POLICY=All

samtools index -b mapped_sorted_mrkdup_TEST1.bam mapped_sorted_mrkdup_TEST1
