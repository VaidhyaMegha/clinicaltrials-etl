 #!/usr/bin/env bash

pushd ~/projects/personal/HealthAnalytics/DI_ETL/scripts/athena/ct

function genJSON(){
    g=${1//.xml/}

    xmlstarlet tr xml-json-new.xslt ${1} > ${g}.json.tmp

    tr '\n' ' ' < ${g}.json.tmp > ${g}.json

    rm ${g}.json.tmp
}

find ${1} -type f -name "*.xml" | while read f
do
    genJSON ${f} &
done

popd
