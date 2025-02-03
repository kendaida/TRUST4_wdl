version 1.0

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
        run-trust4 -b ${bam} \
          -f ${BCR_TCR_ref} --ref ${IGMT_C_ref} \
          -o ${samplename} \
          -t ${thread} \
          --stage ${stage}


        ls -lh ${samplename}_cdr3.out ${samplename}_final.out ${samplename}_report.tsv
    }

    output {
        File out_cdr3 = "${samplename}_cdr3.out"
        File trust4final = "${samplename}_final.out"
        File trust4report = "${samplename}_report.tsv"
    }

    runtime {
        docker: "quay.io/biocontainers/trust4:1.1.5--h5ca1c30_0"
        memory: "${memory} GB"
        disks: "local-disk ${size(bam) + 50} HDD"
    }
}

workflow TRUST4workflow {
    input {
        File bam
        File BCR_TCR_ref
        File IGMT_C_ref
        String samplename  # Make sure this is explicitly declared
        Int thread = 8
        Int stage = 0
        Int memory = 16
    }

    call TRUST4bamhg38 { input: bam=bam, BCR_TCR_ref=BCR_TCR_ref, IGMT_C_ref=IGMT_C_ref, samplename=samplename, thread=thread, stage=stage, memory=memory }

    output {
        File out_cdr3 = TRUST4bamhg38.out_cdr3
        File trust4final = TRUST4bamhg38.trust4final
        File trust4report = TRUST4bamhg38.trust4report
    }
}
