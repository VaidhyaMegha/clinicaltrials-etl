#!/usr/bin/env bash
set -ex

xml_dir=${1}
download=${2:-'no'}
start_year=${3:-'1995'}
end_year=${4:-`date +'%Y'`}
s3_bucket=${5:-'s3://hsdlc-results/perct-adapter/'}
context_dir=${6:-'/usr/local/dataintegration'}
prefix_url="http://www.ins.gob.pe/ensayosclinicos/rpec/XML/"
suffix_url="xmlall"

function download_xml_page(){
    wget  -q ${prefix_url}${suffix_url}${1}.xml \
         -O ${xml_dir}/${1}.xml  || true
}

function genJSON(){

xml2json < ${1} >> ${2}
}


function analyseJSON(){

jq  -c '.trials.trial[]' ${1} > ${2}
#rm -rf ${1}
sed -i 's/"contacts":{"contact":{/"contacts":{"contact":\[{/g' ${2}
sed -i 's/}}\,"countries"/}\]},"countries"/g' ${2}
sed -i 's/"contacts":""/"contacts":{}/g' ${2} # contacts has got ""
sed -i 's/"health_condition_keyword":{"hc_keyword":/"health_condition_keyword":{"hc_keyword":\[/g' ${2}
sed -i 's/"health_condition_keyword":{"hc_keyword":\[\[/"health_condition_keyword":{"hc_keyword":\[/g' ${2}
sed -i 's/},"intervention_code"/\]},"intervention_code"/g' ${2}
sed -i 's/\]\]},"intervention_code"/\]},"intervention_code"/g' ${2}

sed -i 's/"intervention_keyword":{"i_keyword":/"intervention_keyword":{"i_keyword":\[/g' ${2}
sed -i 's/"intervention_keyword":{"i_keyword":\[\[/"intervention_keyword":{"i_keyword":\[/g' ${2}
sed -i 's/},"primary_outcome"/\]},"primary_outcome"/g' ${2}
sed -i 's/\]\]},"primary_outcome"/\]},"primary_outcome"/g' ${2}


sed -i 's/"countries":{"country2":/"countries":{"country2":\[/g' ${2}
sed -i 's/"countries":{"country2":\[\[/"countries":{"country2":\[/g' ${2}
sed -i 's/},"criteria"/\]},"criteria"/g' ${2}
sed -i 's/\]\]},"criteria"/\]},"criteria"/g' ${2}


sed -i 's/"health_condition_code":{"hc_code":/"health_condition_code":{"hc_code":\[/g' ${2}
sed -i 's/"health_condition_code":{"hc_code":\[\[/"health_condition_code":{"hc_code":\[/g' ${2}
sed -i 's/},"health_condition_keyword"/\]},"health_condition_keyword"/g' ${2}
sed -i 's/\]\]},"health_condition_keyword"/\]},"health_condition_keyword"/g' ${2}


sed -i 's/"secondary_outcome":{"sec_outcome":/"secondary_outcome":{"sec_outcome":\[/g' ${2}
sed -i 's/"secondary_outcome":{"sec_outcome":\[\[/"secondary_outcome":{"sec_outcome":\[/g' ${2}
sed -i 's/},"secondary_sponsor"/\]},"secondary_sponsor"/g' ${2}
sed -i 's/\]\]},"secondary_sponsor"/\]},"secondary_sponsor"/g' ${2}


#sed -i 's/},"secondary_sponsor"/\]},"secondary_sponsor"/g' ${2}
sed -i 's/"secondary_outcome":{\]/"secondary_outcome":{"sec_outcome":\[{}\]/g' ${2}
sed -i 's/"secondary_sponsor":{"sponsor_name":/"secondary_sponsor":{"sponsor_name":\[/g' ${2}
sed -i 's/"secondary_sponsor":{"sponsor_name":\[\[/"secondary_sponsor":{"sponsor_name":\[/g' ${2}
sed -i 's/},"secondary_ids"/\]},"secondary_ids"/g' ${2}
sed -i 's/\]\]},"secondary_ids"/\]},"secondary_ids"/g' ${2}
sed -i 's/"secondary_ids":{"secondary_id":/"secondary_ids":{"secondary_id":\[/g' ${2}
sed -i 's/"secondary_ids":{"secondary_id":\[\[/"secondary_ids":{"secondary_id":\[/g' ${2}
sed -i 's/},"source_support"/\]},"source_support"/g' ${2}
sed -i 's/\]\]},"source_support"/\]},"source_support"/g' ${2}
sed -i 's/"source_support":{"source_name":/"source_support":{"source_name":\[/g' ${2}
sed -i 's/"source_support":{"source_name":\[\[/"source_support":{"source_name":\[/g' ${2}
sed -i 's/}}$/@/g' ${2}
sed -i 's/\]}$/\]}}/g' ${2}
sed -i 's/\]@$/\]}}/g' ${2}
sed -i 's/@$/\]}}/g' ${2}
}

pushd ${context_dir}

if [[ ${download} == 'yes' ]]; then

  if [ -d ${xml_dir}/studies ]; then
    rm -rf ${xml_dir}/studies
  fi

   mkdir -p ${xml_dir}/studies
   mkdir ${xml_dir}/studies/json
   mkdir ${xml_dir}/studies/analysis

    for (( i=${start_year}; i<=${end_year}; i++ ))
    do
        download_xml_page ${i}
    done

    find ${xml_dir} -type f -name "*.xml" | while read f
    do
        genJSON ${f}  ${xml_dir}/studies/json/studies.tmp.json
    done

    analyseJSON ${xml_dir}/studies/json/studies.tmp.json ${xml_dir}/studies/json/studies.json

    aws s3 sync  ${xml_dir} ${s3_bucket} --delete


else

    find ${xml_dir} -type f -name "*.xml" | while read f
    do
        genJSON ${f}  ${xml_dir}/studies/json/studies.tmp.json
    done

    analyseJSON ${xml_dir}/studies/json/studies.tmp.json ${xml_dir}/studies/json/studies.json

#    aws s3 sync  ${xml_dir} ${s3_bucket} --delete
fi



popd