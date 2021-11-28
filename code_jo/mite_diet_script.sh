#!/bin/sh
#SBATCH --job-name=qiime2
#SBATCH --account=f_msa_jrl
#SBATCH --partition=jrl
#SBATCH --time=96:00:00
#SBATCH --mail-user=jean-francois.martin@supagro.fr
#SBATCH --mail-type=end

echo « Running on: $SLURM_NODELIST »
cd ../reads
for sample in *_R1_001.fastq.gz
    do
        name=$(basename -s _L001_R1_001.fastq.gz ${sample})
        cd ../
        results="./results_${name}"
        mkdir ${results}
        qiime2-2021.8.sif tools import --type 'SampleData[PairedEndSequencesWithQuality]' --input-path ./reads --input-format CasavaOneEightSingleLanePerSampleDirFmt --output-path ${results}.qza
    done  

