#!/usr/bin/env bash
set -ex
set +H


html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/actrn-adapter/'}
context_dir=${4:-'/usr/local/dataintegration'}
max_id=${5:-100}

prefix_url="https://www.anzctr.org.au/Trial/Registration/TrialReview.aspx?id="
suffix_url=""

function download_trial(){
    g=${1}

    wget --no-check-certificate -q ${prefix_url}${g}${suffix_url} \
         -O ${html_dir}/studies/${g}.html  || true
    sleep 0.001s
}

function analyse_file() {
 cat ${1} | pup 'div.review-form-block json{}' | jq  '{
  "trial_id":.[0].children[0].children[1].children[0].text,
  "ethics_application_status":.[1].children[0].children[1].children[0].text,
  "date_submitted":.[2].children[0].children[1].children[0].text,
  "date_registered":.[3].children[0].children[1].children[0].text,
  "date_last_updated":.[4].children[0].children[1].children[0].text,
  "type_of_registration":.[5].children[0].children[1].children[0].text,
  "public_title":.[7].children[0].children[1].children[0].text,
  "scientific_title":.[8].children[0].children[1].children[0].text,
  "secondary_id":.[9].children[0].children[1].children[0:]| select(.!=null)|[.[].text|select(.!=null)],
  "UTN":.[10].children[0].children[1].children[0].text,
  "trial_acronym":.[11].children[0].children[1].children[0].text,
  "linked_study_record":.[12].children[0].children[1].children[0].text,
  "health_conditions_or_problems_studied":[.[[.[] | .children[0].children[0].text | ( if . == null then false else startswith("Health condition(s) or problem(s) studied") end)]| index(true):[.[] |.children[0].children[0].text | ( if . == null then false else startswith("Condition category") end)]| index(true)] | .[]|.children[0].children[0].children[0].text | select(.!=null)],
  "Condition category":[.[[.[] | .children[0].children[0].text | ( if . == null then false else startswith("Condition category") end)]| index(true):[.[] |.children[0].text | ( if . == null then false else startswith("Intervention/exposure") end)]| index(true)] | .[]| {"condition_category":.children[].children[0].children[0].text| select(.!=null),"Condition_code":.children[].children[1].children[0].text}| select(.!=null)],
  "Study_Type":.[] | (if .children[0].children[0].children[0].text == "Study type" then .children[]  else false end) | select (.!= false) | .children[1].children[0].text,
  "Primary Registry":[.[] | (if .children[0].children[0].children[0].text== "Patient registry" then .children[0].children[1].children[0].text  else null end )]| sort | last,
  "Target follow-up duration":[.[] | (if .children[0].children[0].children[0].text== "Target follow-up duration" then .children[0].children[1].children[0].text  else null end )]| sort | last,
  "Target follow-up type":[.[] | (if .children[0].children[0].children[0].text== "Target follow-up type" then .children[0].children[1].children[0].text  else null end )]| sort | last,
  "Description of intervention(s) / exposure":.[] | (if .children[0].children[0].children[0].text == "Description of intervention(s) / exposure" then .children[]  else false end) | select (.!= false) | .children[1].children[0].text,
  "Intervention code":[.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Intervention code [1]") end)]| index(true):[.[] |.children[0].children[0].children[0].text | ( if . == null then false else startswith("Comparator / control treatment") end)]| index(true)] | .[]|.children[0].children[1].children[0].text],
  "Comparator / control treatment":.[] | (if .children[0].children[0].children[0].text == "Comparator / control treatment" then .children[]  else false end) | select (.!= false) | .children[1].children[0].text,
  "Control group":.[] | (if .children[0].children[0].children[0].text == "Control group" then .children[]  else false end) | select (.!= false) | .children[1].children[0].text,  "Outcome":{"PrimaryOutcome":[[.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Primary outcome") end)] | index(true) : [.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Secondary outcome") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | startswith("Primary outcome") then .children[0].children[1].children[0].text else null end) | select(. != null)], [.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Primary outcome") end)] | index(true) : [.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Secondary outcome") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | startswith("Timepoint") then .children[0].children[1].children[0].text else null end) | select(. != null) ]] |  transpose | map( {"primary_outcome": .[0], "timepoint": .[1]}),"SecondaryOutcome":[[.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Secondary outcome") end)] | index(true) : [.[] |  .children[0].text == "Eligibility"] | index(true)] | .[] | (if .children[0].children[0].children[0].text | startswith("Secondary outcome") then .children[0].children[1].children[0].text else null end) | select(. != null)], [.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Secondary outcome") end)] | index(true) : [.[] |  .children[0].text == "Eligibility"] | index(true)] | .[] | (if .children[0].children[0].children[0].text | startswith("Timepoint") then .children[0].children[1].children[0].text else null end) | select(. != null) ]] |  transpose | map( {"secondary_outcome": .[0], "timepoint": .[1]})},
  "Key inclusion criteria":.[] | (if .children[0].children[0].children[0].text == "Key inclusion criteria" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,
  "Minimum age":.[] | (if .children[0].children[0].children[0].text == "Minimum age" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,
  "Maximum age":.[] | (if .children[0].children[0].children[0].text == "Maximum age" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,
  "Gender":.[] | (if .children[0].children[0].children[0].text == "Gender" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,
  "Can healthy volunteers participate?":.[] | (if .children[0].children[0].children[0].text == "Can healthy volunteers participate?" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,
  "Key exclusion criteria":.[] | (if .children[0].children[0].children[0].text == "Key exclusion criteria" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,

  "procedure_for_enrolling_a_subject_and_allocating_the_treatment_allocation_concealment_procedures":"",
  "methods_used_to_generate_the_sequence_in_which_subjects_will_be_randomised_sequence_generation":"",
  "who_is__are_masked__blinded":"",
  "intervention_assignment":"",
  "date_of_first_participant_enrolment":"",
  "anticipated":"",
  "actual":"",
  "date_of_last_participant_enrolment":"",
  "anticipated":"",
  "actual":"",
  "date_of_last_data_collection":"",
  "anticipated":"",
  "actual":"",
  "sample_size":"",
  "target":"",
  "accrual_to_date":"",
  "final":"",
  "recruitment_in_australia":"",
  "primary_sponsor_type":"",
  "name":"",
  "address":"",
  "country":"",
  "principal_investigator":"",
  "contact_person_for_public_queries":"",
  "contact_person_for_scientific_queries":""
  }' >> ${2}
}


pushd ${context_dir}

source "/root/.gvm/scripts/gvm"

gvm install go1.4 --binary

gvm use "go1.4"

go get -u -f github.com/ericchiang/pup

if [[ ${download} == 'yes' ]]; then
    mkdir ${html_dir}/studies
    mkdir ${html_dir}/json

    for ((f=1;f<=${max_id};f+=1))
    do
        download_trial ${f}
    done


    ls ${html_dir}/studies | grep -oE "[^ ]*\.html" | while read f
    do
        analyse_file ${html_dir}/studies/${f} ${html_dir}/json/studies.json &
    done

    aws s3 sync  ${html_dir} ${s3_bucket} --delete
else
    rm -rf ${html_dir}/studies
    rm -rf ${html_dir}/json

    mkdir ${html_dir}/studies
    mkdir ${html_dir}/json

    for ((f=1;f<=${max_id};f+=1))
    do
        download_trial ${f}
    done

    ls ${html_dir}/studies | grep -oE "[^ ]*\.html" | while read f
    do
        analyse_file ${html_dir}/studies/${f} ${html_dir}/json/studies.json &
    done

fi

popd

