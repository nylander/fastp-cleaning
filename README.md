# fastp-cleaning

- Last modified: 2026-04-07 17:07:11
- Sign: Johan Nylander

## Description

Workflow using snakemake for filtering fastq files using
[fastp](https://github.com/OpenGene/fastp).

### Input

1. gzipped paired-end Illumina `.fastq.gz` files (see [README](input/README.md)
   for details). Example data (138M gzipped) can be downloaded here:
   [https://nrmcloud.nrm.se/s/wgD4qoHgNX4yj3T](https://nrmcloud.nrm.se/s/wgD4qoHgNX4yj3T)

### Output

- filtered `.fq.gz` files placed in a new output directory
- filtering reports (before/after)
- merged pair-end reads `.fq.gz` files (optional)
- fasta files from filtered fastq (optional)
- workflow report in html format (in folder output)

### Filtering steps

1. Filter on [quality](https://github.com/OpenGene/fastp#quality-filter)
2. Filter on [length](https://github.com/OpenGene/fastp#length-filter)
3. Per read cutting per quality using a [sliding window from front to
   tail](https://github.com/OpenGene/fastp#per-read-cutting-by-quality-score)
4. Adapters are automatically [detected and
   trimmed](https://github.com/OpenGene/fastp#adapters)
5. PCR-deduplicaiton (optional, by editing the
   [config.yaml](config/config.yaml) file)
6. Merging of paired-end read pairs (optional, by editing the
   [config.yaml](config/config.yaml) file)
7. Convert the filtered fastq files to fasta (optional, by editing the
   [config.yaml](config/config.yaml) file)

Please see the [fastp-manual](https://github.com/OpenGene/fastp/wiki) for
details on the filtering procedures.

---

## How to run locally with conda

1. Install
    - [`snakemake`](https://snakemake.readthedocs.io/en/stable/#)
    - [`conda`](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html)
2. Clone the repository: `git clone
https://github.com/nylander/fastp-cleaning.git`
3. Put input data (gzip-compressed paired-end illumina fastq files) in folder
`fastp-cleaning/input`
4. Review the `fastp-cleaning/config/config.yaml` and make sure input file name
endings (currently `_R1_001.fastq.gz`), matches your input files, select the
steps used by the pipeline, and change options for software used if needed.
5. Make sure your current working directory is `fastp-cleaning`
6. Test run `snakemake --use-conda -n`
7. Run with `snakemake --use-conda --cores N` (substitute N with the number of
cores you wish to use)

## License and copyright

Copyright (c) 2021-2026 Johan Nylander

[MIT LICENSE](LICENSE)
