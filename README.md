# fastp-cleaning

- Last modified: ons jan 12, 2022  02:51
- Sign: nylander

## Description

Filter fastq files using [fastp](https://github.com/OpenGene/fastp).

Heavily influenced by the [stag-mwc](https://github.com/marcelladane/stag-mwc) pipeline.

- **Input**: gzipped paired-end illumina `.fastq.gz` files
- **Output**:
    - filtered `.fastq.gz` files placed in a new output directory
    - fastp report (before/after) in `output/logs/fastp/`

---

TODO:

- add info on the filtering steps
- make multiqc work
---


## Run locally, without conda

1. Install
    - [`snakemake`](https://snakemake.readthedocs.io/en/stable/#)
    - [`fastp`](https://github.com/OpenGene/fastp)
    - [`multiqc`](https://multiqc.info/)
2. Clone the repository: `git clone https://github.com/Naturhistoriska/fastp-cleaning.git`
3. Put input data (gzip-compressed paired-end illumina fastq files) in folder `fastp-cleaning/input`
4. Review the `fastp-cleaning/config/config.yaml` and make sure input file name endings (currently `_R1_001.fastq.gz`),
   matches your input files, and change options for software used if needed.
5. Make sure your current working directory is `fastp-cleaning`
6. Test run `snakemake -n`
7. Run with `snakemake --cores N` (substitute N with the number of cores you wish to use)

## Run locally, with conda

1. Install
    - [`snakemake`](https://snakemake.readthedocs.io/en/stable/#)
    - [`conda`](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html)
2. Clone the repository: `git clone https://github.com/Naturhistoriska/fastp-cleaning.git`
3. Put input data (gzip-compressed paired-end illumina fastq files) in folder `fastp-cleaning/input`
4. Review the `fastp-cleaning/config/config.yaml` and make sure input file name endings (currently `_R1_001.fastq.gz`),
   matches your input files, and change options for software used if needed.
5. Make sure your current working directory is `fastp-cleaning`
6. Test run `snakemake --use-conda -n`
7. Run with `snakemake --use-conda --cores N` (substitute N with the number of cores you wish to use)

## Run on UPPMAX

1. Log in to uppmax (rackham.uppmax.uu.se)
2. Clone the repository in a project folder: `git clone https://github.com/nylander/fastp-cleaning.git`
3. Edit the file `fastp-cleaning/config/cluster.yaml` to add your CPU project account number
4. Add input files (use symlinks to save space) to `fastp-cleaning/input/`
5. Review the `fastp-cleaning/config/config.yaml` and make sure input file name endings (currently `_R1_001.fastq.gz`),
   matches your input files, and change options for software used if needed.
6. Start a screen session: `screen -S fast-cleaning`
7. Load modules: `module load bioinfo-tools snakemake`
8. Change directory to `fastp-cleaning` and test run: `snakemake -n --use-conda --profile slurm -j 100`
9. Run: `snakemake --use-conda --profile slurm -j 100`
