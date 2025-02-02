task TRUST4bamhg38 {
    input {
        File bam
        String samplename
        Int thread
        Int stage
        Int memory
    }

    command {
        /home/TRUST4/run-trust4 -b ${bam} \
          -f /home/TRUST4/hg38_bcrtcr.fa --ref /home/TRUST4/human_IMGT+C.fa \
          -o ${samplename} \
          -t ${thread} \
          --stage ${stage}
    }

    output {
        File out_cdr3 = "${samplename}_cdr3.out"
        File trust4final = "${samplename}_final.out"
        File trust4report = "${samplename}_report.tsv"
    }

    runtime {
        docker: "quay.io/biocontainers/trust4:1.1.5--h5ca1c30_0"
        memory: "${memory} GB"
    }
}
