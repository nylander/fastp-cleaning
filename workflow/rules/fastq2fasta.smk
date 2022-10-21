if config["fastq_to_fasta"]:

    citations.add(publications["seqtk"])

    seqtk_config = config["seqtk"]
    extra=seqtk_config["extra"]

    # TODO: If we did run merge, the file pattern to look for should
    # be {sample}_L001_R12.fq.gz in the "output/fastp/" folder,
    # Else _L001_R1.fq.gz and _L001_R2.fq.gz.
    # Another alternative may be to run all "{file}.fq.gz" files.
    # Start with that option.

    rule fq2fas:
        input:
            fqgz=OUTDIR/{file}.fq.gz
        output:
            fas=OUTDIR/seqtk/{file}.fas
        log:
            stdout=str(LOGDIR/"seqtk/{sample}.stdout.log"),
            stderr=str(LOGDIR/"seqtk/{sample}.stderr.log"),
        conda:
            "../envs/fastp-cleaning.yaml"
        shell:
            "seqtk seq -a {input.fqgz} > {output.fas}

