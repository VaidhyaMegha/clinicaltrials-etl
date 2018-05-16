 #!/usr/bin/env bash

#pushd ~/temp/sax2j/
pushd ~/projects/personal/HealthAnalytics/DI_ETL/scripts/athena/ct

function genJSON(){
#        xml2json -t xml2json -o ${1}.json ${1} --strip_text --strip_newlines
    xmlstarlet ed -d '//comment()' ${1} > ${1}.tmp
    sed -i 's/   last_update_submitted                    --&gt;//g;
            s/   study_first_submitted                    --&gt;//g;
            s/   results_first_submitted                  --&gt;//g;
            s/   disposition_first_submitted              --&gt;//g' ${1}.tmp
    g=${1//.xml/}

#    java -Djava.endorsed.dirs=lib/commons-io-2.4:lib/commons-lang3-3.3.2:lib/xerces-2_11_0-xml-schema-1.1-beta   \
#        -jar sax2j.jar ~/projects/personal/HealthAnalytics/DI_ETL/scripts/athena/ct/public.xsd \
#        ${1}.tmp > ${1}.json

    xmlstarlet tr xml-json-new.xslt ${1}.tmp > ${1}.json

    tr '\n' ' ' < ${1}.json > ${g}.json.tmp

    cat ${g}.json.tmp  > ${g}.json
#    cat ${g}.json.tmp | jq ".clinical_study" > ${g}.json

    #        sed -i 's/#text/text/g; s/#tail/tail/g; s/@type/type/g' ${g}.json

#    cleanup ${1}

}

find ${1} -type f -name "*.xml" | while read f
do
#	echo "${f}"
#	xml2json < ${f} > ${f}.json
#	echo "after ${f}"

    genJSON ${f} &
done

popd

function cleanup(){
    rm -f  ${1}.tmp
    rm -f  ${1}.json
    rm -f  ${g}.json.tmp
}