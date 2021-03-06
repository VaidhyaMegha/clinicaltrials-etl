#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset, as zip files, as argument
# ./HMIS/convert2csv.sh  datasets/datainsights-in/nrhm-mis.nic.in


source $(pwd)/env.sh
source $(pwd)/utility.sh

OUT_DIR="temp/HMIS"

cleanup OUT_DIR
prepare ${1} "*.zip" OUT_DIR


# Convert to CSV
find ${OUT_DIR} -iname "*.xls" | while read f
do
     libreoffice --headless --convert-to csv "${f}" --outdir "$(dirname "${f}")"
done


# Pick Header rows
find ${OUT_DIR} -iname "*.csv" | while read f
do
    cat "${f}" | grep -ai "Number" | sed  's/,/\n/g'  | xargs -I line echo "${f},"line >>  ${OUT_DIR}/file_headers.csv
done


# find unique columns
cat ${OUT_DIR}/file_headers.csv | cut -d, -f2 |  sort -u  > ${OUT_DIR}/headers.csv

