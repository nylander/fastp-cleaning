if config["fastq_to_fasta"]:
    citations.add(publications["seqtk"])
    if config["fastp_merge"]:
        readpairs=["R1", "R2", "R12"]
    else:
        readpairs=["R1", "R2"]
    fasta_files=expand(str(FASTADIR/"{sample}_{readpair}.fas"),
            sample=SAMPLES,
            readpair=readpairs)
    all_outputs.extend(fasta_files)
    seqtk_config = config["seqtk"]
    extra=seqtk_config["extra"]
    rule fq2fas:
        input:
            fqgz=FASTQDIR/"{sample}_{readpair}.fq.gz"
            #fas=FASTQDIR/config["input_fggz_pattern_pattern"].format(sample="{sample}", readpair=readpairs)
        output:
            fas=FASTADIR/"{sample}_{readpair}.fas"
            #fas=FASTADIR/config["output_fas_pattern"].format(sample="{sample}", readpair=readpairs)
        log:
            stdout=str(LOGDIR/"seqtk/{sample}_{readpair}.stdout.log"),
            stderr=str(LOGDIR/"seqtk/{sample}_{readpair}.stderr.log"),
        conda:
            "../envs/fastp-cleaning.yaml"
        params:
            extra=extra
        shell:
            "seqtk seq -a {input.fqgz} {params.extra} > {output.fas} 2> {log.stderr}"


