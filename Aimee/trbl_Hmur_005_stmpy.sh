#!/bin/bash -l

#SBATCH --array=1
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --mem=20G
#SBATCH --time=1-0:00:00
#SBATCH --output=/rhome/auyeh/bigdata/H_mur/results/trbl_Hmur_005_stmpy.stdout
#SBATCH --error=/rhome/auyeh/bigdata/H_mur/results/trbl_Hmur_005_stmpy.stderr
#SBATCH --mail-user=auyeh002@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name="stmpyTEST3"
#SBATCH -p intel 	 #Options:  intel, batch, highmem (200 Gb memory), gpu, short (jobs with wall time of 2 h) check with squeue -p PARTITIONNAME


module load bwa/0.7.17
module load samtools/1.9
module load stampy/1.0.2

WD=/rhome/auyeh/bigdata/H_mur/results/aligned/TrblSht
cd $WD
#1. create a BWA index for reference genome used by stampy
#/opt/linux/centos/7.x/x86_64/pkgs/bwa/0.7.17/bwa index Ref_sub.fa -p bwa_Ref_sub
#2. build genome file for STAMPY
#/opt/linux/centos/7.x/x86_64/pkgs/stampy/1.0.28/stampy.py --assembly=IBSC_v2 -G $WD/Ref_sub $WD/Ref_sub.fa
#3 build hash table for STAMPY
#/opt/linux/centos/7.x/x86_64/pkgs/stampy/1.0.28/stampy.py -g Ref_sub -H Ref_sub


bwa mem -R "@RG\tID:Hordeum_murinum_AG196-2_ATCACG\tSM:AG196-2\tPU:ATCACG_flowcell718_lane1\tLB:lib1\tPL:ILLUMINA" -t 2 $WD/bwa_Ref_sub pair1.fq pair2.fq > TEST3.sam
samtools view -b TEST3.sam > TEST3.bam


/opt/linux/centos/7.x/x86_64/pkgs/stampy/1.0.28/stampy.py -g $WD/Ref_sub -h $WD/Ref_sub -t 2 --substitutionrate=0.01 --bamkeepgoodreads --insertsize=300 --insertsd=85 -f sam -M TEST3.bam  | \
samtools sort -o $WD/TEST3_mapped_sorted.bam

java -jar /opt/linux/centos/7.x/x86_64/pkgs/picard/2.18.3/lib/picard.jar MarkDuplicates INPUT=TEST3_mapped_sorted.bam OUTPUT=TEST3_mapped_sorted_mrkdup.bam METRICS_FILE=TEST3_metrics.txt CREATE_INDEX=true TAGGING_POLICY=All

samtools index -b TEST3_mapped_sorted_mrkdup.bam TEST3_mapped_sorted_mrkdup

samtools view TEST3_mapped_sorted_mrkdup.bam | cut -d$'\t' -f5 > MAPQvalues_TEST3.txt
