#!/usr/bin/env bash
set -ex

function genJSON(){
    g=${1//.xml/}

    sed "s/&quot;/ /g; s/\\\/ /g;" ${1} > ${1}.tmp
    xmlstarlet tr xml_json.xslt ${1}.tmp > ${g}.json.tmp

    tr '\n' ' ' < ${g}.json.tmp > ${g}.json

    rm ${1}.tmp
    rm ${g}.json.tmp
}

xml_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://datainsights-results/ct-adapter/'}
context_dir=${4:-'/usr/local/dataintegration'}

pushd ${context_dir}

if [[ ${download} == 'yes' ]]; then
    wget https://clinicaltrials.gov/AllPublicXML.zip

    unzip -q AllPublicXML.zip -d ${xml_dir}

    rm -f AllPublicXML.zip

    find ${xml_dir} -type f -name "*.xml" | while read f
    do
        genJSON ${f} &
    done

    aws s3 sync  ${xml_dir} ${s3_bucket}
else
    find ${xml_dir} -type f -name "*.json" -delete
    find ${xml_dir} -type f -name "*.log" -delete

    find ${xml_dir} -type f -name "*.xml" | while read f
    do
        genJSON ${f} &
    done
fi

popd