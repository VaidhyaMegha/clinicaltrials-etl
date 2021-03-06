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

#pushd ${context_dir}

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
        i=`echo ${f} | sed 's/href="//g; s/"//g;'`
        wget -q ${prefix_url}${suffix_url}${i} -O ${i}

        unzip -o ${i} -d ${xml_dir}/studies/xml/
        h=${i//\.zip/\.xml}

        if [[ -s ${xml_dir}/studies/xml/${h} ]]
        then
            g=${h//\.xml/\.new}
            iconv -f iso-8859-1 -t UTF-8//TRANSLIT ${xml_dir}/studies/xml/${h} -o ${g} || true

            tctr_id_prefix=${i//\.zip/}

            cat ${g} | node ${context_dir}/etl/xml_json.js  | jq -c '.trials.trial[]' >>  study.json

            aws s3 cp ${xml_dir}/studies/xml/${h} ${s3_bucket}studies/xml/
            aws s3 cp study.json ${s3_bucket}studies/json/"p_id=${tctr_id_prefix}"/study.json

            rm -f study.json
            rm -f ${g}
        fi

        rm -f ${i}
        rm -f ${xml_dir}/studies/xml/${h}

    done
fi
#popd
