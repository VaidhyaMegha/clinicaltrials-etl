#!/usr/bin/env bash
set -ex

xml_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/ct-adapter/'}
context_dir=${4:-'/usr/local/dataintegration'}

function genJSON(){
    g=$( basename ${1} )
    g=${g//.xml/}

    sed "s/&quot;/ /g; s/\\\/ /g;" ${1} > ${1}.tmp
    xmlstarlet tr xml_json.xslt ${1}.tmp > ${g}_1.json

    tr '\n' ' ' < ${g}_1.json > ${g}.json
    echo "" >> ${g}.json

    study_type=`cat ${g}.json | jq -c '.study_type | (if . == null then "empty" else (if . == "" then "empty" else . end) end)'`
    phase=`cat ${g}.json | jq -c '.phase | (if . == null then "empty" else (if . == "" then "empty" else . end) end)  '`
    keyword=`cat ${g}.json | jq -c '.keyword | (if . == null then "empty" else (if length == 0 then "empty" else . end) end)'`
    condition=`cat ${g}.json | jq -c '.condition | (if . == null then "empty" else (if length == 0 then "empty" else . end) end)'`

    study_type=${study_type//[\/]/}
    condition=${condition//[\/]/}
    phase=${phase//[\/]/}
    keyword=${keyword//[\/]/}

    path_str=`echo "${xml_dir}/json/${study_type}/${phase}/${keyword}/${condition}"`
    path_str=${path_str//[\"|\[|\]]/}
    path_str=${path_str// /_}
    path_str=${path_str:0:254}

    mkdir -p ${path_str}
    jq -c '.' ${g}.json >> ${path_str}/studies.json

    rm ${1}.tmp
    rm ${g}_1.json
    rm ${g}.json
}

pushd ${context_dir}

if [[ ${download} == 'yes' ]]; then
    wget https://clinicaltrials.gov/AllPublicXML.zip

    unzip -q AllPublicXML.zip -d ${xml_dir}

    rm -f AllPublicXML.zip

    mkdir ${xml_dir}/json

    find ${xml_dir} -type f -name "*.xml" | while read f
    do
        genJSON ${f}
    done

    gzip ${xml_dir}/json/studies.json

    aws s3 sync  ${xml_dir} ${s3_bucket} --delete
else
    find ${xml_dir} -type f -name "*.xml" | while read f
    do
        genJSON ${f}
    done

    gzip ${xml_dir}/json/studies.json
fi

popd