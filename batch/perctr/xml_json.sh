#!/usr/bin/env bash
set -ex

xml_dir=${1}
download=${2:-'no'}
start_year=${3:-'1995'}
end_year=${4:-`date +'%Y'`}
s3_bucket=${5:-'s3://hsdlc-results/perct-adapter/'}
context_dir=${6:-'/usr/local/dataintegration'}
    prefix_url="https://www.ins.gob.pe/ensayosclinicos/rpec/XML/"
suffix_url="xmlall"

function download_xml_page(){
    wget   -q --no-check-certificate ${prefix_url}${suffix_url}${1}.xml \
         -O ${xml_dir}/studies/xml/${1}.xml  || true
}

pushd ${context_dir}

if [[ ${download} == 'yes' ]]; then

  if [ -d ${xml_dir}/studies ]; then
    rm -rf ${xml_dir}/studies
  fi

   mkdir -p ${xml_dir}/studies
   mkdir ${xml_dir}/studies/json
   mkdir ${xml_dir}/studies/xml

    for (( i=${start_year}; i<=${end_year}; i++ ))
    do
        download_xml_page ${i}
    done

    find ${xml_dir}/studies/xml -type f -maxdepth 1 -name "*.xml" ! -size 0 | while read f
    do
     cat ${f} | node ${xml_dir}/etl/xml_json.js  | jq -c '.trials.trial[]' >>  ${xml_dir}/studies/json/studies.json
    done

    aws s3 sync  ${xml_dir} ${s3_bucket} --delete


else

    find ${xml_dir} -type f -name "*.xml" ! -size 0 | while read f
    do
     cat ${f} | node ${xml_dir}/etl/xml_json.js  | jq -c '.trials.trial[]' >>  ${xml_dir}/studies/json/studies.json
    done

    aws s3 sync  ${xml_dir} ${s3_bucket} --delete
fi



popd
