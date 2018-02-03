#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset, as zip files, as argument
# ./iscripts/data.gov.in/catalog.sh datasets/datainsights-results/data.gov.in/api

input=$1

rm -f ${input}/catalog.csv

## now loop through the above array

echo "S3FilePath|FileGUID|Source|Sector|Organization|Title" > ${input}/catalog.csv

find ${input} | grep json | while read f
do
    index_name=$(jq '.index_name' ${f})
    source=$(jq '.source' ${f})
    sector=$(jq '.sector' ${f})
    org=$(jq '.org' ${f})
    title=$(jq '.title' ${f})

    f=${f//datasets\//}

    echo "\""${f}"\"|"${index_name}"|"${source}"|"${sector}"|"${org}"|"${title} >> ${input}/catalog.csv
done
