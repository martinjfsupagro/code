#!/bin/sh
#SBATCH --job-name=qiime2
#SBATCH --account=f_msa_jrl
#SBATCH --partition=jrl
#SBATCH --time=96:00:00
#SBATCH --mail-user=jean-francois.martin@supagro.fr
#SBATCH --mail-type=end

echo « Running on: $SLURM_NODELIST »

qiime2_2021.8.sif tools import --type 'SampleData[PairedEndSequencesWithQuality]' --input-path ./reads --input-format CasavaOneEightSingleLanePerSampleDirFmt --output-path 21.qza

qiime2_2021.8.sif cutadapt trim-paired --p-front-f file:plate_2_forward.fas --p-front-r file:plate_2_reverse.fas --p-error-rate 0.05 --p-times 1 --p-match-adapter-wildcards TRUE --verbose --p-minimum-length 100 --p-discard-untrimmed TRUE --i-demultiplexed-sequences 21.qza --o-trimmed-sequences trimmed_21.qza



# for sample in *_R1_001.fastq
#    do
#         id=$(basename -s _L001_R1_001.fastq  ${sample})
#        qiime2_2021.8.sif tools import --type 'SampleData[PairedEndSequencesWithQuality]' --input-path ./ --input-format CasavaOneEightSingleLanePerSampleDirFmt --output-path ${id}.qza
#done  

