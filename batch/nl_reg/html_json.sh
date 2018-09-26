#!/usr/bin/env bash
set -ex
set +H

html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/ntr-adapter/studies'}
context_dir=${4:-'/usr/local/dataintegration'}
max_id=${5:-8000}
start_id=${6:-22}

prefix_url="http://www.trialregister.nl/trialreg/admin/rctview.asp?TC="
suffix_url=""

function download_trial(){
    g=${1}

    wget  -q ${prefix_url}${g}${suffix_url} \
         -O ${html_dir}/studies/${g}.html  || true 
}

function Delete_Invalid_files() {
  grep -lrIZ 'Registratie-nummer' ${1} | xargs -0 rm -f --
}

function analyse_file() {
    sed "s/&quot;/ /g" ${1} > ${1}.tmp
    tr '\n' ' ' < ${1}.tmp > ${2}
}

function gen_json() {

ntr_number=$(cat ${1} | pup 'table tr td table:nth-of-type(1) tr td:nth-of-type(2) json{}' | jq -c '.[1].text')

if [[ ! -z ntr_number ]]
then
    cat ${1} | pup 'table tr td table:nth-of-type(1) tr td:nth-of-type(2) json{}' | jq -c  '{"candidate_number":.[0].text,
    "NTR_Number":.[1].text,
    "ISRCTN":.[2].text,
    "Date_ISRCTN_created":.[3].text,
    "date_ISRCTN_requested":.[4].text,
    "Date_Registered_NTR":.[5].text,
    "Secondary_IDs":.[6].text,
    "Public_Title":.[7].text,
    "Scientific_Title":.[8].text,
    "ACRONYM":.[9].text,
    "hypothesis":.[10].text,
    "Healt_Conditions_or_Problems_studied":.[11].text,
    "Inclusion_criteria":.[12].text,
    "Exclusion_criteria":.[13].text,
    "mec_approval_received":.[14].text,
    "multicenter_trial":.[15].text,
    "randomised":.[16].text,
    "group":.[17].text,
    "Type":.[18].text,
    "Studytype":.[19].text,
    "planned_startdate":.[20].text,
    "planned_closingdate":.[21].text,
    "Target_number_of_participants":.[22].text,
    "Interventions":.[23].text,
    "Primary_outcome":.[24].text,
    "Secondary_outcome":.[25].text,
    "Timepoints":.[26].text,
    "Trial_web_site":.[27].text,
    "status":.[28].text,
    "CONTACT_FOR_PUBLIC_QUERIES":.[29].text,
    "CONTACT_for_SCIENTIFIC_QUERIES":.[30].text,
    "Sponsor/Initiator":.[31].text,
    "Funding_Sources_of_Monetary_or_Material_Support":.[32].text,
    "Publications":.[33].text,
    "Brief_summary":.[34].text,
    "Main_changes_audit_trail":.[35].text,
    "RECORD":.[36].text}' >> ${2}/studies.json
fi
}

source ~/.gvm/scripts/gvm
gvm use "go1.4"

pushd ${context_dir}

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

#aws s3 sync  ${html_dir}/studies ${s3_bucket} --delete
fi
popd

