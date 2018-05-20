 #!/usr/bin/env bash

pushd ~/projects/DI_ETL/scripts/athena/ct

function genJSON(){
    g=${1//.xml/}

    xmlstarlet tr xml_json.xslt ${1} > ${g}.json.tmp

    tr '\n' ' ' < ${g}.json.tmp > ${g}.json

    rm ${g}.json.tmp
}

find ${1} -type f -name "*.xml" | while read f
do
    genJSON ${f} &
done

popd
