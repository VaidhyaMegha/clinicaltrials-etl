#!/usr/bin/env bash
set -ex


html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/ctri-adapter/studies'}
context_dir=${4:-'/usr/local/dataintegration'}
max_id=${5:-48000}
start_id=${6:-1}

prefix_url="http://ctri.nic.in/Clinicaltrials/pmaindet2.php?trialid="
suffix_url=""

function download_trial(){
    g=${1}

    wget  -q ${prefix_url}${g}${suffix_url} \
         -O ${html_dir}/studies/${g}.html  || true 
}

function Delete_Invalid_files() {
  grep -lrIZ 'Invalid Request' ${1} | xargs -0 rm -f --
}

function analyse_file() {
    sed "s/&quot;/ /g" ${1} > ${1}.tmp
    tr '\n' ' ' < ${1}.tmp > ${2}
}

function gen_json() {

cat ${1} | pup 'table tr td table:nth-of-type(2) tr td:nth-of-type(2) json{}' | jq -c  '{    
"ctri_number":.[0].children[0].text,    
"registered_on": .[0].text,    
"last_modified_on":.[1].text,    
"pg_thesis":.[2].text,    
"type_of_trial":.[3].text,    
"type_of_study":.[4].text,    
"study_design":.[5].text,    
"public_title":.[6].text,    
"scientific_title":.[7].text,    
"secondary_ids":{secondary_id:.[8].children[0].children[0].children[1].children[0].text,
"identifier":.[8].children[0].children[0].children[1].children[1].text}  ,    
"pi_or_tc":{name:.[9].children[0].children[0].children[0].children[1].text,
"designation":.[9].children[0].children[0].children[1].children[1].text,
"affiliation":.[9].children[0].children[0].children[2].children[1].text,
"address":.[9].children[0].children[0].children[3].children[1].text,
"phone":.[9].children[0].children[0].children[4].children[1].text,
"fax":.[9].children[0].children[0].children[5].children[1].text,
"email":.[9].children[0].children[0].children[6].children[1].text},    
"scientific_query_contact":{
"name":.[10].children[0].children[0].children[0].children[1].text,
"designation":.[10].children[0].children[0].children[1].children[1].text,
"affiliation":.[10].children[0].children[0].children[2].children[1].text,
"address":.[10].children[0].children[0].children[3].children[1].text,
"phone":.[10].children[0].children[0].children[4].children[1].text,
"fax":.[10].children[0].children[0].children[5].children[1].text,
"email":.[10].children[0].children[0].children[6].children[1].text},    
"public_query_contact":{
"name":.[11].children[0].children[0].children[0].children[1].text,
"designation":.[11].children[0].children[0].children[1].children[1].text,
"affiliation":.[11].children[0].children[0].children[2].children[1].text,
"address":.[11].children[0].children[0].children[3].children[1].text,
"phone":.[11].children[0].children[0].children[4].children[1].text,
"fax":.[11].children[0].children[0].children[5].children[1].text,
"email":.[11].children[0].children[0].children[6].children[1].text},    
"support_source":.[12].children[0].children[0].children[0].children[0].text,    
"primary_sponsor":{
"name":.[13].children[0].children[0].children[0].children[1].text,
"address":.[13].children[0].children[0].children[0].children[1].text,
"type":.[13].children[0].children[0].children[0].children[1].text},    
"secondary_sponsor":{
"name":.[14].children[0].children[0].children[1].children[0].text,
"address":.[14].children[0].children[0].children[1].children[1].text},    
"countries_of_recruitment":.[15].text,    
"sites":.[16].children[0].children[0].children[2:] | (if .!= null then [[{
"name_of_principal_investigator":.[].children[0].text}], [{
"name_of_site": .[].children[1].text}],[{
"site_address":.[].children[2].text}],[{
"phone_fax_email ":.[].children[3].text}]] |  transpose|map(add) else . end),    
"ethics_committee":.[17].children[0].children[0].children[2:] | ( if .!= null then [[{
"name_of_committee":.[].children[0].text}], [{
"approval_status ": .[].children[1].text}]] |  transpose|map(add) else . end),    
"regulatory_clearance_status":{
"status":.[18].children[0].children[0].children[1].children[0].text},    
"condition_or_problems":{
"health_type":.[19].children[0].children[0].children[1].children[0].text,
"condition":.[19].children[0].children[0].children[1].children[1].text},    
"intervention_or_comparator_agent":.[20].children[0].children[0].children[1:]| (if . != null then [[{
"type":.[].children[0].text}], [{
"name": .[].children[1].text}], [{
"details":.[].children[2].text}]]|  transpose|map(add) else . end),    
"inclusion_criteria":{
"age_from":.[21].children[0].children[0].children[0].children[1].text,
"age_to":.[21].children[0].children[0].children[1].children[1].text,    
"gender":.[21].children[0].children[0].children[2].children[1].text,
"details":.[21].children[0].children[0].children[3].children[1].text},    
"exclusion_criteria":{
"details":.[22].children[0].children[0].children[0].children[1].text},    
"method_of_generating_random_sequence":.[23].text,    
"method_of_concealment":.[24].text,    
"blinding_and_masking":.[25].text,    
"primary_outcome":{
"outcome":.[26].children[0].children[0].children[1].children[0].text,
"timepoints":.[26].children[0].children[0].children[1].children[1].text},    
"secondary_outcome":{
"outcome":.[27].children[0].children[0].children[1].children[0].text,
"timepoints":.[26].children[0].children[0].children[1].children[1].text},    
"target_sample_size":.[28].text | split(
"\u0026#34;") | {"total_sample_size": .[1],
"sample_size_from_india":.[3],
"final_enrollment_numbers_achieved_total":.[5],
"final_enrollment_numbers_achieved_india":.[7]},    
"phase":.[29].text,    
"date_of_first_enrollment_india":.[30].text,    
"date_of_completion_india":.[31].text,    
"date_of_first_enrollment_global":.[32].text,    
"date_of_completion_global":.[33].text,    
"estimated_duration":.[34].text | split(
"\u0026#34;") | {"years": .[1],
"months":.[3],
"days":.[5]},    
"recruitment_status_global":.[35].text,    
"recruitment_status_india":.[36].text,    
"publication_details":.[37].text,    
"brief_summary":.[38].text}' >> ${2}/studies.json

}

#pushd ${context_dir}

source ~/.gvm/scripts/gvm
gvm use "go1.9"

if [[ ${download} == 'yes' ]]; then

    if [ -d ${html_dir}/studies ]; then
        rm -rf ${html_dir}/studies
    fi
    if [ -d ${html_dir}/studies/json ]; then
        rm -rf ${html_dir}/studies/json
    fi
    if [ -d ${html_dir}/studies/analysis ]; then
        rm -rf ${html_dir}/studies/analysis
    fi


    mkdir ${html_dir}/studies
    mkdir ${html_dir}/studies/json
    mkdir ${html_dir}/studies/analysis

    for ((f=${start_id};f<=${max_id};f+=1))
    do
        download_trial ${f}
    done

   ls ${html_dir}/studies | grep -oE "[^ ]*\.html" | while read f

   do
        Delete_Invalid_files ${html_dir}/studies/${f}
   done


    ls ${html_dir}/studies | grep -oE "[^ ]*\.html" | while read f

    do
        analyse_file ${html_dir}/studies/${f} ${html_dir}/studies/analysis/${f}
    done

    ls ${html_dir}/studies/analysis | grep -oE "[^ ]*\.html" | while read f
    do
       gen_json  ${html_dir}/studies/analysis/${f} ${html_dir}/studies/json/
    done

aws s3 sync  ${html_dir}/studies ${s3_bucket} --delete
fi
#popd

