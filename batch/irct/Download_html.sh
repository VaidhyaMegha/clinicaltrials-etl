#!/usr/bin/env bash
set -ex
set +H


html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/actrn-adapter/'}
context_dir=${4:-'/usr/local/dataintegration'}
min_id=${5:-1}
max_id=${6:-375400}
#375400
prefix_url="https://www.anzctr.org.au/Trial/Registration/TrialReview.aspx?id="
suffix_url=""

function download_trial(){
    g=${1}

    wget  -q ${prefix_url}${g}${suffix_url} \
         -O ${html_dir}/actrn/studies/${g}.html  || true
    sleep 0.001s
}

pushd ${context_dir}

if [[ ${download} == 'yes' ]]; then

    if [ -d ${html_dir}/actrn ]; then
        rm -rf ${html_dir}/actrn
    fi

    mkdir ${html_dir}/actrn
    mkdir ${html_dir}/actrn/studies

    for ((f=min_id;f<=${max_id};f+=1))
    do
        download_trial ${f}
    done

     aws s3 sync  ${html_dir}/actrn/ ${s3_bucket}
fi

popd