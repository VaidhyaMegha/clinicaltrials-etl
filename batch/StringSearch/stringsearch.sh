#!/usr/bin/env bash
set -ex

s3_bucket=${1:-'s3://leucinerichbio/'}
context_dir=${2:-'/usr/local/dataintegration'}
mode=${3:-'cloud'}
FA_FILE_NAME=${4:-'hg38.fa'}
FQ_FILE_NAME=${5:-'SRR8278846_1.fastq'}
RESULT_FILE_NAME=${6:-'results_1.tsv'}

pushd ${context_dir}

aws s3 cp ${s3_bucket}${FA_FILE_NAME}.gz ${context_dir}/
aws s3 cp ${s3_bucket}${FQ_FILE_NAME}.gz ${context_dir}/

gunzip ${context_dir}/${FA_FILE_NAME}.gz
gunzip ${context_dir}/${FQ_FILE_NAME}.gz

grep -oE "[A|T|C|G|a|t|c|g]+" ${context_dir}/${FA_FILE_NAME}  > ${context_dir}/${FA_FILE_NAME}.cleaned



grep "^@" -A 1 ${FQ_FILE_NAME} | grep  -v "^@" | grep  -v "^#" | grep  -v "-" | head -n 1000000 | java -jar -Xmx4G StringSearch-1.0-SNAPSHOT.jar ${FA_FILE_NAME}.cleaned 101 ${RESULT_FILE_NAME}



if [[ ${mode} == 'cloud' ]]; then
    aws s3 cp ${RESULT_FILE_NAME} ${s3_bucket}${RESULT_FILE_NAME}
fi

popd
