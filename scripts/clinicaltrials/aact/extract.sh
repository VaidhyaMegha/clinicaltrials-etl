#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset, as zip files, as argument
# ./clinicaltrials/aact/extract.sh  "../data/datainsights-in/clinicaltrials/aact" "../data/datainsights-results/clinicaltrials/aact"


source $(pwd)/env.sh
source $(pwd)/utility.sh

OUT_DIR=${2:-'temp/clinicaltrials/aact'}

cleanup  ${OUT_DIR}

prepare ${1} "20180111_pipe-delimited-export.zip" ${OUT_DIR}

find ${OUT_DIR} -type f  | while read f
do

    head -n 1 ${f} | sed  's/|/\n/g'  | xargs -I line echo "${f},"line >>  ${OUT_DIR}/file_headers.csv
    gzip ${f}
done