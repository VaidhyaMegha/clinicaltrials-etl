#!/usr/bin/env bash
set -ex

xml_dir=${1}
download=${2:-'no'}
year=${4:-`date +'%Y'`}
month=${4:-`date +'%m'`}
day=${4:-`date +'%d'`}
s3_bucket=${5:-'s3://hsdlc-results/tctr-adapter/'}
context_dir=${6:-'/usr/local/dataintegration'}
prefix_url="www.clinicaltrials.in.th/export/xmlv02/"
suffix_url=""

function download_xml_page(){
    wget  -q ${prefix_url}${suffix_url} -O index.html || true
}

pushd ${context_dir}

if [[ ${download} == 'yes' ]]; then

  if [ -d ${xml_dir}/studies ]; then
    rm -rf ${xml_dir}/studies
  fi
   mkdir -p ${xml_dir}/studies
   mkdir ${xml_dir}/studies/json
   mkdir ${xml_dir}/studies/xml

    download_xml_page

    cat index.html | grep -oE 'href="[^\.]*\.zip"' | while read f
    do
        g=`echo ${f} | sed 's/href="//g; s/"//g;'`
        wget -q ${prefix_url}${suffix_url}${g} -O ${xml_dir}/${g}
    done

    find ${xml_dir} -type f -maxdepth 1 -name "*.zip" | while read f
    do
    unzip -o ${f} -d ${xml_dir}/studies/xml/
    done


    find ${xml_dir}/studies/xml -type f -maxdepth 1 -name "*.xml" | while read f
    do
    cat ${f} | node ${xml_dir}/etl/xml_json.js  | jq -c '.trials.trial[]' >>  ${xml_dir}/studies/json/studies.json
    done

    aws s3 sync  ${xml_dir} ${s3_bucket} --delete
fi
popd
