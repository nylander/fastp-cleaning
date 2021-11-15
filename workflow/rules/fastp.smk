if config["run_fastp"]:
    citations.add(publications["fastp"])
    trimmed_qc = expand(str(OUTDIR/"fastp/{sample}_{readpair}.fq.gz"),
            sample=SAMPLES,
            readpair=["R1", "R2"])
    all_outputs.extend(trimmed_qc)
    fastp_config = config["fastp"]
    rule fastp:
        input:
            read1=INPUTDIR/config["input_fn_pattern"].format(sample="{sample}", readpair="R1"),
            read2=INPUTDIR/config["input_fn_pattern"].format(sample="{sample}", readpair="R2")
        output:
            read1=OUTDIR/"fastp/{sample}_R1.fq.gz",
            read2=OUTDIR/"fastp/{sample}_R2.fq.gz",
            html=LOGDIR/"fastp/{sample}.fastp.html",
        log:
            stdout=str(LOGDIR/"fastp/{sample}.stdout.log"),
            stderr=str(LOGDIR/"fastp/{sample}.stderr.log"),
        shadow:
            "shallow"
        conda:
            "../envs/fastp-cleaning.yaml"
        threads:
            cluster_config["fastp"]["n"] if "fastp" in cluster_config else 4
        params:
            extra=fastp_config["extra"],
        shell:
            """
            fastp \
                --in1 {input.read1} \
                --in2 {input.read2} \
                --out1 {output.read1} \
                --out2 {output.read2} \
                --html {output.html} \
                --thread {threads} \
                {params.extra} \
                > {log.stdout} \
                2> {log.stderr}
            """
