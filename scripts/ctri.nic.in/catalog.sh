#!/usr/bin/env bash
set -e

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

    content=$( grep -Pzo "<table align=center(\n|.)*</table>" ${1} | tr -s " \t\n\r" | tr -d "\t\n\r" )
    content=$( echo ${content} | sed -e 's/<[^>]*>//g' | sed 's/&nbsp;//g'| tr -s " \t\n\r" | tr -d "\t\n\r")

    ctr_num=$( grep -oE "CTRI/[^\[]*\[Registered" <<< ${content} || true)
    ctr_num=${ctr_num//[Registered/}

    type=$( grep -oE "Type of Trial (.)* Type of Study" <<< ${content} || true)
    type=${type//Type of Trial /}
    type=${type// Type of Study/}

    typeOfStudy=$( grep -oE "Type of Study (.)* Study Design"<<< ${content}  || true)
    typeOfStudy=${typeOfStudy//Type of Study /}
    typeOfStudy=${typeOfStudy// Study Design/}

    studyDesign=$( grep -oE "Study Design (.)* Public Title of Study" <<< ${content} || true)
    studyDesign=${studyDesign//Study Design /}
    studyDesign=${studyDesign// Public Title of Study/}

    sponsor=$( grep -oE "Primary Sponsor (.)* Type of Sponsor" <<< ${content} || true)
    sponsor=${sponsor//Primary Sponsor /}
    sponsor=${sponsor// Type of Sponsor/}

    title=$(grep -oE "Scientific Title of Study (.)* Secondary ID" <<< ${content} || true)
    title=${title//Scientific Title of Study /}
    title=${title// Secondary ID/}

    secondaryID=$(grep -oE "Identifier (.)* Details of Principal Investigator" <<< ${content} || true)
    secondaryID=${secondaryID//Identifier /}
    secondaryID=${secondaryID// Details of Principal Investigator/}

    entry="${3}~${index_name}~ctri.nic.in~Health~ICMR~${ctr_num}~${type}~${typeOfStudy}~${studyDesign}~${sponsor}~${title}~${secondaryID}"
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
