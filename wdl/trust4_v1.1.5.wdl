version 1.2


task TRUST4bamhg38 {
    input {
        File bam
        File BCR_TCR_ref
        File IGMT_C_ref
        String samplename
        Int thread
        Int stage
        Int memory
    }

    command {
        /usr/bin/run-trust4 -b ${bam} \
          -f ${BCR_TCR_ref} --ref ${IGMT_C_ref} \
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
