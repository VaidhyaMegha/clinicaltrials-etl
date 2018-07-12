#!/usr/bin/env bash
set -x

html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/euctrn-adapter/'}
context_dir=${4:-'/usr/local/dataintegration'}
prefix_url="https://www.clinicaltrialsregister.eu/"
suffix_url="ctr-search/search?query=&dateFrom=2003-01-01&dateTo=2018-07-01&page="

 function download_main_index(){
    wget  -q ${prefix_url}${suffix_url}"1" \
         -O ${html_dir}/1.html  || true
}

function download_index_page(){
    wget -q ${prefix_url}${suffix_url}${1} -O ${html_dir}/${1}.html  || true
}

function download_and_analyse_trial(){
    g=${1//ctr-search\/trial\//}
    g=${g//\//_}

    wget -q ${prefix_url}${1} -O ${html_dir}/studies/${g}.html  || true

    cat ${html_dir}/studies/${g}.html  | pup 'div.detail :parent-of(td.cellGrey)  json{}' | \
      jq '.[] | {(.children[0].text): .children[1].text}' | jq -s add >> ${2}/${g}_1.json

    cat ${html_dir}/studies/${g}.html  | pup 'div.detail tr.tricell json{}' | \
      jq  '.[] | {(.children[1].text): .children[2].text}' | jq -s add >> ${2}/${g}_2.json

    mkdir -p ${2}/${g:0:4}/

    jq -c -s '.[0] * .[1]' ${2}/${g}_1.json ${2}/${g}_2.json >> ${2}/${g:0:4}/studies.json

    rm ${2}/${g}_1.json
    rm ${2}/${g}_2.json
}

source ~/.gvm/scripts/gvm
gvm use "go1.4"

pushd ${context_dir}

if [[ ${download} == 'yes' ]]; then

    if [ -d ${html_dir} ]; then
        rm -rf ${html_dir}
    fi

    mkdir -p ${html_dir}/studies
    mkdir ${html_dir}/studies/json
    mkdir ${html_dir}/studies/analysis

    download_main_index

    NUM_OF_PAGES=`cat ${html_dir}/*.html | grep -oE '<a href=[^p]*page[^>]*>' | grep -oE '[0-9]*' | sort -u | head -n 1`

    for (( i=2; i<=${NUM_OF_PAGES}; i++ ))
    do
        download_index_page ${i}
    done

    cat ${html_dir}/*.html | grep -oE "ctr-search\/trial\/[0-9\-]*/[A-Z][A-Z]" | while read f
    do
        download_and_analyse_trial ${f} ${html_dir}/studies/json &
    done

    aws s3 sync  ${html_dir}/studies/ ${s3_bucket} --delete
else
    cat ${html_dir}/*.html | grep -oE "ctr-search\/trial\/[0-9\-]*/[A-Z][A-Z]" | while read f
    do
        download_and_analyse_trial ${f} ${html_dir}/studies/json &
    done
fi

popd