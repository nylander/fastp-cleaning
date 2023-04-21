# Makefile for fastp-cleaning

# Last modified: fre apr 21, 2023  04:32
# Sign: JN

.PHONY: all run debug dryrun report slurm-test slurm-run clean distclean

all: run

run:
	snakemake --use-conda --jobs

debug:
	snakemake --use-conda --jobs --printshellcmds --notemp --reason

dryrun:
	snakemake --use-conda --jobs --printshellcmds --dry-run

report:
	snakemake --report workflow-report.html

slurm-test:
	snakemake --dry-run --printshellcmds --use-conda --profile rackham -j 100

slurm-run:
	snakemake --use-conda --profile rackham -j 100

clean:
	rm -rf *.rst .snakemake ./workflow/rules/__pycache__

distclean:
	rm -rf conda_envs .snakemake output *.rst *-report-*.html slurm/stderr slurm/stdout slurm/__pycache__ ./workflow/rules/__pycache__

