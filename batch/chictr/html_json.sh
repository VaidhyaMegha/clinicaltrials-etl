#!/usr/bin/env bash
set -ex

html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/chictr-adapter/'}
context_dir=${4:-'/usr/local/dataintegration'}
prefix_url="http://www.chictr.org.cn/"
suffix_url="searchprojen.aspx?page="

 function download_main_index(){
    wget  -q -T 30 ${prefix_url}${suffix_url}"1" \
         -O ${html_dir}/1.html  || true
}

function download_index_page(){
    wget -q -T 30 ${prefix_url}${suffix_url}${1} -O ${html_dir}/${1}.html  || true
}

function download_and_analyse_trial(){
    g=${1//showprojen.aspx?proj=/}

    wget -q -T 30 ${prefix_url}${1} -O ${html_dir}/studies/${g}.html  || true

    sed 's/：/@/g' ${html_dir}/studies/${g}.html > ${html_dir}/studies/${g}_1.html

    cat ${html_dir}/studies/${g}_1.html  | pup 'div.ProjetInfo_ms tr json{}' |  grep 'text' | \
        grep -P '^[[:ascii:]]+@?"?$' | ./html_json.js  | jq -s -c add >> ${2}/studies.json

    rm ${html_dir}/studies/${g}_1.html
}

source ~/.gvm/scripts/gvm
gvm use "go1.9"

pushd ${context_dir}

if [[ ${download} == 'yes' ]]; then

    if [ -d ${html_dir} ]; then
        rm -rf ${html_dir}
    fi

    mkdir -p ${html_dir}/studies
    mkdir ${html_dir}/studies/json
    mkdir ${html_dir}/studies/analysis

    download_main_index

    NUM_OF_PAGES=`cat ${html_dir}/1.html | grep -oE 'onclick=[^L]*Last' | grep -oE '[0-9]*'`

    for (( i=2; i<=${NUM_OF_PAGES}; i++ ))
    do
        download_index_page ${i}
    done

    cat ${html_dir}/*.html | grep -oE "showprojen.aspx\?proj=[0-9]*"  | while read f
    do
        download_and_analyse_trial ${f} ${html_dir}/studies/json
    done

    aws s3 sync  ${html_dir}/ ${s3_bucket} --delete
else
    cat ${html_dir}/*.html | grep -oE "showprojen.aspx\?proj=[0-9]*"  | while read f
    do
        download_and_analyse_trial ${f} ${html_dir}/studies/json
    done
fi

popd
