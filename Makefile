# Makefile for fastpcleaning
# Last modified: mån nov 15, 2021  04:26
# Sign: JN

.PHONY: all run debug dryrun report slurm-init slurm-run clean

all: run

run:
	snakemake --use-conda --jobs

debug:
	snakemake --use-conda --jobs --printshellcmds --notemp --reason

dryrun:
	snakemake --use-conda --jobs --printshellcmds --dry-run

report:
	snakemake --report fastp-cleaning-report.html

slurm-run:
	snakemake --use-conda --profile slurm -j 100

clean:
	rm -rf *.rst .snakemake ./workflow/rules/__pycache__

distclean:
	rm -rf .snakemake output *.rst *-report-*.html slurm/stderr slurm/stdout slurm/__pycache__ ./workflow/rules/__pycache__

