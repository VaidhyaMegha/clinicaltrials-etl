#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset as argument
# ./ncrb.gov.in/transform.sh datainsights-results/ncrb.gov.in/pdfs datainsights-results/ncrb.gov.in/txt


source $(pwd)/env.sh
source $(pwd)/utility.sh

OUT_DIR=${2:-'temp/ncrb.gov.in'}

cleanup  ${DATA_HOME}/${OUT_DIR}

function transform_file() {
    f=${1}
    f=${f//%20/}

    gs -sDEVICE=txtwrite -o "${f}" "${2}" || true
}

## now loop through the above array
ls ${DATA_HOME}/${1} | grep -oE "[^ ]*\.pdf" | while read f
do
    transform_file ${DATA_HOME}/${OUT_DIR}/${f}.txt ${DATA_HOME}/${1}/${f} &
done
