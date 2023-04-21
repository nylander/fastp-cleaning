citations.add(publications["seqtk"])

if config["run_fastp_merge"]:
    readpairs = ["R1", "R2", "R12"]
else:
    readpairs = ["R1", "R2"]

fasta_files = expand(str(FASTADIR/"{sample}_{readpair}.fas"),
    sample = SAMPLES,
    readpair = readpairs)
all_outputs.extend(fasta_files)

fastq_to_fasta_config = config["fastq_to_fasta"]
extra = fastq_to_fasta_config["extra"]

rule fastq_to_fasta:
    input:
        fqgz = FASTQDIR/"{sample}_{readpair}.fq.gz"
    output:
        fas = FASTADIR/"{sample}_{readpair}.fas"
    log:
        LOGDIR/"fastq_to_fasta/{sample}_{readpair}.log"
    conda:
        "../envs/fastp-cleaning.yaml"
    params:
        extra = extra
    shell:
        """
        seqtk seq -a {input.fqgz} {params.extra} > {output.fas} 2> {log}
        """


