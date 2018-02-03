#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset, as zip files, as argument
# ./scripts/HMIS/catalog.sh datasets/datainsights-results/HMIS/

input=$1

rm -f ${input}/catalog.csv

## now loop through the above array

echo "S3FilePath|FileGUID|Source|Sector|Organization|Title" > ${input}/catalog.csv

find ${input} | grep json | while read f
do
    f=${f//datasets\//}
    index_name=`python -c "from sys import argv;print(hash(argv[1]))" ${f}`
    source="HMIS"
    sector="Health"
    org="Ministry of Health & Family Welfare"
    title=`echo "${f}" | sed "s/.*\///"`

    echo "\""${f}"\"|\"${index_name}\"|\"${source}\"|\"${sector}\"|\"${org}\"|\"${title}\"" >> ${input}/catalog.csv
done
