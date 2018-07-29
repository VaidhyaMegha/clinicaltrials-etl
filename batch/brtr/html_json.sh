#!/usr/bin/env bash
set -ex

html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/brtr-adapter/'}
context_dir=${4:-'/usr/local/dataintegration'}
prefix_url="http://www.ensaiosclinicos.gov.br/rg/all/xml/ictrp"
suffix_url=""
download_trial_url=""

 function download_xml_page(){
    wget  -q ${prefix_url} \
         -O ${html_dir}/studies/RBR-ictrp.xml  || true
}

function analyse_trial_xml() { 
  sed  -i "s///g" ${html_dir}/studies/RBR-ictrp.xml
  sed  -i "s///g" ${html_dir}/studies/RBR-ictrp.xml
  xml2json < ${1} > ${2}
 }

pushd ${context_dir}


if [[ ${download} == 'yes' ]]; then

    if [ -d ${html_dir}/studies ]; then
        rm -rf ${html_dir}/studies
    fi

   mkdir -p ${html_dir}/studies
   mkdir ${html_dir}/studies/json

   download_xml_page

   analyse_trial_xml ${html_dir}/studies/RBR-ictrp.xml ${html_dir}/studies/json/studies.json

 #  aws s3 sync  ${html_dir}/studies/ ${s3_bucket} --delete

else
   analyse_trial_xml ${html_dir}/studies/RBR-ictrp.xml ${html_dir}/studies/json

   aws s3 sync  ${html_dir}/studies/ ${s3_bucket} --delete
fi
popd
