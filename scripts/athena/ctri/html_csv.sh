#!/usr/bin/env bash
set -ex
set +H


html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://datainsights-results/ctri-adapter/'}
context_dir=${4:-'/usr/local/dataintegration'}

prefix_url="http://ctri.nic.in/Clinicaltrials/pmaindet2.php?"
suffix_url=""

function download_trial(){
    f=${1}
    f=${f//&/}
    g=${f//trialid=/}

    wget -q ${prefix_url}${f}${suffix_url} \
         -O ${html_dir}/studies/${g}.html -o ${html_dir}/logs/${g}.log || true
    sleep 1s
}

function analyse_file() {
    content=`python parse.py  ${1} ${3}`

    content=$( echo ${content} | sed -e 's/<[^>]*>//g; s/Close\n//g; s/&[^\;]*\;//g' |
     sed 's/Modification(s)//g; s/\[Registered on: /~/; s/\\n//g; s/\\r//g; s/\\t//g; s/\]//g; s/"//g; s/ ~/~/g; s/~ /~/g' | tr -s " "   )

    echo ${content} >> ${2}
}


pushd ${context_dir}

if [[ ${download} == 'yes' ]]; then
    mkdir ${html_dir}/studies
    mkdir ${html_dir}/logs
    mkdir ${html_dir}/csv

    find ${html_dir} -maxdepth 1 | grep ".html$" | xargs -I {} cat {} | grep -oE "trialid=[^&]*&" | while read f
    do
        download_trial ${f}
    done

    entry=`python keys.py`
    echo ${entry} >> ${html_dir}/csv/studies.csv

    ls ${html_dir}/studies | grep -oE "[^ ]*\.html" | while read f
    do
        analyse_file ${html_dir}/studies/${f} ${html_dir}/csv/studies.csv  ${html_dir}/${f} &
    done

    aws s3 sync  ${html_dir} ${s3_bucket}
else
    rm -rf ${html_dir}/studies
    rm -rf ${html_dir}/logs
    rm -rf ${html_dir}/csv

    mkdir ${html_dir}/studies
    mkdir ${html_dir}/logs
    mkdir ${html_dir}/csv

    find ${html_dir} -maxdepth 1 | grep ".html$" | xargs -I {} cat {} | grep -oE "trialid=[^&]*&" | while read f
    do
        download_trial ${f}
    done

    entry=`python keys.py`
    echo ${entry} >> ${html_dir}/csv/studies.csv

    ls ${html_dir}/studies | grep -oE "[^ ]*\.html" | while read f
    do
        analyse_file ${html_dir}/studies/${f} ${html_dir}/csv/studies.csv  ${html_dir}/${f} &
    done

fi

popd

