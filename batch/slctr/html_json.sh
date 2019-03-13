#!/usr/bin/env bash
set -ex


html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/slctr-adapter/studies'}
context_dir=${4:-'/usr/local/dataintegration'}
max_id=${5:-28}
start_id=${6:-911}
#prefix_url="http://www.slctr.lk/trials"
prefix_url="https://slctr.lk/trials"
suffix_url="?page="

function download_main_index(){
    wget  -q ${prefix_url} \
         -O ${html_dir}/1.html  || true
}

function download_index_page(){
    wget -q ${prefix_url}${suffix_url}${1} -O ${html_dir}/${1}.html  || true
}

function download_trial(){
    g=${1}

    wget  -q ${prefix_url}/${g} \
         -O ${html_dir}/studies/analysis/${g} || true
}

function analyse_file() {
   cat ${1} | pup 'div json{}' | grep '"text":' | ./html_json.js | jq -c '.' >> ${2}/studies.json
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

    download_main_index

    NUM_OF_PAGES=`cat ${html_dir}/1.html | grep -oE '/trials\?page=[0-9]*' | grep -oE '[0-9]*'| sort -g | tail -n 1`

    for (( i=2; i<=${NUM_OF_PAGES}; i++ ))
    do
        download_index_page ${i}
    done


  # cat ${html_dir}/*.html | grep -oE '/trials/[0-9]*' | grep -oE "[0-9]*" | while read f
    cat ${html_dir}/*.html | grep -oE "/trials/slctr-[0-9]*-[0-9]*" | grep -oE "slctr-[0-9]*-[0-9]*"
    do
        download_trial ${f} ${html_dir}/studies/analysis/${f}
    done


    ls ${html_dir}/studies/analysis | grep -oE "[^ ]*" | while read f

    do
        analyse_file ${html_dir}/studies/analysis/${f} ${html_dir}/studies/json/
    done
    aws s3 sync  ${html_dir}/studies ${s3_bucket} --delete

fi
#popd

