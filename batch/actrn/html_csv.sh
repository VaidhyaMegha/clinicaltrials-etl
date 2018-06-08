#!/usr/bin/env bash
set -ex
set +H


html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/actrn-adapter/'}
context_dir=${4:-'/usr/local/dataintegration'}
max_id=${5:-100}

prefix_url="https://www.anzctr.org.au/Trial/Registration/TrialReview.aspx?id="
suffix_url=""

function download_trial(){
    g=${1}

    wget -q ${prefix_url}${g}${suffix_url} \
         -O ${html_dir}/studies/${g}.html -o ${html_dir}/logs/${g}.log || true
    sleep 0.001s
}

function analyse_file() {
 echo ${1} ${2} ${3}
}


pushd ${context_dir}

if [[ ${download} == 'yes' ]]; then
    mkdir ${html_dir}/studies
    mkdir ${html_dir}/logs
    mkdir ${html_dir}/csv

    for ((f=1;f<=${max_id};f+=1))
    do
        download_trial ${f}
    done


    ls ${html_dir}/studies | grep -oE "[^ ]*\.html" | while read f
    do
        analyse_file ${html_dir}/studies/${f} ${html_dir}/csv/studies.csv  ${html_dir}/${f} &
    done

    aws s3 sync  ${html_dir} ${s3_bucket} --delete
else
    rm -rf ${html_dir}/studies
    rm -rf ${html_dir}/logs
    rm -rf ${html_dir}/csv

    mkdir ${html_dir}/studies
    mkdir ${html_dir}/logs
    mkdir ${html_dir}/csv

    for ((f=1;f<=${max_id};f+=1))
    do
        download_trial ${f}
    done

    ls ${html_dir}/studies | grep -oE "[^ ]*\.html" | while read f
    do
        analyse_file ${html_dir}/studies/${f} ${html_dir}/csv/studies.csv  ${html_dir}/${f} &
    done

fi

popd

