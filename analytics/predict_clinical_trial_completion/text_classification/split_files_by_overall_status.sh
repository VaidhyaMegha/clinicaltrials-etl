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

 k=`echo ${f} | jq  '{
                    "Official title is": .official_title,
                    "| Sampling method is": .eligibility.sampling_method,
                    "| Gender is": .eligibility.gender,
                    "| Minimum age is": .eligibility.minimum_age,
                    "| Maximum age is": .eligibility.maximum_age,
                    "| Primary Outcome 1 is": .primary_outcome[0].description,
                    "| Primary Outcome 2 is": .primary_outcome[1].description,
                    "| Primary Outcome 3 is": .primary_outcome[2].description,
                    "| Primary Outcome 4 is": .primary_outcome[3].description,
                    "| Primary Outcome 5 is": .primary_outcome[4].description,
                    "| Secondary Outcome 1 is": .secondary_outcome[0].description,
                    "| Secondary Outcome 2 is": .secondary_outcome[1].description,
                    "| Secondary Outcome 3 is": .secondary_outcome[2].description,
                    "| Secondary Outcome 4 is": .secondary_outcome[3].description,
                    "| Secondary Outcome 5 is": .secondary_outcome[4].description,
                    "| Other Outcome 1 is": .other_outcome[0].description,
                    "| Other Outcome 2 is": .other_outcome[1].description,
                    "| Other Outcome 3 is": .other_outcome[2].description,
                    "| Other Outcome 4 is": .other_outcome[3].description,
                    "| Other Outcome 5 is": .other_outcome[4].description,
                    "| Keyword 1 is": .keyword[0],
                    "| Keyword 2 is": .keyword[1],
                    "| Keyword 3 is": .keyword[2],
                    "| Keyword 4 is": .keyword[3],
                    "| Keyword 5 is": .keyword[4],
                    "| Condition 1 is": .condition_browse[0],
                    "| Condition 2 is": .condition_browse[1],
                    "| Condition 3 is": .condition_browse[2],
                    "| Condition 4 is": .condition_browse[3],
                    "| Condition 5 is": .condition_browse[4],
                    "| Intervention 1 is": .intervention_browse[0],
                    "| Intervention 2 is": .intervention_browse[1],
                    "| Intervention 3 is": .intervention_browse[2],
                    "| Intervention 4 is": .intervention_browse[3],
                    "| Intervention 5 is": .intervention_browse[4]}'`
 k=`echo ${k} | sed 's/"://g; s/"//g; s/{//g; s/}//g; s/, | /\n/g'`


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
