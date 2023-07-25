REMAT_ARRAY=("full")
USE_INT8_TRAINING_ARRAY=("true")
DTYPE_ARRAY=("bfloat16")
USE_FWD_QUANT_ARRAY=("false")
PRNG_KEY_ARRAY=(4 5 6 7 8 9 10 11)

for REMAT_POLICY in ${REMAT_ARRAY[@]}; do
    for USE_INT8_TRAINING in ${USE_INT8_TRAINING_ARRAY[@]}; do
        for DTYPE in ${DTYPE_ARRAY[@]}; do
            for USE_FWD_QUANT in ${USE_FWD_QUANT_ARRAY[@]}; do
                for PRNG_KEY in ${PRNG_KEY_ARRAY[@]}; do

                    echo "Remat: ${REMAT_POLICY}, int8: ${USE_INT8_TRAINING}, dtype: ${DTYPE}, PRNG_KEY: ${PRNG_KEY}"
                    RUN_NAME=mattdavidow-20230718_remat_${REMAT_POLICY}_useint8_${USE_INT8_TRAINING}_dtype_${DTYPE}_PRNGKey_${PRNG_KEY}_fwdquant_${USE_FWD_QUANT}
                    echo "Running the above setting with RUN_NAME ${RUN_NAME}"
                    python3 multihost_job.py --BUCKET_NAME="mattdavidow-maxtext-br" --RUN_NAME=${RUN_NAME} --TPU_TYPE=v5litepod-256 --NUM_SLICES=1 --VERSION=v2-alpha-tpuv5-lite --COMMAND="bash setup.sh && bash MaxText/configs/1b-experiments-7-18-23-forward.sh ${REMAT_POLICY} ${USE_INT8_TRAINING} ${DTYPE} ${USE_FWD_QUANT} ${PRNG_KEY} ${RUN_NAME}" --CQR_EXTRA_ARGS="--reserved" --ZONE=us-west4-a
                done
            done        
        done
    done
done