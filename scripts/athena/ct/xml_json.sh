 #!/usr/bin/env bash

find ${1} -type f -name "*.json" -delete
find ${1} -type f -name "*.log" -delete

function genJSON(){
    g=${1//.xml/}

    sed "s/&quot;/ /g" ${1} > ${1}.tmp
    xmlstarlet tr xml_json.xslt ${1}.tmp > ${g}.json.tmp

    tr '\n' ' ' < ${g}.json.tmp > ${g}.json

    rm ${1}.tmp
    rm ${g}.json.tmp

    jq ".id_info.nct_id" ${g}.json  >> ${g}.log 2>&1
}

find ${1} -type f -name "*.xml" | while read f
do
    genJSON ${f} &
done
