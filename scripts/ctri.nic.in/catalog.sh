#!/usr/bin/env bash
set -ex +H

# To Execute this script provide folder containing dataset as argument
# ./ctri.nic.in/catalog.sh datainsights-results/ctri.nic.in/html datainsights-results/ctri.nic.in/analysis


source $(pwd)/env.sh
source $(pwd)/utility.sh

OUT_DIR=${2:-'temp/ctri.nic.in'}

cleanup  ${DATA_HOME}/${OUT_DIR}

echo "S3FilePath~FileGUID~Source~Sector~Organization~ClinicalTrialID~TypeOfTrial~TypeOfStudy~StudyDesign~Sponsor~Title~SecondaryID" \
    > ${DATA_HOME}/${OUT_DIR}/studies.csv

function analyse_file() {
    index_name=`python -c "from sys import argv;print(hash(argv[1]))" ${3}`

    content=$( grep -Pzo "<table align=\"center(\n|.)*</table>" ${1} | tr -s " " | tr -d "\t\n\r" )
    content=$( echo ${content} | sed -e 's/<!--[^-]*-->//g' | sed -e 's/<[^>]*>/ /g' | sed 's/&nbsp;//g' | tr  "\t\n\r" "   " |tr -s " " )

    entry_pre="${3}~${index_name}~ctri.nic.in~Health~ICMR~"
    entry=`python ctri.nic.in/ctri.py "${content}"`
    entry=$(echo "${entry_pre}${entry}" | tr -s " " | sed 's/ ~/~/g' | sed 's/~ /~/g')
    entry=$(echo "${entry}" | xargs -0)
    entry=${entry//$'\r'/}
    entry=${entry//\"/}


    echo ${entry} >> ${2}
}


## now loop through the above array
ls ${DATA_HOME}/${1} | grep -oE "[^ ]*\.html" | while read f
do
    analyse_file ${DATA_HOME}/${1}/${f} ${DATA_HOME}/${OUT_DIR}/studies.csv  ${1}/${f}
done
