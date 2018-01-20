#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset, as zip files, as argument
# ./clinicaltrials/aact/extract.sh  "../datasets/datainsights-in/clinicaltrials/aact" "../temp/clinicaltrials/aact"


source $(pwd)/utility.sh

OUT_DIR=${2:-'temp/clinicaltrials/aact'}

cleanup  ${OUT_DIR}
prepare ${1} "20180111_pipe-delimited-export.zip" ${OUT_DIR}