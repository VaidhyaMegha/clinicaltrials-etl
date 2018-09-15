#!/usr/bin/env bash
set -x

html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/isrctn-adapter/'}
context_dir=${4:-'/usr/local/dataintegration'}
mode=${5:-'cloud'}

prefix_url="http://www.isrctn.com/"
suffix_url="search?pageSize=100&sort=&q=&filters=&searchType=basic-search&page="

 function download_main_index(){
    wget  -q ${prefix_url}${suffix_url}"1" \
         -O ${html_dir}/1.html  || true
}

function download_index_page(){
    wget -q ${prefix_url}${suffix_url}${1} -O ${html_dir}/${1}.html  || true
}

function download_trial(){
    g=${1//\?q=/}

    wget -q ${prefix_url}${1} -O ${html_dir}/studies/${g}.html  || true
}

function analyse_trial(){
    g=${1//.html/}
    cat ${html_dir}/studies/${g}.html  | pup 'div.Info_aside :parent-of(dt.Meta_name)  json{}' |  grep '"text":' | ./html_json.js |jq -s add > ${2}/${g}_1.json

cat ${html_dir}/studies/${g}.html | pup ':contains("'${g}'") json{}' | jq -c '{"IRCTN_NUMBER" :.[1].text}' | jq -s add > ${2}/${g}_2.json

    cat ${html_dir}/studies/${g}.html | pup 'div.Info_main :parent-of(.Info_section_title) json{}' | grep '"text":' | ./html_json.js | jq -s add > ${2}/${g}_3.json

    dir_path="${2}/p_y=${g:0:4}/"
    mkdir -p "${dir_path}"

     jq -c -s '.[0] * .[1]' ${2}/${g}_1.json ${2}/${g}_2.json  > ${2}/studies1.json
     jq -c -s '.[0] * .[1]' ${2}/studies1.json ${2}/${g}_3.json >> ${2}/studies.json
#
#    tr '[:upper:]' '[:lower:]' < ${2}/${g}_3.json > ${2}/${g}.json
#    sed -i 's/ /_/g; s/(//g; s/)//g; s/\\n//g; s/&gt\;//g; s/&lt\;//g; s/&#39\;//g; s/__*/_/g' ${2}/${g}.json
#
#    cat ${2}/${g}.json >> ${dir_patFunderNameh}/studies.json
#
    rm ${2}/${g}_1.json
    rm ${2}/${g}_2.json
    rm ${2}/${g}_3.json
    rm ${2}/studies1.json
}

source ~/.gvm/scripts/gvm
gvm use "go1.4"

pushd ${context_dir}

#if [ -d ${html_dir}/studies ]; then
#    rm -rf ${html_dir}/studies
#fi
#
mkdir -p ${html_dir}/studies

#if [[ ${download} == 'yes' ]]; then
    download_main_index
#
#    NUM_OF_PAGES=`cat ${html_dir}/1.html | grep -oE 'of [0-9]*</span>' | grep -oE '[0-9]*' | sort -u | head -n 1`
#
#    for (( i=2; i<=${NUM_OF_PAGES}; i++ ))
#    do
#        download_index_page ${i}
#    done

#    cat ${html_dir}/*.html | grep -oE "ISRCTN[0-9]*\?q=" | while read f
#    do
#        download_trial ${f}
#    done
#else
#    aws s3 sync  ${s3_bucket} ${html_dir}/studies/  --delete
#fi
#
#if [ -d ${html_dir}/studies/json ]; then
#    rm -rf ${html_dir}/studies/json
#fi

mkdir ${html_dir}/studies/json

find ${html_dir}/studies -type f -name "*.html" -printf "%f\n" | while read f
do
    analyse_trial ${f} ${html_dir}/studies/json
done

if [[ ${mode} == 'cloud' ]]; then
    aws s3 sync  ${html_dir}/studies/ ${s3_bucket} --delete
fi

popd

