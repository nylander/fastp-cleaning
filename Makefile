# Makefile for fastpcleaning
# Last modified: ons jan 12, 2022  12:29
# Sign: JN

.PHONY: all run debug dryrun report slurm-init slurm-run slurm-cmd clean

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
	snakemake --use-conda --profile slurm -j 100

slurm-init:
	module load bioinfo-tools snakemake

slurm-run: slurm-init slurm-cmd

clean:
	rm -rf *.rst .snakemake ./workflow/rules/__pycache__

distclean:
	rm -rf .snakemake output *.rst *-report-*.html slurm/stderr slurm/stdout slurm/__pycache__ ./workflow/rules/__pycache__

