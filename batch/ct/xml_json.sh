#!/usr/bin/env bash
set -ex

function genJSON(){
    g=$( basename ${1} )
    g=${g//.xml/}

    sed "s/&quot;/ /g; s/\\\/ /g;" ${1} > ${1}.tmp
    xmlstarlet tr xml_json.xslt ${1}.tmp > ${g}.json.tmp

    tr '\n' ' ' < ${g}.json.tmp > ${2}/json_per_study/${g}.json
    echo "" >> ${2}/json_per_study/${g}.json

    rm ${1}.tmp
    rm ${g}.json.tmp
}

xml_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/ct-adapter/'}
context_dir=${4:-'/usr/local/dataintegration'}

pushd ${context_dir}

if [[ ${download} == 'yes' ]]; then
    wget https://clinicaltrials.gov/AllPublicXML.zip

    unzip -q AllPublicXML.zip -d ${xml_dir}

    rm -f AllPublicXML.zip

    mkdir ${xml_dir}/json_per_study
    mkdir ${xml_dir}/json

    find ${xml_dir} -type f -name "*.xml" | while read f
    do
        genJSON ${f} ${xml_dir} &
    done

    sleep 30s

    find ${xml_dir}/json_per_study -type f -name "*.json" | while read f
    do
        cat ${f} >> ${xml_dir}/json/studies.json
        rm ${f}
        sleep 0.001
    done

    gzip ${xml_dir}/json/studies.json

    aws s3 sync  ${xml_dir} ${s3_bucket} --delete
else
    find ${xml_dir} -type f -name "*.json" -delete
    find ${xml_dir} -type f -name "*.log" -delete

    rm -rf ${xml_dir}/json_per_study
    rm -rf ${xml_dir}/json
    mkdir ${xml_dir}/json_per_study
    mkdir ${xml_dir}/json

    find ${xml_dir} -type f -name "*.xml" | while read f
    do
        genJSON ${f} ${xml_dir} &
    done

    sleep 30s

    find ${xml_dir}/json_per_study -type f -name "*.json" | while read f
    do
        cat ${f} >> ${xml_dir}/json/studies.json
        rm ${f}
        sleep 0.001
    done

    gzip ${xml_dir}/json/studies.json
fi

popd