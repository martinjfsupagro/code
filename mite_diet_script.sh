for sample in *_R1_001.fastq
    do
        id=$(basename -s _L001_R1_001.fastq  ${sample})
        qiime2.sif tools import --type 'SampleData[PairedEndSequencesWithQuality]' --input-path ./ --input-format CasavaOneEightSingleLanePerSampleDirFmt --output-path ${id}.qza
done  