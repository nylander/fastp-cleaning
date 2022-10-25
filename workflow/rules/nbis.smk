if config["nbis"]:
    citations.add(publications["seqkit"])
    if config["fastp_merge"]:
        readpairs=["R1", "R2", "R12"]
    else:
        readpairs=["R1", "R2"]
    tsv_files=expand(str(FASTADIR/"{sample}_{readpair}.tsv"),
            sample=SAMPLES,
            readpair=readpairs)
    all_outputs.extend(tsv_files)
    seqkit_config = config["seqkit"]
    extra=seqkit_config["extra"]
    rule search_fas:
        input:
            fas=FASTADIR/"{sample}_{readpair}.fas"
        output:
            tsv=FASTADIR/"{sample}_{readpair}.tsv"
        log:
            stdout=str(LOGDIR/"seqkit/{sample}_{readpair}.stdout.log"),
            stderr=str(LOGDIR/"seqkit/{sample}_{readpair}.stderr.log"),
        conda:
            "../envs/fastp-cleaning.yaml"
        threads:
            seqkit_config["n"]
        params:
            extra=extra
        shell:
            """
            # TODO: script that parses the list.tab, and
            # finds the relevant parts etc
            seqkit amplicon \
                {extra} \
                -F CTTGCTCAT \
                -R CTCCACTCAT \
                --max-mismatch 0 \
                -j {threads} \
                --only-positive-strand \
                -o {output.tsv} \
                {input.fas} > {log.stdout} 2> {log.stderr}

            """


