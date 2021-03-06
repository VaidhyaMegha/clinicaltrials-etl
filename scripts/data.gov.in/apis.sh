#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset as argument
# ./scripts/data.gov.in/apis.sh datainsights-in/data.gov.in/ datainsights-results/data.gov.in/api/


source $(pwd)/env.sh
source $(pwd)/utility.sh

OUT_DIR=${2:-'temp/data.gov.in/api/'}

cleanup  ${OUT_DIR}


prefix_url="https://api.data.gov.in/resource"
suffix_url="&api-key="${api_key}

formats=( "json" "csv" "xml" )


## now loop through the above array
for i in ${!formats[*]}; do
    find ${DATA_HOME}/${1} | grep html | xargs -I {} cat {} | grep -oE "/[^/]*/api" | while read f
    do
        f=${f//\/api/}
        wget -q ${prefix_url}${f}"?format="${formats[${i}]}${suffix_url} \
             -O ${OUT_DIR}/${f}.${formats[${i}]} -o ${LOG_HOME}/${f}.${formats[${i}]}.log || true
    done
done