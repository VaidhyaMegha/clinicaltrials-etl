#!/usr/bin/env bash
set -ex

html_dir=${1}
download=${2:-'no'}
prefix_url="https://www.clinicaltrialsregister.eu/ctr-search/search"
suffix_url="?query=&dateFrom=2003-01-01&dateTo=2018-07-01&page="

 function download_main_index(){
    wget  -q ${prefix_url}${suffix_url}"1" \
         -O ${html_dir}/index.html  || true
}

function download_index_page(){
    wget -q ${prefix_url}${suffix_url}${1} -O ${html_dir}/${1}.html  || true
}

function download_and_analyse_trial(){
    g=${1//ctr_view.cgi?recptno=/}
    wget -q "https://upload.umin.ac.jp/cgi-open-bin/ctr_e/"${1} -O ${html_dir}/studies/${g}.html  || true
}

if [[ ${download} == 'yes' ]]; then

    if [ -d ${html_dir} ]; then
        rm -rf ${html_dir}
    fi

    mkdir -p ${html_dir}/studies
    mkdir ${html_dir}/studies/json
    mkdir ${html_dir}/studies/analysis

    download_main_index

    cat ${html_dir}/*.html | grep "EudraCT Number:</span>" | grep -oE "[0-9\-]*" | while read f
    do
            g=${f//\"/}
            download_index_page ${g}
    done

    cat ${html_dir}/*.html | grep -oE "ctr_view.cgi\?recptno=[^\"]*" | while read f
    do

        download_and_analyse_trial ${f} ${html_dir}/studies/json
    done
else
    cat ${html_dir}/*.html | grep -oE "ctr_view.cgi\?recptno=[^\"]*" | while read f
    do

        download_and_analyse_trial ${f} ${html_dir}/studies/json
    done
fi
