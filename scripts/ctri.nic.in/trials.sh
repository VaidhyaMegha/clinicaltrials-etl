#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset as argument
# ./ctri.nic.in/trials.sh datainsights-in/ctri.nic.in/ datainsights-results/ctri.nic.in/pdfs


source $(pwd)/env.sh
source $(pwd)/utility.sh

OUT_DIR=${2:-'temp/ctri.nic.in'}

cleanup  ${DATA_HOME}/${OUT_DIR}


prefix_url="http://ctri.nic.in/Clinicaltrials/pdf_generate.php?"
suffix_url="&EncHid=&modid=&compid=%27,%272det%27"

function download_trial(){
    f=${1}
    f=${f//&/}
    g=${f/trialid=//}
    wget -q ${prefix_url}${f}${suffix_url} \
         -O ${DATA_HOME}/${OUT_DIR}/${g}.pdf -o ${LOG_HOME}/${f}.pdf.log || true
}

## now loop through the above array
find ${DATA_HOME}/${1} | grep html | xargs -I {} cat {} | grep -oE "trialid=[^&]*&" | while read f
do
    download_trial ${f} &
    sleep 1s
done
