#!/usr/bin/env bash
set -ex

html_dir=${1}
download=${2:-'no'}
s3_ct_bucket=${3:-'s3://hsdlc-results/ct-adapter/'}
s3_ctri_bucket=${4:-'s3://hsdlc-results/ctri-adapter/'}
s3_chictr_bucket=${5:-'s3://hsdlc-results/chictr-adapter/'}
s3_actrn_bucket=${6:-'s3://hsdlc-results/actrn-adapter/'}
s3_euctrn_bucket=${7:-'s3://hsdlc-results/euctrn-adapter/'}
s3_irctn_bucket=${8:-'s3://hsdlc-results/irctn-adapter/'}
s3_jprn_bucket=${9:-'s3://hsdlc-results/jprn-adapter/'}
context_dir=${10:-'/usr/local/dataintegration'}

  if [ -d ${html_dir}/utdm ]; then
        rm -rf ${html_dir}/utdm
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

    mkdir ${html_dir}/actrn
    mkdir ${html_dir}/actrn/studies
    mkdir ${html_dir}/actrn/studies/json

    mkdir ${html_dir}/euctrn
    mkdir ${html_dir}/euctrn/studies
    mkdir ${html_dir}/euctrn/studies/json

    mkdir ${html_dir}/irctn
    mkdir ${html_dir}/irctn/studies
    mkdir ${html_dir}/irctn/studies/json

    mkdir ${html_dir}/jprn
    mkdir ${html_dir}/jprn/studies
    mkdir ${html_dir}/jprn/studies/json

    aws s3 cp ${s3_ct_bucket}json ${html_dir}ct/studies/json --recursive
    aws s3 cp ${s3_ctri_bucket}json ${html_dir}ctri/studies/json
    aws s3 cp ${s3_chictr_bucket}json ${html_dir}chictr/studies/json
    aws s3 cp ${s3_actrn_bucket}json ${html_dir}studies/actrn/json
    aws s3 cp ${s3_euctrn_bucket}json ${html_dir}studies/euctrn/json --recursive
    aws s3 cp ${s3_irctn_bucket}json ${html_dir}studies/irctn/json
    aws s3 cp ${s3_jprn_bucket}json ${html_dir}studies/jprn/json


#########################    CT    ######################################

find ${html_dir}ct/studies/json/ -type f -name "*.json"  | while read f
do
jq -c '{"trialid":.id_info.nct_id,"secondary_id":.id_info.secondary_id,"Date_of_Registration":.study_first_submitted,"primary_sponsors":.sponsors,"secondary_sponsors":.sponsors,"Contact_For_Public_Queries":.location[].contact,"Contact_For_Scientific_Queries":.overall_contact,"Public_Title":.brief_title,"Scientific_Title":.Official_Title,"Intervention":.Intervention,"inclusion_criteria":.eligibility.criteria,"exclusion_criteria":"","study_type":.study_type,"date_of_first_enrollment":"","enrollment":.enrollment,"RecruitmentStatus":.overall_status,"primary_outcome":.primary_outcome,"secondary_outcome":.secondary_outcome,"CompletionDate":.completion_date.text_node_value}'  >> ~/Downloads/utdmjson.json
done
#jq -c '{"trialid":.id_info.nct_id,"secondary_id":.id_info.secondary_id,"Date_of_Registration":.study_first_submitted,"primary_sponsors":.sponsors,"secondary_sponsors":.sponsors,"Contact_For_Public_Queries":.location[].contact,"Contact_For_Scientific_Queries":.overall_contact,"Public_Title":.brief_title,"Scientific_Title":.Official_Title,"Intervention":.Intervention,"inclusion_criteria":.eligibility.criteria,"exclusion_criteria":"","study_type":.study_type,"date_of_first_enrollment":"","enrollment":.enrollment,"RecruitmentStatus":.overall_status,"primary_outcome":.primary_outcome,"secondary_outcome":.secondary_outcome,"CompletionDate":.completion_date.text_node_value}'  >> ~/Downloads/utdmjson.json
#
#########################   CTRI   ##############################
#jq -c '{"trialid":.ctri_number,"secondary_id":.secondary_ids.secondary_id,"Date_of_Registration":.registered_on,"primary_sponsors":.primary_sponsor,"secondary_sponsors":.secondary_sponsor,"Contact_For_Public_Queries":.public_query_contact,"Contact_For_Scientific_Queries":.scientific_query_contact,"Public_Title":.public_title,"Scientific_Title":.scientific_title,"Intervention":.intervention_or_comparator_agent,"inclusion_criteria":.inclusion_criteria,"exclusion_criteria":.exclusion_criteria,"study_type":.type_of_study,"date_of_first_enrollment":.date_of_first_enrollment_india,"enrollment":.target_sample_size,"RecruitmentStatus":.recruitment_status_india,"primary_outcome":.primary_outcome,"secondary_outcome":.secondary_outcome,"completionDate":.date_of_completion_india}'  ~/Downloads/ctri.json  >> ~/Downloads/utdmjson.json
#
#########################   JPRN    #####################################
#jq -c '{"trialid":.Unique_ID_issued_by_UMIN,"secondary_id":.Secondary_IDs,"Date_of_Registration":.Management_information.Registered_date,"primary_sponsors":.Sponsor,"secondary_sponsors":.Other_related_Organizations.Co_sponsor,"Contact_For_Public_Queries":.Public_Contact_Person,"Contact_For_Scientific_Queries":.Research_Contact_Person,"Public_Title":.Basic_information.Title_of_the_study_Brief_title,"Scientific_Title":.Official_scientific_title_of_the_study,"Intervention":.Intervention,"inclusion_criteria":.Eligibility.Key_inclusion_criteria,"exclusion_criteria":.Eligibility.key_exclusion_criteria,"study_type":.Base.Study_type,"date_of_first_enrollment":"","enrollment":.Eligibility.target_sample_size,"RecruitmentStatus":.Recruitment_status,"primary_outcome":.Assessment.Primary_outcomes,"secondary_outcome":.Assessment.Key_secondary_outcomes,"completionDate":.Progress.Date_analysis_concluded}' ~/Downloads/jprntest.json >> ~/Downloads/utdmjson.json
#
#########################   IRCTN    #####################################
#jq -c '{"trialid":.IRCT_RegistrationNumber,"secondary_id":.Secondary_Ids,"Date_of_Registration":.Registration_date,"primary_sponsors":.Sponsors__or_FundingSources,"secondary_sponsors":"","Contact_For_Public_Queries":.PersonResponsibleForGeneralQueries,"Contact_For_Scientific_Queries":.PersonResponsibleForScientificQueries,"Public_Title":.Public_title,"Scientific_Title":.Scientific_title,"Intervention":.Intervention_groups,"inclusion_criteria":.InclusionCriteria,"exclusion_criteria":.ExclusionCriteria,"study_type":"","date_of_first_enrollment":.Expected_Recruitment_start_Date,"enrollment":.Target_sample_size,"RecruitmentStatus":.Recruitment_status,"primary_outcome":.Primary_outcomes,"secondary_outcome":.Secondary_outcomes,"completionDate":""}' ~/Downloads/irct.json >> ~/Downloads/utdmjson.json
#
#########################   CHICTRN    #####################################
#jq -c   '{"trialid":.Registration_number,"secondary_id":.The_registration_number_of_the_Partner_Registry_or_other_register,"Date_of_Registration":.Date_of_Registration,"primary_sponsors":.Primary_sponsor,"secondary_sponsors":.Secondary_sponsor,"Contact_For_Public_Queries":"","Contact_For_Scientific_Queries":"","Public_Title":.Public_title,"Scientific_Title":.Scientific_title,"Intervention":.Interventions,"inclusion_criteria":"","exclusion_criteria":.Exclusion_criteria,"study_type":"","date_of_first_enrollment":"","enrollment":.Interventions.Sample_size,"RecruitmentStatus":.Recruiting_status,"primary_outcome":.Outcomes,"secondary_outcome":.Outcomes,"completionDate":"" }'~/Downloads/chictr.json >> ~/Downloads/utdmjson.json