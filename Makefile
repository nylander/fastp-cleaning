# Makefile for fastp-cleaning

.PHONY: all run debug dryrun report slurm-init slurm-run slurm-cmd clean distclean

all: run

run:
	snakemake --use-conda --jobs

debug:
	snakemake --use-conda --jobs --printshellcmds --notemp --reason

dryrun:
	snakemake --use-conda --jobs --printshellcmds --dry-run

report:
	snakemake --report fastp-cleaning-report.html

slurm-cmd:
	snakemake --use-conda --profile rackham -j 100

slurm-init:
	module load bioinfo-tools conda snakemake/5.30.1 && mkdir -p cond && export CONDA_ENVS_PATH="$$PWD"/cond

slurm-run: slurm-init slurm-cmd

clean:
	rm -rf *.rst .snakemake ./workflow/rules/__pycache__

distclean:
	rm -rf .snakemake output *.rst *-report-*.html slurm/stderr slurm/stdout slurm/__pycache__ ./workflow/rules/__pycache__

