#!/bin/sh
#SBATCH --job-name=dada2
#SBATCH --account=biomics
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks-per-core=1
#SBATCH --partition=defq
#SBATCH --time=99:00:00
#SBATCH --mail-user=johannes.tavoillot@ird.fr
#SBATCH --mail-type=end
qiime2-2021.8.sif tools import --type 'SampleData[PairedEndSequencesWithQuality]' --input-path ./Reads_Biosph --input-format CasavaOneEightSingleLanePerSampleDirFmt --output-path Biosh_epis_LEP.qza
qiime2-2021.8.sif cutadapt trim-paired --p-front-f file:forwardLEP.fas --p-front-r file:reverseLEP.fas --p-error-rate 0.05 --p-times 1 --p-match-adapter-wildcards TRUE --verbose --p-minimum-length 100 --p-discard-untrimmed TRUE --i-demultiplexed-sequences Biosh_epis_LEP.qza --o-trimmed-sequences Biosh_epis_LEP_trimmed.qza
qiime2-2021.8.sif dada2 denoise-paired --i-demultiplexed-seqs  Biosh_epis_LEP_trimmed.qza --p-trunc-len-f 180 --p-trunc-len-r 180 --p-chimera-method 'consensus' --p-n-reads-learn 10000 --p-hashed-feature-ids TRUE --o-table  Biosh_epis_LEP_table.qza --o-representative-sequences  Biosh_epis_LEP_sequences.qza --o-denoising-stats  Biosh_epis_LEP_denoising-stats.qza --verbose
qiime2-2021.8.sif tools export --input-path  Biosh_epis_LEP_denoising-stats.qza --output-path  Biosh_epis_LEP_dada2_output_test
qiime2-2021.8.sif feature-table filter-features --i-table Biosh_epis_LEP_table.qza --m-metadata-file Biosh_epis_LEP_sequences.qza --p-where 'length(sequence) > 217 AND length(sequence) < 219' --o-filtered-table Biosh_epis_LEP_table-218_test.qza --verbose
qiime2-2021.8.sif tools export --input-path Biosh_epis_LEP_table-218_test.qza --output-path Biosh_epis_LEP_table-218_test.biom
singularity exec qiime2-2021.8.sif biom convert -i Biosh_epis_LEP_table-218_test.biom/feature-table.biom -o Biosh_epis_LEP_table-218.tsv --to-tsv

