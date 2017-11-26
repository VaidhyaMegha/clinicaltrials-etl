#!/usr/bin/env bash
set -ex

# Cleanup
rm headers.csv
find $1 -name "*.csv" -delete

# Convert to CSV
find $1 -iname "*.xls" | while read f
do
     libreoffice --headless --convert-to csv "${f}" --outdir "$(dirname "${f}")"
done


# Pick Header rows
find $1 -iname "*.csv" | while read f
do
    cat "${f}" | grep -i "Number" | sed  's/,/\n/g'  | sort -u  >>  headers.csv
done


# find unique columns
cat headers.csv | sort -u  > headers_unique.csv


find $1 -iname "*.csv" | while read f
do
    cat "${f}" | grep -i "Number of Infants given BCG"  >>  headers.csv
done