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

    nct_id=`cat ${g}.json | jq -c '.id_info.nct_id | (if . == null then "empty" else (if . == "" then "empty" else . end) end)'`
    nct_id=${nct_id//[\"]/}
    nct_id=${nct_id:0:7}

    path_str=`echo "${xml_dir}/json/p_id=${nct_id}/"`

    mkdir -p ${path_str}
    jq -c '.' ${g}.json >> ${path_str}/studies.json

    rm ${1}.tmp
    rm ${g}_1.json
    rm ${g}.json
}

#pushd ${context_dir}

if [[ ${download} == 'yes' ]]; then
    wget https://clinicaltrials.gov/AllPublicXML.zip

    unzip -q AllPublicXML.zip -d ${xml_dir}

    rm -f AllPublicXML.zip

    mkdir ${xml_dir}/json

    find ${xml_dir} -type f -name "*.xml" | while read f
    do
        genJSON ${f}
    done

    aws s3 sync  ${xml_dir} ${s3_bucket} --delete
else
    find ${xml_dir} -type f -name "*.xml" | while read f
    do
        genJSON ${f}
    done

fi

#popd
