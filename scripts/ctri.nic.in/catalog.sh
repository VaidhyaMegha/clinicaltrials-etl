#!/usr/bin/env bash
set  +H

# To Execute this script provide folder containing dataset as argument
# ./ctri.nic.in/catalog.sh datainsights-results/ctri.nic.in/html datainsights-results/ctri.nic.in/analysis


source $(pwd)/env.sh
source $(pwd)/utility.sh

OUT_DIR=${2:-'temp/ctri.nic.in'}

cleanup  ${DATA_HOME}/${OUT_DIR}

entry=`python ctri.nic.in/keys.py`
echo ${entry} >> ${DATA_HOME}/${OUT_DIR}/studies.csv

function analyse_file() {
    content=`python ctri.nic.in/parse.py  ${1} ${3}`

    content=$( echo ${content} | sed -e 's/<[^>]*>//g; s/Close\n//g; s/&[^\;]*\;//g' |
     sed 's/Modification(s)//g; s/\[Registered on: /~/; s/\\n//g; s/\\r//g; s/\\t//g; s/\]//g; s/ ~/~/g; s/~ /~/g' | tr -s " "   )

    echo ${content} >> ${2}
}




## now loop through the above array
ls ${DATA_HOME}/${1} | grep -oE "[^ ]*\.html" | while read f
do
    analyse_file ${DATA_HOME}/${1}/${f} ${DATA_HOME}/${OUT_DIR}/studies.csv  ${1}/${f}
done
