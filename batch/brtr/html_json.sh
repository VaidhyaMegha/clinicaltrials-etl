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
  xml2json < ${1} > ${2}

jq  -c '.trials.trial[]' ${2} > ${3}

sed -i 's/"contacts":{"contact":{/"contacts":{"contact":\[{/g' ${3}
sed -i 's/}}\,"countries"/}\]},"countries"/g' ${3}
sed -i 's/"contacts":""/"contacts":{}/g' ${3} # contacts has got ""
sed -i 's/"health_condition_keyword":{"hc_keyword":/"health_condition_keyword":{"hc_keyword":\[/g' ${3}
sed -i 's/"health_condition_keyword":{"hc_keyword":\[\[/"health_condition_keyword":{"hc_keyword":\[/g' ${3}
sed -i 's/},"intervention_code"/\]},"intervention_code"/g' ${3}
sed -i 's/\]\]},"intervention_code"/\]},"intervention_code"/g' ${3}

sed -i 's/"intervention_keyword":{"i_keyword":/"intervention_keyword":{"i_keyword":\[/g' ${3}
sed -i 's/"intervention_keyword":{"i_keyword":\[\[/"intervention_keyword":{"i_keyword":\[/g' ${3}
sed -i 's/},"primary_outcome"/\]},"primary_outcome"/g' ${3}
sed -i 's/\]\]},"primary_outcome"/\]},"primary_outcome"/g' ${3}


sed -i 's/"countries":{"country2":/"countries":{"country2":\[/g' ${3}
sed -i 's/"countries":{"country2":\[\[/"countries":{"country2":\[/g' ${3}
sed -i 's/},"criteria"/\]},"criteria"/g' ${3}
sed -i 's/\]\]},"criteria"/\]},"criteria"/g' ${3}
sed -i 's/"health_condition_code":{"hc_code":/"health_condition_code":{"hc_code":\[/g' ${3}
sed -i 's/"health_condition_code":{"hc_code":\[\[/"health_condition_code":{"hc_code":\[/g' ${3}
sed -i 's/},"health_condition_keyword"/\]},"health_condition_keyword"/g' ${3}
sed -i 's/\]\]},"health_condition_keyword"/\]},"health_condition_keyword"/g' ${3}
sed -i 's/"secondary_outcome":{"sec_outcome":/"secondary_outcome":{"sec_outcome":\[/g' ${3}
sed -i 's/"secondary_outcome":{"sec_outcome":\[\[/"secondary_outcome":{"sec_outcome":\[/g' ${3}
sed -i 's/},"secondary_sponsor"/\]},"secondary_sponsor"/g' ${3}
sed -i 's/\]\]},"secondary_sponsor"/\]},"secondary_sponsor"/g' ${3}
sed -i 's/"secondary_sponsor":{"sponsor_name":/"secondary_sponsor":{"sponsor_name":\[/g' ${3}
sed -i 's/"secondary_sponsor":{"sponsor_name":\[\[/"secondary_sponsor":{"sponsor_name":\[/g' ${3}
sed -i 's/},"secondary_ids"/\]},"secondary_ids"/g' ${3}
sed -i 's/\]\]},"secondary_ids"/\]},"secondary_ids"/g' ${3}
sed -i 's/"secondary_ids":{"secondary_id":/"secondary_ids":{"secondary_id":\[/g' ${3}
sed -i 's/"secondary_ids":{"secondary_id":\[\[/"secondary_ids":{"secondary_id":\[/g' ${3}
sed -i 's/},"source_support"/\]},"source_support"/g' ${3}
sed -i 's/\]\]},"source_support"/\]},"source_support"/g' ${3}
sed -i 's/"source_support":{"source_name":/"source_support":{"source_name":\[/g' ${3}
sed -i 's/"source_support":{"source_name":\[\[/"source_support":{"source_name":\[/g' ${3}
sed -i 's/}}$/@/g' ${3}
sed -i 's/\]}$/\]}}/g' ${3}
sed -i 's/\]@$/\]}}/g' ${3}
sed -i 's/@$/\]}}/g' ${3}
}

pushd ${context_dir}

nvm use default
nvm version
node --version
npm --version

if [[ ${download} == 'yes' ]]; then

    if [ -d ${html_dir}/studies ]; then
        rm -rf ${html_dir}/studies
    fi

   mkdir -p ${html_dir}/studies
   mkdir ${html_dir}/studies/json

   download_xml_page

   analyse_trial_xml ${html_dir}/studies/RBR-ictrp.xml ${html_dir}/studies/json/studies.tmp.json ${html_dir}/studies/json/studies.json

   rm -rf ${html_dir}/studies/json/studies.tmp.json

   aws s3 sync  ${html_dir}/studies/ ${s3_bucket} --delete
   
else
   analyse_trial_xml ${html_dir}/studies/RBR-ictrp.xml ${html_dir}/studies/json
   
fi
popd
