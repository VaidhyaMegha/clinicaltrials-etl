#!/usr/bin/env bash
set -x

rm -f ${1}/processed.log

find ${1} -type f -name "*.json" | while read f
do
    echo ${f} >> ${1}/processed.log
    jq ".id_info.nct_id" ${f}  >> ${1}/processed.log 2>&1
done

grep 'error'  ${1}/processed.log | wc -l