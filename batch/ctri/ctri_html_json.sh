#!/usr/bin/env bash
set -ex
set +H

html_dir=${1}
download=${2:-'no'}

rm -rf ${html_dir}/studies
rm -rf ${html_dir}/json
rm -rf ${html_dir}/analysis
s3_bucket=${3:-'s3://hsdlc-results/ctri-adapter/'}
context_dir=${4:-'/usr/local/dataintegration'}
max_id=${5:-10}

prefix_url="http://ctri.nic.in/Clinicaltrials/pmaindet2.php?trialid="
suffix_url=""

function download_trial(){
    g=${1}

    wget --no-check-certificate -q ${prefix_url}${g}${suffix_url} \
         -O ${html_dir}/studies/${g}.html  || true
    sleep 0.001s
}

function Delete_Invalid_files() {
  grep -lrIZ 'Invalid Request' ${html_dir}/studies/ | xargs -0 rm -f --
}

function analyse_file() {
    sed "s/&quot;/ /g" ${1} > ${1}.tmp
    tr '\n' ' ' < ${1}.tmp > ${2}
}

function gen_json() {
   sh ./html_json.sh ${1} >> ${html_dir}/json/html_json.json

}

pushd ${context_dir}
if [[ ${download} == 'yes' ]]; then
    mkdir ${html_dir}/studies
    mkdir ${html_dir}/json
    mkdir ${html_dir}/analysis

    for ((f=2;f<=${max_id};f+=1))
    do
        download_trial ${f}
    done


        Delete_Invalid_files ${html_dir}/studies/


    ls ${html_dir}/studies | grep -oE "[^ ]*\.html" | while read f

    do
        analyse_file ${html_dir}/studies/${f} ${html_dir}/analysis/${f}
    done

    ls ${html_dir}/analysis | grep -oE "[^ ]*\.html" | while read f
    do
       gen_json  ${html_dir}/analysis/${f} ${html_dir}/json/
    done


fi
popd

