#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset as argument
# ./ctri.nic.in/transform.sh datainsights-results/ctri.nic.in/pdfs datainsights-results/ctri.nic.in/txt


source $(pwd)/env.sh
source $(pwd)/utility.sh

OUT_DIR=${2:-'temp/ctri.nic.in'}

cleanup  ${DATA_HOME}/${OUT_DIR}

function transform_file() {
    gs -sDEVICE=txtwrite -o  ${1} ${2}
}

## now loop through the above array
ls ${DATA_HOME}/${1} | grep -oE "[^ ]*\.pdf" | while read f
do
    transform_file ${DATA_HOME}/${OUT_DIR}/${f}.txt ${DATA_HOME}/${1}/${f} &
done
