# fastp-cleaning

- Last modified: tor okt 27, 2022  10:11
- Sign: nylander

## Description

Filter fastq files using [fastp](https://github.com/OpenGene/fastp).

### Input

- gzipped paired-end Illumina `.fastq.gz` files. Example data (138M gzipped)
  can be downloaded here: <https://owncloud.nrm.se/index.php/s/iT8SCXRwKTqUU3q>

### Output

- filtered `.fq.gz` files placed in a new output directory
- filtering reports (before/after)
- merged pair-end reads `.fq.gz` files (optional)
- fasta files from filtered fastq (optional)

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
7. Convert the filtered fastq filies to fasta (optional, by editing the
   [config.yaml](config/config.yaml) file)

Please see the [fastp-manual](https://github.com/OpenGene/fastp/wiki) for
details on the filtering procedures.

---

## How to run locally, without conda

1. Install
    - [`snakemake`](https://snakemake.readthedocs.io/en/stable/#)
    - [`fastp`](https://github.com/OpenGene/fastp)
    - [`seqtk`](https://github.com/lh3/seqtk)
2. Clone the repository: `git clone
https://github.com/nylander/fastp-cleaning.git`
3. Put input data (gzip-compressed paired-end Illumina fastq files) in folder
`fastp-cleaning/input`
4. Review the `fastp-cleaning/config/config.yaml` and make sure input file name
endings (currently `_R1_001.fastq.gz`), matches your input files, select the
steps used by the pipeline, and change options for software used if needed.
5. Make sure your current working directory is `fastp-cleaning`
6. Test run `snakemake -n`
7. Run with `snakemake --cores N` (substitute N with the number of cores you
wish to use)

## How to run locally, with conda

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

## How to run on UPPMAX

Note: On rackham we are loading conda and snakemake (v.5) as modules.  This can
be done manually or using a script
([rackham/scripts/init.sh](rackham/scripts/init.sh)).  For convenience, we also
start the run with the [Makefile](Makefile).

1. Log in to [UPPMAX](https://uppmax.uu.se/) (rackham.uppmax.uu.se)
2. Clone the repository in a project folder: `git clone
   https://github.com/nylander/fastp-cleaning.git`
3. Edit the file `fastp-cleaning/rackham/rackham.yaml` to add your CPU-project
   account number. For example: `sed -i -e 's/snic1234-56-789/snic2022-01-001/'
   rackham/rackham.yaml`.
4. Add input files (use symbolic links to save space) to
   `fastp-cleaning/input/`
5. Review the `fastp-cleaning/config/config.yaml` and make sure input file-name
   endings (currently `_R1_001.fastq.gz`), matches your input files, select the
   steps used by the pipeline, and change options for software used if needed.
6. Start a screen session: `screen -S fast-cleaning`
7. Load modules: `source rackham/scripts/init.sh`
8. Test run: `make slurm-test`
9. Run: `make slurm-run`
10. Detach from the screen session (Ctrl+A, Ctrl+D).

## TODO

- Add info on the filtering steps

## Acknowledgements

The pipeline was heavily influenced by the
[stag-mwc](https://github.com/ctmrbio/stag-mwc) pipeline.

## License and copyright

Copyright (c) 2021, 2022 Johan Nylander

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

