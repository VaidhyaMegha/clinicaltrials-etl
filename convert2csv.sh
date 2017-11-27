#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset, as zip files, as argument
# ./convert2csv.sh  datasets/datainsights-in


# Cleanup
rm -f file_headers.csv
rm -rf temp

mkdir temp

# Find and unzip zip files into temp directory
find $1 -iname "*.zip" | while read f
do
     unzip ${f} -d temp/
done

# Convert to CSV
find temp -iname "*.xls" | while read f
do
     libreoffice --headless --convert-to csv "${f}" --outdir "$(dirname "${f}")"
done


# Pick Header rows
find temp -iname "*.csv" | while read f
do
    cat "${f}" | grep -i "Number" | sed  's/,/\n/g'  | xargs -I line echo "${f},"line >>  file_headers.csv
done


# find unique columns
cat file_headers.csv | cut -d| -f2 |  sort -u  > headers.csv

