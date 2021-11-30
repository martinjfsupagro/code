#!/bin/sh
#SBATCH --job-name=qiime2_2021.8
#SBATCH --account=f_msa_jrl
#SBATCH --partition=jrl
#SBATCH --time=96:00:00
#SBATCH --mail-user=jean-francois.martin@supagro.fr
#SBATCH --mail-type=end

echo « Running on: $SLURM_NODELIST »

qiime2_2021.8.sif tools import --type MultiplexedPairedEndBarcodeInSequence --input-path ./reads --output-path 21.qza

qiime2_2021.8.sif cutadapt demux-paired --p-error-rate 0.05 --verbose --p-mixed-orientation --p-minimum-length 100 --i-seqs 21.qza --o-per-sample-sequences trimmed_21.qza --o-untrimmed-sequences untrimmed_21.qza



qiime2_2021.8.sif dada2 denoise-paired --i-demultiplexed-seqs trimmed_21.qza --p-trunc-len-f 180 --p-trunc-len-r 180 --p-chimera-method 'consensus' --p-n-reads-learn 100000 --p-hashed-feature-ids TRUE --o-table ASVS-table_21.qza --o-representative-sequences ASVS-sequences_21.qza --o-denoising-stats denoising-stats_21.qza --verbose




# for sample in *_R1_001.fastq
#    do
#         id=$(basename -s _L001_R1_001.fastq  ${sample})
#        qiime2_2021.8.sif tools import --type 'SampleData[PairedEndSequencesWithQuality]' --input-path ./ --input-format CasavaOneEightSingleLanePerSampleDirFmt --output-path ${id}.qza
#done  

docker pull quay.io/qiime2/core:2021.11
singularity build --remote qiime2_2021.11.sif docker://quay.io/qiime2/core:2021.11