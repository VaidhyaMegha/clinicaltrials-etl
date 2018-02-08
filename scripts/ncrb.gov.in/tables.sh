#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset as argument
# ./ncrb.gov.in/tables.sh datainsights-in/ncrb.gov.in/ datainsights-results/ncrb.gov.in/


source $(pwd)/env.sh
source $(pwd)/utility.sh

OUT_DIR=${2:-'temp/ncrb.gov.in'}

cleanup  ${DATA_HOME}/${OUT_DIR}


prefix_url="http://ncrb.gov.in/StatPublications/CII/CII2016/"
suffix_url=""

function download_doc(){
    f=${1}
    f=${f//href=/}
    f=${f//\"/}
    g=${f//\//}
    h=$( dirname ${f} )

    mkdir -p ${DATA_HOME}/${OUT_DIR}/${h}

    wget --force-directories -q ${prefix_url}${f}${suffix_url} \
         -O ${DATA_HOME}/${OUT_DIR}/${f} -o ${LOG_HOME}/${g}.log || true
}

## now loop through the above array
find ${DATA_HOME}/${1} | grep html | xargs -I {} cat {} | grep -oE "href=\"[^\"]*\"" | while read f
do
    download_doc ${f} &
    sleep 1s
done