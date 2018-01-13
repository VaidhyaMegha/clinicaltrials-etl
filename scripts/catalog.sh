#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset, as zip files, as argument
# ./scripts/catalog.sh datasets/datainsights-results/data.gov.in/api/download

input=$1

rm catalog.csv

## now loop through the above array
find ${input} | grep json | xargs -I {} cat {} | grep -oE "\"title\":\"[^\"]*\"" | while read f
do
    f=${f//\"title\":/}
    echo "\"data.gov.in\","${f} >> catalog.csv
done
