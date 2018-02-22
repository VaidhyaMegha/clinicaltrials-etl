#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset as argument
# ./ctri.nic.in/trials.sh datainsights-in/ctri.nic.in/ datainsights-results/ctri.nic.in/html


source $(pwd)/env.sh
source $(pwd)/utility.sh

OUT_DIR=${2:-'temp/ctri.nic.in'}

#cleanup  ${DATA_HOME}/${OUT_DIR}


prefix_url="http://ctri.nic.in/Clinicaltrials/pmaindet2.php?"
suffix_url=""

function download_trial(){
    f=${1}
    f=${f//&/}
    g=${f//trialid=/}

    if [ ! -f ${DATA_HOME}/${OUT_DIR}/${g}.html ]; then
        wget -q ${prefix_url}${f}${suffix_url} \
             -O ${DATA_HOME}/${OUT_DIR}/${g}.html -o ${LOG_HOME}/${f}.html.log || true
        sleep 1s
    fi
}

## now loop through the above array
find ${DATA_HOME}/${1} | grep html | xargs -I {} cat {} | grep -oE "trialid=[^&]*&" | while read f
do
    download_trial ${f}
done
