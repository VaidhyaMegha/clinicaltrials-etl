#!/usr/bin/env bash
set -ex
set +H

html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/drk-adapter/studies'}
context_dir=${4:-'/usr/local/dataintegration'}
max_id=${5:-12373}
start_id=${6:-911}


prefix_url="https://www.drks.de/drks_web/navigate.do?navigationId=trial.HTML&TRIAL_ID=DRKS"
suffix_url=""

 function download_all_htmls(){
    for num in {00010788..00016000}
    do
    wget -q ${prefix_url}$num${suffix_url} \
         -O ${html_dir}/$num.html  || true
    done
}

function download_trial(){
    g=${1}

    wget  -q ${prefix_url}${g}${suffix_url} \
         -O ${html_dir}/studies/${g}.html  || true
}

function Delete_Invalid_files() {
  grep -lrIZ 'could not have been found' ${1} | xargs -0 rm -f --
}

#function analyse_file() {
#    sed "s/&quot;/ /g" ${1} > ${1}.tmp
#    tr '\n' ' ' < ${1}.tmp > ${2}
#}

function gen_json() {
g=${1//.html/}
cat ${html_dir}/${g}.html | pup 'div div div div  json{}' | grep  '"text":' | grep -v 'start of 1:' | grep -v 'end of 1:' | node --max-old-space-size=8192 ./html_json.js | jq -c '.' >> ${2}/studies.json
}

#source ~/.gvm/scripts/gvm
#gvm use "go1.4"

pushd ${context_dir}

if [[ ${download} == 'yes' ]]; then

#    if [ -d ${html_dir}/studies ]; then
#        rm -rf ${html_dir}/studies
#    fi
#    if [ -d ${html_dir}/studies/json ]; then
#        rm -rf ${html_dir}/studies/json
#    fi
#    if [ -d ${html_dir}/studies/analysis ]; then
#        rm -rf ${html_dir}/studies/analysis
#    fi
#
#
#    mkdir ${html_dir}/studies
#    mkdir ${html_dir}/studies/json
#    mkdir ${html_dir}/studies/analysis



#    download_all_htmls



#    ls ${html_dir} | grep -oE "[^ ]*\.html" | while read f
#    do
#        Delete_Invalid_files ${html_dir}/${f}
#    done


#    ls ${html_dir}/studies | grep -oE "[^ ]*\.html" | while read f
#
#    do
#        analyse_file ${html_dir}/studies/${f} ${html_dir}/studies/analysis/${f}
#    done
#
#
    ls ${html_dir} | grep -oE "[^ ]*\.html" | while read f
    do
       gen_json  ${f} ${html_dir}/studies/json
    done
#
aws s3 sync  ${html_dir}/studies ${s3_bucket} --delete
fi
popd

