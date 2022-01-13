# Makefile for fastp-cleaning

.PHONY: all run debug dryrun report slurm-run clean distclean

all: run

run:
	snakemake --use-conda --jobs

debug:
	snakemake --use-conda --jobs --printshellcmds --notemp --reason

dryrun:
	snakemake --use-conda --jobs --printshellcmds --dry-run

report:
	snakemake --report fastp-cleaning-report.html

#slurm-run:
#	module load bioinfo-tools; \
#	module load conda; \
#	module load snakemake/5.30.1; \
#	mkdir -p conda_envs; \
#	export CONDA_ENVS_PATH=$$PWD/conda_envs; \
#	snakemake --use-conda --profile rackham -j 100;

slurm-run:
	snakemake --use-conda --profile rackham -j 100

clean:
	rm -rf *.rst .snakemake ./workflow/rules/__pycache__

distclean:
	rm -rf conda_envs .snakemake output *.rst *-report-*.html slurm/stderr slurm/stdout slurm/__pycache__ ./workflow/rules/__pycache__

