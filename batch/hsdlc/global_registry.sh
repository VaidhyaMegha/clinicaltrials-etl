#!/usr/bin/env bash
set -ex

html_dir=${1}
download=${2:-'no'}
s3_ct_bucket=${3:-'s3://hsdlc-results/ct-adapter/'}
s3_ctri_bucket=${4:-'s3://hsdlc-results/ctri-adapter/studies/'}
s3_chictr_bucket=${5:-'s3://hsdlc-results/chictr-adapter/studies/'}
s3_actrn_bucket=${6:-'s3://hsdlc-results/actrn-adapter/'}
s3_euctrn_bucket=${7:-'s3://hsdlc-results/euctrn-adapter/'}
s3_irctn_bucket=${8:-'s3://hsdlc-results/irctn-adapter/'}
s3_jprn_bucket=${9:-'s3://hsdlc-results/jprn-adapter/'}
s3_utdm_bucket=${10:-'s3://hsdlc-results/utdm-adapter/'}
context_dir=${11:-'/usr/local/dataintegration'}

if [[ ${download} == 'yes' ]]; then
  if [ -d ${html_dir}ct ]; then
        rm -rf ${html_dir}ct
  fi

  if [ -d ${html_dir}ctri ]; then
        rm -rf ${html_dir}ctri
  fi

  if [ -d ${html_dir}chictr ]; then
        rm -rf ${html_dir}chictr
  fi

  if [ -d ${html_dir}actrn ]; then
        rm -rf ${html_dir}actrn
  fi

  if [ -d ${html_dir}euctrn ]; then
        rm -rf ${html_dir}euctrn
  fi

  if [ -d ${html_dir}irctn ]; then
        rm -rf ${html_dir}irctn
  fi

  if [ -d ${html_dir}jprn ]; then
        rm -rf ${html_dir}jprn
  fi

  if [ -d ${html_dir}output ]; then
        rm -rf ${html_dir}output
  fi

    mkdir ${html_dir}ct
    mkdir ${html_dir}ct/studies
    mkdir ${html_dir}ct/studies/json

    mkdir ${html_dir}ctri
    mkdir ${html_dir}ctri/studies
    mkdir ${html_dir}ctri/studies/json

    mkdir ${html_dir}chictr
    mkdir ${html_dir}chictr/studies
    mkdir ${html_dir}chictr/studies/json

    mkdir ${html_dir}actrn
    mkdir ${html_dir}actrn/studies
    mkdir ${html_dir}actrn/studies/json

    mkdir ${html_dir}euctrn
    mkdir ${html_dir}euctrn/studies
    mkdir ${html_dir}euctrn/studies/json

    mkdir ${html_dir}irctn
    mkdir ${html_dir}irctn/studies
    mkdir ${html_dir}irctn/studies/json

    mkdir ${html_dir}jprn
    mkdir ${html_dir}jprn/studies
    mkdir ${html_dir}jprn/studies/json

    mkdir ${html_dir}output
    mkdir ${html_dir}output/json

    aws s3 cp ${s3_ct_bucket}json ${html_dir}ct/studies/json --recursive
    aws s3 cp ${s3_ctri_bucket}json ${html_dir}ctri/studies/json --recursive
    aws s3 cp ${s3_chictr_bucket}json ${html_dir}chictr/studies/json --recursive
    aws s3 cp ${s3_actrn_bucket}json ${html_dir}actrn/studies/json --recursive
    aws s3 cp ${s3_euctrn_bucket}json ${html_dir}euctrn/studies/json --recursive
    aws s3 cp ${s3_irctn_bucket}json ${html_dir}irctn/studies/json --recursive
    aws s3 cp ${s3_jprn_bucket}json ${html_dir}jprn/studies/json --recursive
fi
#########################    CT    ######################################

find ${html_dir}ct/studies/json/ -type f -name "*.json"  | while read f
do
jq -c '{"trialid":.id_info.nct_id,"secondary_id":.id_info.secondary_id,"Date_of_Registration":.study_first_submitted,"Public_Title":.brief_title,"Scientific_Title":.Official_Title,"study_type":.study_type,"date_of_first_enrollment":"","enrollment":.enrollment,"RecruitmentStatus":.overall_status,"CompletionDate":.completion_date.text_node_value, "registry": "CT", "source_json": tojson}' ${f} >> ${html_dir}output/json/utdm_json.json
done

if [ -d ${html_dir}ct ]; then
    rm -rf ${html_dir}ct
fi

#########################   CTRI   ##############################
find ${html_dir}ctri/studies/json/ -type f -name "*.json"  | while read f
do
jq -c '{"trialid":.ctri_number,"secondary_id":[.secondary_ids.secondary_id],"Date_of_Registration":.registered_on,"Public_Title":.public_title,"Scientific_Title":.scientific_title,"study_type":.type_of_study,"date_of_first_enrollment":.date_of_first_enrollment_india,"enrollment":.target_sample_size,"RecruitmentStatus":.recruitment_status_india,"completionDate":.date_of_completion_india, "registry": "CTRI", "source_json": tojson}'  ${f} >> ${html_dir}output/json/utdm_json.json
done

 if [ -d ${html_dir}ctri ]; then
        rm -rf ${html_dir}ctri
 fi

#########################   JPRN    #####################################
find ${html_dir}jprn/studies/json/ -type f -name "*.json"  | while read f
do
jq -c '{"trialid":.Unique_ID_issued_by_UMIN,"secondary_id":[.Secondary_IDs.Study_ID_1, .Secondary_IDs.Study_ID_2 ],"Date_of_Registration":.Management_information.Registered_date,"Public_Title":.Basic_information.Title_of_the_study_Brief_title,"Scientific_Title":.Official_scientific_title_of_the_study,"study_type":.Base.Study_type,"date_of_first_enrollment":"","enrollment":.Eligibility.target_sample_size,"RecruitmentStatus":.Recruitment_status,"completionDate":.Progress.Date_analysis_concluded, "registry": "JPRN", "source_json": tojson}' ${f} >> ${html_dir}output/json/utdm_json.json

done

  if [ -d ${html_dir}jprn ]; then
        rm -rf ${html_dir}jprn
  fi

#########################   IRCTN    #####################################
find ${html_dir}irctn/studies/json/ -type f -name "*.json"  | while read f
do
jq -c '{"trialid":.IRCT_RegistrationNumber,"secondary_id":.Secondary_Ids,"Date_of_Registration":.Registration_date,"Public_Title":.Public_title,"Scientific_Title":.Scientific_title,"study_type":"","date_of_first_enrollment":.Expected_Recruitment_start_Date,"enrollment":.Target_sample_size,"RecruitmentStatus":.Recruitment_status,"completionDate":"", "registry": "IRCT", "source_json": tojson}' ${f} >> ${html_dir}output/json/utdm_json.json
done

  if [ -d ${html_dir}irctn ]; then
        rm -rf ${html_dir}irctn
  fi

#########################   CHICTRN    #####################################

find ${html_dir}chictr/studies/json/ -type f -name "*.json"  | while read f
do

jq -c   '{"trialid":.Registration_number,"secondary_id":[.The_registration_number_of_the_Partner_Registry_or_other_register],"Date_of_Registration":.Date_of_Registration,"Public_Title":.Public_title,"Scientific_Title":.Scientific_title,"study_type":"","date_of_first_enrollment":"","enrollment":.Interventions.Sample_size,"RecruitmentStatus":.Recruiting_status,"completionDate":"", "registry": "ChiCTR", "source_json": tojson }' ${f} >> ${html_dir}output/json/utdm_json.json

done

 if [ -d ${html_dir}chictr ]; then
        rm -rf ${html_dir}chictr
 fi

#########################   ACTRN    #####################################

find ${html_dir}actrn/studies/json/ -type f -name "*.json"  | while read f
do

jq -c   '{"trialid":.trial_id,"secondary_id":.secondary_id,"Date_of_Registration":.date_registered,"Public_Title":.public_title,"Scientific_Title":.scientific_title,"study_type":.Study_Type,"date_of_first_enrollment":.Date_of_first_participant_enrolment,"enrollment":.Sample_Size,"RecruitmentStatus":.Recruitment_status,"completionDate":"" , "registry": "ACTRN", "source_json": tojson}' ${f} >> ${html_dir}output/json/utdm_json.json

done

  if [ -d ${html_dir}actrn ]; then
        rm -rf ${html_dir}actrn
  fi

#########################   EUCTRN    #####################################
find ${html_dir}euctrn/studies/json/ -type f -name "*.json"  | while read f
do

jq -c '{"trialid":.eudract_number,"secondary_id":[],"Date_of_Registration":.date_on_which_this_record_was_first_entered_in_the_eudract_database,"Public_Title":.full_title_of_the_trial,"Scientific_Title":.name_or_abbreviated_title_of_the_trial_where_available,"study_type":.clinical_trial_type,"date_of_first_enrollment":"","enrollment":.Sample_Size,"RecruitmentStatus":.trial_status,"completionDate":"" , "registry": "EUCTRN", "source_json": tojson}' ${f} >> ${html_dir}output/json/utdm_json.json

done

  if [ -d ${html_dir}euctrn ]; then
        rm -rf ${html_dir}euctrn
  fi

aws s3 sync ${html_dir}/output/ ${s3_utdm_bucket}  --delete