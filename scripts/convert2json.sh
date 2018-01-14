#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset, as zip files, as argument
# ./scripts/convert2json.sh  datasets/datainsights-in


./scripts/convert2csv.sh $1


# Pick Header rows
find temp -iname "*.csv" | while read f
do
    g=${f//\.csv/\.json}
    csvtojson parse --noheader=true "${f}" > "${g}"
done


