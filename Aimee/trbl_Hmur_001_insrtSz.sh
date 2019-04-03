#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=20G
#SBATCH --time=1-0:00:00
#SBATCH --output=/rhome/auyeh/bigdata/H_mur/results/trbl_Hmur_001_insrtSz.stdout
#SBATCH --error=/rhome/auyeh/bigdata/H_mur/results/trbl_Hmur_001_insrtSz.stderr
#SBATCH --mail-user=auyeh002@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name="insrtsz"
#SBATCH -p intel

module load picard/2.18.3
cd /rhome/auyeh/bigdata/H_mur/results/aligned/
WD=/rhome/auyeh/bigdata/H_mur/results/aligned

java -jar /opt/linux/centos/7.x/x86_64/pkgs/picard/2.18.3/bin/picard.jar CollectInsertSizeMetrics \
      I=hmur_marked_duplicates_index.bam \
      O=$WD/TrblSht/insert_size_metrics.txt \
      H=$WD/TrblSht/insert_size_histogram.pdf
