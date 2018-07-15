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
context_dir=${10:-'/usr/local/dataintegration'}
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

  if [ -d ${html_dir}/irctn ]; then
        rm -rf ${html_dir}irctn
  fi

  if [ -d ${html_dir}/jprn ]; then
        rm -rf ${html_dir}jprn
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
    aws s3 cp ${s3_actrn_bucket}json ${html_dir}studies/actrn/json --recursive
    aws s3 cp ${s3_euctrn_bucket}json ${html_dir}studies/euctrn/json --recursive
    aws s3 cp ${s3_irctn_bucket}json ${html_dir}studies/irctn/json --recursive
    aws s3 cp ${s3_jprn_bucket}json ${html_dir}studies/jprn/json --recursive
fi
#########################    CT    ######################################

find ${html_dir}ct/studies/json/ -type f -name "*.json"  | while read f
do
jq -c '{"trialid":.id_info.nct_id,"secondary_id":.id_info.secondary_id,"Date_of_Registration":.study_first_submitted,"primary_sponsors":.sponsors,"secondary_sponsors":.sponsors,"Contact_For_Public_Queries":.location[].contact,"Contact_For_Scientific_Queries":.overall_contact,"Public_Title":.brief_title,"Scientific_Title":.Official_Title,"Intervention":.Intervention,"inclusion_criteria":.eligibility.criteria,"exclusion_criteria":"","study_type":.study_type,"date_of_first_enrollment":"","enrollment":.enrollment,"RecruitmentStatus":.overall_status,"primary_outcome":.primary_outcome,"secondary_outcome":.secondary_outcome,"CompletionDate":.completion_date.text_node_value}' ${f} >> ${html_dir}output/json/utdm_json.json
done

#########################   CTRI   ##############################
find ${html_dir}ctri/studies/json/ -type f -name "*.json"  | while read f
do
jq -c '{"trialid":.ctri_number,"secondary_id":.secondary_ids.secondary_id,"Date_of_Registration":.registered_on,"primary_sponsors":.primary_sponsor,"secondary_sponsors":.secondary_sponsor,"Contact_For_Public_Queries":.public_query_contact,"Contact_For_Scientific_Queries":.scientific_query_contact,"Public_Title":.public_title,"Scientific_Title":.scientific_title,"Intervention":.intervention_or_comparator_agent,"inclusion_criteria":.inclusion_criteria,"exclusion_criteria":.exclusion_criteria,"study_type":.type_of_study,"date_of_first_enrollment":.date_of_first_enrollment_india,"enrollment":.target_sample_size,"RecruitmentStatus":.recruitment_status_india,"primary_outcome":.primary_outcome,"secondary_outcome":.secondary_outcome,"completionDate":.date_of_completion_india}'  {f} >> ${html_dir}output/json/utdm_json.json
done

#########################   JPRN    #####################################
find ${html_dir}jprn/studies/json/ -type f -name "*.json"  | while read f
do
jq -c '{"trialid":.Unique_ID_issued_by_UMIN,"secondary_id":.Secondary_IDs,"Date_of_Registration":.Management_information.Registered_date,"primary_sponsors":.Sponsor,"secondary_sponsors":.Other_related_Organizations.Co_sponsor,"Contact_For_Public_Queries":.Public_Contact_Person,"Contact_For_Scientific_Queries":.Research_Contact_Person,"Public_Title":.Basic_information.Title_of_the_study_Brief_title,"Scientific_Title":.Official_scientific_title_of_the_study,"Intervention":.Intervention,"inclusion_criteria":.Eligibility.Key_inclusion_criteria,"exclusion_criteria":.Eligibility.key_exclusion_criteria,"study_type":.Base.Study_type,"date_of_first_enrollment":"","enrollment":.Eligibility.target_sample_size,"RecruitmentStatus":.Recruitment_status,"primary_outcome":.Assessment.Primary_outcomes,"secondary_outcome":.Assessment.Key_secondary_outcomes,"completionDate":.Progress.Date_analysis_concluded}' ${f} >> ${html_dir}output/json/utdm_json.jsonn

#########################   IRCTN    #####################################
find ${html_dir}irctn/studies/json/ -type f -name "*.json"  | while read f
do
jq -c '{"trialid":.IRCT_RegistrationNumber,"secondary_id":.Secondary_Ids,"Date_of_Registration":.Registration_date,"primary_sponsors":.Sponsors__or_FundingSources,"secondary_sponsors":"","Contact_For_Public_Queries":.PersonResponsibleForGeneralQueries,"Contact_For_Scientific_Queries":.PersonResponsibleForScientificQueries,"Public_Title":.Public_title,"Scientific_Title":.Scientific_title,"Intervention":.Intervention_groups,"inclusion_criteria":.InclusionCriteria,"exclusion_criteria":.ExclusionCriteria,"study_type":"","date_of_first_enrollment":.Expected_Recruitment_start_Date,"enrollment":.Target_sample_size,"RecruitmentStatus":.Recruitment_status,"primary_outcome":.Primary_outcomes,"secondary_outcome":.Secondary_outcomes,"completionDate":""}' ${f} >> ${html_dir}output/json/utdm_json.json

#########################   CHICTRN    #####################################

find ${html_dir}irctn/studies/json/ -type f -name "*.json"  | while read f
do

jq -c   '{"trialid":.Registration_number,"secondary_id":.The_registration_number_of_the_Partner_Registry_or_other_register,"Date_of_Registration":.Date_of_Registration,"primary_sponsors":.Primary_sponsor,"secondary_sponsors":.Secondary_sponsor,"Contact_For_Public_Queries":"","Contact_For_Scientific_Queries":"","Public_Title":.Public_title,"Scientific_Title":.Scientific_title,"Intervention":.Interventions,"inclusion_criteria":"","exclusion_criteria":.Exclusion_criteria,"study_type":"","date_of_first_enrollment":"","enrollment":.Interventions.Sample_size,"RecruitmentStatus":.Recruiting_status,"primary_outcome":.Outcomes,"secondary_outcome":.Outcomes,"completionDate":"" }' ${f} >> ${html_dir}output/json/utdm_json.json

done

#########################   ACTRN    #####################################

find ${html_dir}irctn/studies/json/ -type f -name "*.json"  | while read f
do

jq -c   '{"trialid":.trial_id,"secondary_id":.secondary_id,"Date_of_Registration":.date_registered
,"primary_sponsors":"","secondary_sponsors":"","Contact_For_Public_Queries":.Contact_person_for_public_queries,"Contact_For_Scientific_Queries":.Contact_person_for_scientific_queries,"Public_Title":.public_title,"Scientific_Title":.scientific_title,"Intervention":"","inclusion_criteria":.Key_inclusion_criteria,"exclusion_criteria":.Key_exclusion_criteria,"study_type":.Study_Type,"date_of_first_enrollment":.Date_of_first_participant_enrolment,"enrollment":.Sample_Size,"RecruitmentStatus":.Recruitment_status,"primary_outcome":.Outcome.PrimaryOutcome,"secondary_outcome":.Outcome.SecondaryOutcome,"completionDate":"" }' ${f} >> ${html_dir}output/json/utdm_json.json

done

#########################   EUCTRN    #####################################
find ${html_dir}irctn/studies/json/ -type f -name "*.json"  | while read f
do

jq -c   '{"trialid":.eudract_number,"secondary_id":.secondary_id,"Date_of_Registration":.date_registered
,"primary_sponsors":.name_of_sponsor,"secondary_sponsors":"","Contact_For_Public_Queries":"","Contact_For_Scientific_Queries":"","Public_Title":"","Scientific_Title":"","Intervention":"","inclusion_criteria":.principal_inclusion_criteria,"exclusion_criteria":.principal_exclusion_criteria,"study_type":.clinical_trial_type,"date_of_first_enrollment":"","enrollment":.Sample_Size,"RecruitmentStatus":.trial_status,"primary_outcome":"","secondary_outcome":"","completionDate":"" }' ${f} >> ${html_dir}output/json/utdm_json.json

done