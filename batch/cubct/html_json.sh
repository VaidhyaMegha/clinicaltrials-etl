#!/usr/bin/env bash
set -ex

html_dir=${1}
download=${2:-'no'}
maxIndex=${3:-'00000288'}
s3_bucket=${4:-'s3://hsdlc-results/cubct-adapter/'}
context_dir=${5:-'/usr/local/dataintegration'}
prefix_url="http://registroclinico.sld.cu/en/trials/RPCEC"
suffix_url="-En"



 function download_all_htmls(){
    for num in {00000001..00000288}
    do
    wget -q ${prefix_url}$num${suffix_url} \
         -O ${html_dir}/$num.html  || true
    done
}

function download_and_analyse_trial(){

    cat ${html_dir}/${1}  | pup 'fieldset json{}' |  grep '"text":' | ./html_json.js  | jq -s -c add >> ${2}/studies.json

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

    mkdir -p ${html_dir}/studies
    mkdir ${html_dir}/studies/json
    mkdir ${html_dir}/studies/analysis


    download_all_htmls

     ls ${html_dir} |  grep -oE "[^ ]*\.html" | while read f
    do

    download_and_analyse_trial ${f} ${html_dir}/studies/json
    done

    aws s3 sync  ${html_dir}/ ${s3_bucket} --delete
fi

#popd
