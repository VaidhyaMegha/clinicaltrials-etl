#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset, as zip files, as argument
# ./HMIS/convert2json.sh  temp/nrhm-mis.nic.in


# Pick Header rows
find ${1} -iname "*.csv" | while read f
do
    g=${f//\.csv/\.json}
    h="[\""$(cat "${f}" | grep -ai "Number" | sed  's/,/\",\"/g' )"\"]"
    h=${h// /-}
    csvtojson parse --headers=${h} "${f}" > "${g}"
done


