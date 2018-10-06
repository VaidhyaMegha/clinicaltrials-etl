#!/usr/bin/env bash
set -ex
set +H

html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/cristr-adapter/studies'}
context_dir=${4:-'/usr/local/dataintegration'}
max_id=${5:-12373}
start_id=${6:-911}


prefix_url="http://cris.nih.go.kr/cris/en/search/search_result_st01.jsp?seq="
suffix_url=""

function download_trial(){
    g=${1}

    wget  -q ${prefix_url}${g}${suffix_url} \
         -O ${html_dir}/studies/${g}.html  || true
}

function Delete_Invalid_files() {
  grep -lrIZ 'alert (' ${1} | xargs -0 rm -f --
}

function analyse_file() {
    sed "s/&quot;/ /g" ${1} > ${1}.tmp
    tr '\n' ' ' < ${1}.tmp > ${2}
}

function gen_json() {
g=${1//.html/}
cat ${html_dir}/studies/analysis/${g}.html | pup 'tbody json{}' | grep '"text"' | node --max-old-space-size=8192 ./html_json.js | jq -c '.' > ${2}/${g}_1.json
echo '{"SEQ_NUMBER" :'${g}'}' | jq -s add > ${2}/${g}_2.json
jq -c -s '.[0] * .[1]' ${2}/${g}_1.json ${2}/${g}_2.json  >> ${2}/studies.json


}

source ~/.gvm/scripts/gvm
gvm use "go1.4"

pushd ${context_dir}

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

   ls ${html_dir}/studies | grep -oE "[^ ]*\.html" | while read f

   do
        Delete_Invalid_files ${html_dir}/studies/${f}
   done


    ls ${html_dir}/studies | grep -oE "[^ ]*\.html" | while read f

    do
        analyse_file ${html_dir}/studies/${f} ${html_dir}/studies/analysis/${f}
    done


    ls ${html_dir}/studies/analysis | grep -oE "[^ ]*\.html" | while read f
    do

       gen_json  ${f} ${html_dir}/studies/json
    done

aws s3 sync  ${html_dir}/studies ${s3_bucket} --delete
fi
popd

