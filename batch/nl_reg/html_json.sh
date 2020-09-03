#!/usr/bin/env bash
set -ex


html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/ntr-adapter/studies'}
context_dir=${4:-'/usr/local/dataintegration'}
max_id=${5:-9000}
start_id=${6:-1}
prefix_url="https://api.trialregister.nl/trials/public.trials/"
suffix_url=""

function download_trial(){
    g=${1}

    wget -q --no-check-certificate ${prefix_url}${g}${suffix_url} \
         -O ${html_dir}/studies/analysis/${g}.json  || true
}

function analyse_trial() {

    sed -i 's/\<_[a-zA-Z0-9]*\>//g' ${1}
    sed -i 's/{"":"[a-zA-Z]*","":"[a-zA-Z]*.[a-zA-Z]*","":"[0-9]*","":[0-9]*,"found":[a-zA-Z]*,""://g' ${1}
    sed -i 's/}}/}/g' ${1}
    cat ${1} >> ${2}/studies.json
    echo "" >> ${2}/studies.json
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
   analyse_trial ${f} ${html_dir}/studies/json
    done

   aws s3 sync  ${html_dir}/studies ${s3_bucket} --delete
fi
#popd

