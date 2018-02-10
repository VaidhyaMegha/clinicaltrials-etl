#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset as argument
# ./ncrb.gov.in/transform.sh datainsights-in/crime/ncrb.gov.in datainsights-results/crime/ncrb.gov.in


source $(pwd)/env.sh
source $(pwd)/utility.sh

OUT_DIR=${2:-'temp/ncrb.gov.in'}

cleanup  ${DATA_HOME}/${OUT_DIR}

pushd ${DATA_HOME}/${1}

function transform_file() {
    g=$(dirname ${1})
    mkdir -p ${g}
    gs -sDEVICE=txtwrite -o "${1}" "${2}" || true
}

## now loop through the above array
find find . -type f -name "*pdf" | while read f
do
    f=${f//\.\//}
    transform_file "${DATA_HOME}/${OUT_DIR}/${f}.txt" "${DATA_HOME}/${1}/${f}" &
done

popd