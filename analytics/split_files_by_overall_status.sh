#!/usr/bin/env bash


# select *  from global_registries where strpos(lower(source_json), 'overall_status":"completed') != 0 or
#                                               strpos(lower(source_json), 'overall_status":"approved for marketing') != 0 or
#                                               strpos(lower(source_json), 'overall_status":"withdrawn') != 0 or
#                                               strpos(lower(source_json), 'overall_status":"terminated') != 0 or
#                                               strpos(lower(source_json), 'overall_status":"suspended') != 0 ;
# https://console.aws.amazon.com/athena/query/results/2cf23c2e-135a-41c0-b7e7-6b045489750c/primary/csv
file_to_read=${1:-'c7532401-a9ab-4a28-bfe8-4071c70d1394'}
download=${2:-'no'}

rm -rf completed
mkdir -p completed

rm -rf didnotcomplete
mkdir -p didnotcomplete

if [[ ${download} == 'yes' ]]; then
    aws s3 cp s3://default-query-results-519510601754-us-east-1/${file_to_read}.csv ~/projects/ctd/DI_ETL/analytics/predict_clinical_outcome/datasets/

    pushd ~/projects/ctd/DI_ETL/FileProcessor/
    mvn exec:java -Dexec.args="/home/mahalaxmi/projects/ctd/DI_ETL/analytics/predict_clinical_outcome/datasets/${file_to_read}.csv replaceDelimiter  /home/mahalaxmi/temp/${file_to_read}.csv"
    popd

    #cut -d$'\t' -f12 ~/temp/${file_to_read}.csv  | sed 's/""/"/g' | sed 's/^.\(.*\).$/\1/' >> ~/temp/${file_to_read}.json
    cat ~/temp/${file_to_read}.csv  | sed 's/""/"/g' | sed 's/^.\(.*\).$/\1/' >> ~/temp/${file_to_read}.json
fi

cat ${file_to_read}".json" | while read f
 do
 h=`echo ${f} | sed 's/"//g'`
 g=`tr -cd '[:alnum:]' < /dev/urandom | fold -w40 | head -n1`

 k="Official title is "`echo ${f} | jq -r '.official_title'`
 k="${k}"$'\n'"Sampling method is "`echo ${f} | jq -r '.eligibility.sampling_method'`
 k="${k}"$'\n'"Gender is "`echo ${f} | jq -r '.eligibility.gender'`
 k="${k}"$'\n'"Minimum age is "`echo ${f} | jq -r '.eligibility.minimum_age'`
 k="${k}"$'\n'"Maximum age is "`echo ${f} | jq -r '.eligibility.maximum_age'`
 k="${k}"$'\n'"Primary Outcome 1 is "`echo ${f} | jq -r '.primary_outcome[0].description'`
 k="${k}"$'\n'"Primary Outcome 2 is "`echo ${f} | jq -r '.primary_outcome[1].description'`
 k="${k}"$'\n'"Primary Outcome 3 is "`echo ${f} | jq -r '.primary_outcome[2].description'`
 k="${k}"$'\n'"Primary Outcome 4 is "`echo ${f} | jq -r '.primary_outcome[3].description'` 
 k="${k}"$'\n'"Primary Outcome 5 is "`echo ${f} | jq -r '.primary_outcome[4].description'`
 k="${k}"$'\n'"Secondary Outcome 1 is "`echo ${f} | jq -r '.secondary_outcome[0].description'`
 k="${k}"$'\n'"Secondary Outcome 2 is "`echo ${f} | jq -r '.secondary_outcome[1].description'`
 k="${k}"$'\n'"Secondary Outcome 3 is "`echo ${f} | jq -r '.secondary_outcome[2].description'`
 k="${k}"$'\n'"Secondary Outcome 4 is "`echo ${f} | jq -r '.secondary_outcome[3].description'`
 k="${k}"$'\n'"Secondary Outcome 5 is "`echo ${f} | jq -r '.secondary_outcome[4].description'`
 k="${k}"$'\n'"Other Outcome 1 is "`echo ${f} | jq -r '.other_outcome[0].description'`
 k="${k}"$'\n'"Other Outcome 2 is "`echo ${f} | jq -r '.other_outcome[1].description'`
 k="${k}"$'\n'"Other Outcome 3 is "`echo ${f} | jq -r '.other_outcome[2].description'`
 k="${k}"$'\n'"Other Outcome 4 is "`echo ${f} | jq -r '.other_outcome[3].description'`
 k="${k}"$'\n'"Other Outcome 5 is "`echo ${f} | jq -r '.other_outcome[4].description'`
 k="${k}"$'\n'"Keyword 1 is "`echo ${f} | jq -r '.keyword[0]'`
 k="${k}"$'\n'"Keyword 2 is "`echo ${f} | jq -r '.keyword[1]'`
 k="${k}"$'\n'"Keyword 3 is "`echo ${f} | jq -r '.keyword[2]'`
 k="${k}"$'\n'"Keyword 4 is "`echo ${f} | jq -r '.keyword[3]'`
 k="${k}"$'\n'"Keyword 5 is "`echo ${f} | jq -r '.keyword[4]'`
 k="${k}"$'\n'"Condition 1 is "`echo ${f} | jq -r '.condition_browse[0]'`
 k="${k}"$'\n'"Condition 2 is "`echo ${f} | jq -r '.condition_browse[1]'`
 k="${k}"$'\n'"Condition 3 is "`echo ${f} | jq -r '.condition_browse[2]'`
 k="${k}"$'\n'"Condition 4 is "`echo ${f} | jq -r '.condition_browse[3]'`
 k="${k}"$'\n'"Condition 5 is "`echo ${f} | jq -r '.condition_browse[4]'`
 k="${k}"$'\n'"Intervention 1 is "`echo ${f} | jq -r '.intervention_browse[0]'`
 k="${k}"$'\n'"Intervention 2 is "`echo ${f} | jq -r '.intervention_browse[1]'`
 k="${k}"$'\n'"Intervention 3 is "`echo ${f} | jq -r '.intervention_browse[2]'`
 k="${k}"$'\n'"Intervention 4 is "`echo ${f} | jq -r '.intervention_browse[3]'`
 k="${k}"$'\n'"Intervention 5 is "`echo ${f} | jq -r '.intervention_browse[4]'`

 if [[ $h == *"overall_status:Completed"* ]]; then
    echo "${k}" >> completed/${g}.txt
 elif [[ $h == *"overall_status:Approved for marketing"* ]]; then
    echo "${k}" >> completed/${g}.txt
 elif [[ $h == *"overall_status:Withdrawn"* ]]; then
    echo "${k}" >> didnotcomplete/${g}.txt
 elif [[ $h == *"overall_status:Terminated"* ]]; then
    echo "${k}" >> didnotcomplete/${g}.txt
 elif [[ $h == *"overall_status:Suspended"* ]]; then
    echo "${k}" >> didnotcomplete/${g}.txt
 fi
 done
