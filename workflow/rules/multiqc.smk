if config["multiqc_report"]:

    citations.add(publications["multiqc"])

    mqc_config = config["multiqc"]

    rule multiqc:
        input:
            all_outputs
        output:
            report=report(f"{OUTPUTDIR}/multiqc/multiqc_report.html",
            category="Sequencing data quality",
            caption="../report/multiqc.rst"),
        log:
            f"{LOGDIR}/multiqc/multiqc.log"
        shadow:
            "shallow"
        conda:
            "../envs/fastp-cleaning.yaml"
        threads:
            1
        params:
            extra=mqc_config["extra"],
        shell:
            """
            multiqc {OUTPUTDIR} \
                --filename {output.report} \
                --force \
                2> {log}
            """

    # Appended after the rule definition to avoid circular dependency
    all_outputs.append(f"{OUTPUTDIR}/multiqc/multiqc_report.html")
