#!/usr/bin/env bash
set -ex

function genJSON(){
    g=${1//.xml/}

    sed "s/&quot;/ /g; s/\\\/ /g;" ${1} > ${1}.tmp
    xmlstarlet tr xml_json.xslt ${1}.tmp > ${g}.json.tmp

    tr '\n' ' ' < ${g}.json.tmp > ${g}.json

    rm ${1}.tmp
    rm ${g}.json.tmp

    jq ".id_info.nct_id" ${g}.json  >> ${g}.log 2>&1
}

xml_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://datainsights-results/ct-adapter/'}

if [[ ${download} == 'yes' ]]; then
    wget https://clinicaltrials.gov/AllPublicXML.zip .

    unzip AllPublicXML.zip -d ${xml_dir}
else
    find ${xml_dir} -type f -name "*.json" -delete
    find ${xml_dir} -type f -name "*.log" -delete
fi

find ${xml_dir} -type f -name "*.xml" | while read f
do
    genJSON ${f} &
done

if [[ ${download} == 'yes' ]]; then
    aws s3 sync  ${xml_dir} ${s3_bucket}
fi