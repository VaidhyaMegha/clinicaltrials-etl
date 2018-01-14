#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset, as zip files, as argument
# ./scripts/convert2json.sh  datasets/datainsights-in


#./scripts/convert2csv.sh $1


# Pick Header rows
find temp -iname "*.csv" | while read f
do
    g=${f//\.csv/\.json}
    h="[\""$(cat "${f}" | grep -ai "Number" | sed  's/,/\",\"/g' )"\"]"
    h=${h// /-}
    csvtojson parse --headers=${h} "${f}" > "${g}"
done


