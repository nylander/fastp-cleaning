citations.add(publications["fastp"])

trimmed_qc = expand(str(FASTQDIR/"{sample}_{readpair}.fq.gz"),
    sample = SAMPLES,
    readpair = ["R1", "R2"])
all_outputs.extend(trimmed_qc)

fastp_config = config["fastp"]
if config["run_fastp_dedup"]:
    extra = fastp_config["extra"] + " --dedup --dup_calc_accuracy "+str(fastp_config["dup_calc_accuracy"])
else:
    extra = fastp_config["extra"]

rule fastp:
    input:
        read1 = INPUTDIR/config["fn_pattern"].format(sample = "{sample}", readpair = "R1"),
        read2 = INPUTDIR/config["fn_pattern"].format(sample = "{sample}", readpair = "R2")
    output:
        read1 = FASTQDIR/"{sample}_R1.fq.gz",
        read2 = FASTQDIR/"{sample}_R2.fq.gz",
        merged = FASTQDIR/"{sample}_R12.fq.gz",
        unpaired1 = FASTQDIR/"{sample}_R1_unpaired.fq.gz",
        unpaired2 = FASTQDIR/"{sample}_R2_unpaired.fq.gz",
        html = FASTPDIR/"{sample}.fastp.html",
    log:
        LOGDIR/"fastp/{sample}.fastp.log"
    shadow:
        "shallow"
    conda:
        "../envs/fastp-cleaning.yaml"
    threads:
        cluster_config["fastp"]["n"] if "fastp" in cluster_config else fastp_config["n"]
    params:
        extra = extra
    shell:
        """
        fastp \
            --merge \
            --in1 {input.read1} \
            --in2 {input.read2} \
            --merged_out {output.merged} \
            --out1 {output.read1} \
            --out2 {output.read2} \
            --unpaired1 {output.unpaired1}\
            --unpaired2 {output.unpaired2}\
            --html {output.html} \
            --thread {threads} \
            {params.extra} \
            &> {log}
        """

