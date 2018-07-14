#!/usr/bin/env bash
set -x

html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/euctrn-adapter/'}
context_dir=${4:-'/usr/local/dataintegration'}
mode=${5:-'cloud'}

prefix_url="https://www.clinicaltrialsregister.eu/"
suffix_url="ctr-search/search?query=&dateFrom=2003-01-01&dateTo=2018-07-01&page="

 function download_main_index(){
    wget  -q ${prefix_url}${suffix_url}"1" \
         -O ${html_dir}/1.html  || true
}

function download_index_page(){
    wget -q ${prefix_url}${suffix_url}${1} -O ${html_dir}/${1}.html  || true
}

function download_trial(){
    g=${1//ctr-search\/trial\//}
    g=${g//\//_}

    wget -q ${prefix_url}${1} -O ${html_dir}/studies/${g}.html  || true
}

function analyse_trial(){
    g=${1//ctr-search\/trial\//}
    g=${g//\//_}

    tr '[:upper:]' '[:lower:]' < ${html_dir}/studies/${g}.html > ${html_dir}/studies/${g}_1.html

    cat ${html_dir}/studies/${g}_1.html  | pup 'div.detail :parent-of(td.cellGrey)  json{}' | \
      sed 's/ /_/g; s/(//g; s/)//g; s/\\n//g; s/&gt\;//g; s/&lt\;//g; s/&#39\;//g; s/__*/_/g' | \
       jq '.[] | {(.children[0].text): .children[1].text}' | jq -s add >> ${2}/${g}_1.json

    cat ${html_dir}/studies/${g}_1.html  | pup 'div.detail tr.tricell json{}' | \
      sed 's/ /_/g; s/(//g; s/)//g; s/\\n//g; s/&gt\;//g; s/&lt\;//g; s/&#39\;//g; s/__*/_/g' | \
       jq  '.[] | {(.children[1].text): .children[2].text}' | jq -s add >> ${2}/${g}_2.json

    dir_path="${2}/p_y=${g:0:4}/"
    mkdir -p "${dir_path}"

    jq -c -s '.[0] * .[1]' ${2}/${g}_1.json ${2}/${g}_2.json >> ${dir_path}/studies.json

    rm ${html_dir}/studies/${g}_1.html
    rm ${2}/${g}_1.json
    rm ${2}/${g}_2.json
}

source ~/.gvm/scripts/gvm
gvm use "go1.4"

pushd ${context_dir}

if [ -d ${html_dir} ]; then
    rm -rf ${html_dir}
fi

mkdir -p ${html_dir}/studies
mkdir ${html_dir}/studies/json
mkdir ${html_dir}/studies/analysis

if [[ ${download} == 'yes' ]]; then
    download_main_index

    NUM_OF_PAGES=`cat ${html_dir}/1.html | grep -oE '<a href=[^p]*page[^>]*>' | grep -oE '[0-9]*' | sort -u | head -n 1`

    for (( i=2; i<=${NUM_OF_PAGES}; i++ ))
    do
        download_index_page ${i}
    done

    cat ${html_dir}/*.html | grep -oE "ctr-search\/trial\/[0-9\-]*/[A-Z][A-Z]" | while read f
    do
        download_trial ${f}
    done
else
    aws s3 sync  ${s3_bucket} ${html_dir}/studies/  --delete
fi

cat ${html_dir}/*.html | grep -oE "ctr-search\/trial\/[0-9\-]*/[A-Z][A-Z]" | while read f
do
    analyse_trial ${f} ${html_dir}/studies/json
done

if [[ ${mode} == 'cloud' ]]; then
    aws s3 sync  ${html_dir}/studies/ ${s3_bucket} --delete
fi

popd

