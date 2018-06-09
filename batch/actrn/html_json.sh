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
 cat ${1} | pup 'div.review-element-block json{}' | jq -c '{
  "trial_id":.[0].children[1].children[0].text,
  "ethics_application_status":.[1].children[1].children[0].text,
  "date_submitted":.[2].children[1].children[0].text,
  "date_registered":.[3].children[1].children[0].text,
  "date_last_updated":.[4].children[1].children[0].text,
  "type_of_registration":.[5].children[1].children[0].text,
  "public_title":.[6].children[1].children[0].text,
  "scientific_title":.[7].children[1].children[0].text,
  "secondary_id":[.[8].children[1:] | .[].children[0].text],
  "UTN":.[9].children[1].children[0].text,
  "trial_acronym":.[10].children[1].children[0].text,
  "linked_study_record":.[11].children[1].children[0].text,
  "key_inclusion_criteria":.[46].children[1].children[0].text,
  "minimum_age":.[47].children[1].children[0].text,
  "maximum_age":.[48].children[1].children[0].text,
  "gender":.[49].children[1].children[0].text,
  "can_health_volunteers_participate":.[50].children[1].children[0].text,
  "key_exclusion_criteria":.[51].children[1].children[0].text,
  "health_conditions_or_problems_studied":"",
  "condition_category":"",
  "condition_code":"",
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

