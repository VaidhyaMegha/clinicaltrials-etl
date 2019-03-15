#!/usr/bin/env bash
set -ex


html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/ntr-adapter/studies'}
context_dir=${4:-'/usr/local/dataintegration'}
max_id=${5:-8000}
start_id=${6:-22}
prefix_url="https://api.trialregister.nl/trials/public.trials/"
suffix_url=""

function download_trial(){
    g=${1}

    wget -q --no-check-certificate ${prefix_url}${g}${suffix_url} \
         -O ${html_dir}/studies/analysis/${g}.json  || true
}

source ~/.gvm/scripts/gvm
gvm use "go1.9"

#pushd ${context_dir}

if [[ ${download} == 'yes' ]]; then

    if [ -d ${html_dir}/studies ]; then
        rm -rf ${html_dir}/studies
    fi
    if [ -d ${html_dir}/studies/json ]; then
        rm -rf ${html_dir}/studies/json
    fi
    if [ -d ${html_dir}/studies/analysis ]; then
        rm -rf ${html_dir}/studies/analysis
    fi


    mkdir ${html_dir}/studies
    mkdir ${html_dir}/studies/json
    mkdir ${html_dir}/studies/analysis

    for ((f=${start_id};f<=${max_id};f+=1))
    do
        download_trial ${f}
    done

   find ${html_dir}/studies/analysis -type f -maxdepth 1 -name "*.json" ! -size 0 | while read f
   do
   cat $f >> ${html_dir}/studies/json/studies.json
   done

   aws s3 sync  ${html_dir}/studies ${s3_bucket} --delete
fi
#popd

