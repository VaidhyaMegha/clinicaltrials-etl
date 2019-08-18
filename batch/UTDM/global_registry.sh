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
s3_brtr_bucket=${10:-'s3://hsdlc-results/brtr-adapter/'}
s3_ntr_bucket=${11:-'s3://hsdlc-results/ntr-adapter/studies/'}
s3_cubct_bucket=${12:-'s3://hsdlc-results/cubct-adapter/studies/'}
s3_perct_bucket=${13:-'s3://hsdlc-results/perct-adapter/studies/'}
s3_slctr_bucket=${14:-'s3://hsdlc-results/slctr-adapter/studies/'}
s3_tctr_bucket=${15:-'s3://hsdlc-results/tctr-adapter/studies/'}
s3_isrctn_bucket=${16:-'s3://hsdlc-results/isrctn-adapter/'}
s3_cristr_bucket=${17:-'s3://hsdlc-results/cristr-adapter/studies/'}
s3_utdm_bucket=${18:-'s3://hsdlc-results/utdm-adapter/'}
context_dir=${19:-'/usr/local/dataintegration'}

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

  if [ -d ${html_dir}brtr ]; then
        rm -rf ${html_dir}brtr
  fi

  if [ -d ${html_dir}ntr ]; then
        rm -rf ${html_dir}ntr
  fi

  if [ -d ${html_dir}cubct ]; then
        rm -rf ${html_dir}cubct
  fi

  if [ -d ${html_dir}perct ]; then
        rm -rf ${html_dir}perct
  fi

  if [ -d ${html_dir}slctr ]; then
        rm -rf ${html_dir}slctr
  fi

  if [ -d ${html_dir}isrctn ]; then
        rm -rf ${html_dir}isrctn
  fi

  if [ -d ${html_dir}tctr ]; then
        rm -rf ${html_dir}tctr
  fi

  if [ -d ${html_dir}cristr ]; then
        rm -rf ${html_dir}cristr
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

    mkdir ${html_dir}brtr
    mkdir ${html_dir}brtr/studies
    mkdir ${html_dir}brtr/studies/json

    mkdir ${html_dir}ntr
    mkdir ${html_dir}ntr/studies
    mkdir ${html_dir}ntr/studies/json

    mkdir ${html_dir}cubct
    mkdir ${html_dir}cubct/studies
    mkdir ${html_dir}cubct/studies/json

    mkdir ${html_dir}perct
    mkdir ${html_dir}perct/studies
    mkdir ${html_dir}perct/studies/json

    mkdir ${html_dir}slctr
    mkdir ${html_dir}slctr/studies
    mkdir ${html_dir}slctr/studies/json

    mkdir ${html_dir}isrctn
    mkdir ${html_dir}isrctn/studies
    mkdir ${html_dir}isrctn/studies/json

    mkdir ${html_dir}tctr
    mkdir ${html_dir}tctr/studies
    mkdir ${html_dir}tctr/studies/json

    mkdir ${html_dir}cristr
    mkdir ${html_dir}cristr/studies
    mkdir ${html_dir}cristr/studies/json

    mkdir ${html_dir}output
    mkdir ${html_dir}output/json

    aws s3 cp ${s3_ct_bucket}json ${html_dir}ct/studies/json --recursive
    aws s3 cp ${s3_ctri_bucket}json ${html_dir}ctri/studies/json --recursive
    aws s3 cp ${s3_chictr_bucket}json ${html_dir}chictr/studies/json --recursive
    aws s3 cp ${s3_actrn_bucket}json ${html_dir}actrn/studies/json --recursive
    aws s3 cp ${s3_euctrn_bucket}json ${html_dir}euctrn/studies/json --recursive
    aws s3 cp ${s3_irctn_bucket}json ${html_dir}irctn/studies/json --recursive
    aws s3 cp ${s3_jprn_bucket}json ${html_dir}jprn/studies/json --recursive
    aws s3 cp ${s3_brtr_bucket}json ${html_dir}brtr/studies/json --recursive
    aws s3 cp ${s3_ntr_bucket}json ${html_dir}ntr/studies/json --recursive
    aws s3 cp ${s3_cubct_bucket}json ${html_dir}cubct/studies/json --recursive
    aws s3 cp ${s3_perct_bucket}json ${html_dir}perct/studies/json --recursive
    aws s3 cp ${s3_slctr_bucket}json ${html_dir}slctr/studies/json --recursive
    aws s3 cp ${s3_isrctn_bucket}json ${html_dir}isrctn/studies/json --recursive
#    aws s3 cp ${s3_tctr_bucket}json ${html_dir}tctr/studies/json --recursive
    aws s3 cp ${s3_cristr_bucket}json ${html_dir}cristr/studies/json --recursive
fi
#########################    CT    ######################################

find ${html_dir}ct/studies/json/ -type f -name "*.json"  | while read f
do
jq -c -R 'fromjson? | {"trialid":.id_info.nct_id,"secondary_id":.id_info.secondary_id,"Date_of_Registration":.study_first_submitted,"Public_Title":.brief_title,"Scientific_Title":.Official_Title,"study_type":.study_type,"date_of_first_enrollment":"","RecruitmentStatus":.overall_status,"CompletionDate":"","PrimarySponsors":{"name": [.sponsors.lead_sponsor.agency],   "person": [],"address":[]},"SecondarySponsors":{"name": [],   "person": [],"address":[]},"Contact":[], "registry": "CT", "source_json": tojson}' ${f} >> ${html_dir}output/json/utdm_json.json
done


if [ -d ${html_dir}ct ]; then
    rm -rf ${html_dir}ct
fi

#########################   CTRI   ##############################
find ${html_dir}ctri/studies/json/ -type f -name "*.json"  | while read f
do
jq -c -R 'fromjson? | {"trialid":.ctri_number,"secondary_id":[.secondary_ids.secondary_id],"Date_of_Registration":.registered_on,"Public_Title":.public_title,"Scientific_Title":.scientific_title,"study_type":.type_of_study,"date_of_first_enrollment":.date_of_first_enrollment_india,"RecruitmentStatus":.recruitment_status_india,"completionDate":.date_of_completion_india, "PrimarySponsors":{"name": [.primary_sponsor.name],   "person": [],"address":[.primary_sponsor.address]},"SecondarySponsors":{"name": [.secondary_sponsor.name],   "person": [],"address":[.secondary_sponsor.address]},"Contact":[],"registry": "CTRI", "source_json": tojson}'  ${f} >> ${html_dir}output/json/utdm_json.json
done

 if [ -d ${html_dir}ctri ]; then
        rm -rf ${html_dir}ctri
 fi

#########################   JPRN    #####################################
find ${html_dir}jprn/studies/json/ -type f -name "*.json"  | while read f
do
jq -c -R 'fromjson? | {"trialid":.Unique_ID_issued_by_UMIN,"secondary_id":[.Secondary_IDs.Study_ID_1, .Secondary_IDs.Study_ID_2 ],"Date_of_Registration":.Management_information.Registered_date,"Public_Title":.Basic_information.Title_of_the_study_Brief_title,"Scientific_Title":.Official_scientific_title_of_the_study,"study_type":.Base.Study_type,"date_of_first_enrollment":"","RecruitmentStatus":.Recruitment_status,"completionDate":.Progress.Date_analysis_concluded, "PrimarySponsors":{"name": [.Sponsor.Institute],   "person": [],"address":[]},"SecondarySponsors":{"name": [],   "person": [],"address":[]},"Contact":[],"registry": "JPRN", "source_json": tojson}' ${f} >> ${html_dir}output/json/utdm_json.json

done

  if [ -d ${html_dir}jprn ]; then
        rm -rf ${html_dir}jprn
  fi

#########################   IRCTN    #####################################
find ${html_dir}irctn/studies/json/ -type f -name "*.json"  | while read f
do
jq -c -R 'fromjson? | {"trialid":.IRCT_RegistrationNumber,"secondary_id":.Secondary_Ids,"Date_of_Registration":.Registration_timing,"Public_Title":.Public_title,"Scientific_Title":.Scientific_title,"study_type":"","date_of_first_enrollment":.Expected_Recruitment_start_Date,"RecruitmentStatus":.Recruitment_status,"completionDate":"","PrimarySponsors":{"name": [.Sponsors__or_FundingSources | .[].Name_of_organization_or_entity ],"person": [.Sponsors__or_FundingSources | .[].Full_name_of_responsible_person ]} ,"SecondarySponsors":{"name": [],   "person": [],"address":[]}, "Contact":[],"registry": "IRCT", "source_json": tojson}' ${f} >> ${html_dir}output/json/utdm_json.json
done

  if [ -d ${html_dir}irctn ]; then
        rm -rf ${html_dir}irctn
  fi

#########################   CHICTRN    #####################################

find ${html_dir}chictr/studies/json/ -type f -name "*.json"  | while read f
do

jq -c   '{"trialid":.Registration_number,"secondary_id":[.The_registration_number_of_the_Partner_Registry_or_other_register],"Date_of_Registration":.Date_of_Registration,"Public_Title":.Public_title,"Scientific_Title":.Scientific_title,"study_type":"","date_of_first_enrollment":"","RecruitmentStatus":.Recruiting_status,"completionDate":"","PrimarySponsors":{"name": [.Sources_of_funding],   "person": [],"address":[]}, "SecondarySponsors":{"name": [],   "person": [],"address":[]},"Contact":[],"registry": "ChiCTR", "source_json": tojson }' ${f} >> ${html_dir}output/json/utdm_json.json

done

 if [ -d ${html_dir}chictr ]; then
        rm -rf ${html_dir}chictr
 fi

#########################   ACTRN    #####################################

find ${html_dir}actrn/studies/json/ -type f -name "*.json"  | while read f
do

jq -c   '{"trialid":.trial_id,"secondary_id":.secondary_id,"Date_of_Registration":.date_registered,"Public_Title":.public_title,"Scientific_Title":.scientific_title,"study_type":.Study_Type,"date_of_first_enrollment":"","RecruitmentStatus":.Recruitment_status,"completionDate":"" ,"PrimarySponsors":{"name": [],   "person": [],"address":[]},"SecondarySponsors":{"name": [.SecondarySponsors.Name],   "person": [],"address":[.SecondarySponsors.Address]}, "Contact":[],"registry": "ACTRN", "source_json": tojson}' ${f} >> ${html_dir}output/json/utdm_json.json

done

  if [ -d ${html_dir}actrn ]; then
        rm -rf ${html_dir}actrn
  fi

#########################   EUCTRN    #####################################
find ${html_dir}euctrn/studies/json/p_y* -type f -name "*.json"  | while read f
do

jq -c -R 'fromjson? | {"trialid":.eudract_number,"secondary_id":[.sponsors_protocol_code_number],"Date_of_Registration":.date_on_which_this_record_was_first_entered_in_the_eudract_database,"Public_Title":.full_title_of_the_trial,"Scientific_Title":.name_or_abbreviated_title_of_the_trial_where_available,"study_type":.clinical_trial_type,"date_of_first_enrollment":"","RecruitmentStatus":.trial_status,"completionDate":"" ,"PrimarySponsors":{"name": [],   "person": [],"address":[]},"SecondarySponsors":{"name": [],   "person": [],"address":[]}, "Contact":[], "registry": "EUCTRN", "source_json": tojson}' ${f} >> ${html_dir}output/json/utdm_json.json

done


#########################   BRTR    #####################################
find ${html_dir}brtr/studies/json/ -type f -name "*.json"  | while read f
do

jq -c -R 'fromjson? | {"trialid":.main.trial_id,"secondary_id":[.secondary_ids.secondary_id],"Date_of_Registration":.main.date_registration,"Public_Title":.main.public_title,"Scientific_Title":.main.scientific_title,"study_type":.main.study_type,"date_of_first_enrollment":.main.date_enrolment,"RecruitmentStatus":.main.recruitment_status,"completionDate":"" ,"PrimarySponsors":{"name": [.main.primary_sponsor],   "person": [],"address":[]},"SecondarySponsors":{"name": [.secondary_sponsor.sponsor_name],   "person": [],"address":[]}, "Contact":[], "registry": "BRTR", "source_json": tojson}' ${f} >> ${html_dir}output/json/utdm_json.json

done

  if [ -d ${html_dir}brtr ]; then
        rm -rf ${html_dir}brtr
  fi

#########################   NTR   #####################################
find ${html_dir}ntr/studies/json/ -type f -name "*.json"  | while read f
do

jq -c -R 'fromjson? | {"trialid":.NTR_Number,"secondary_id":[.secondary_ids],"Date_of_Registration":.Date_Registered_NTR,"Public_Title":.Public_Title,"Scientific_Title":.scientific_title,"study_type":.study_type,"date_of_first_enrollment":.date_enrolment,"RecruitmentStatus":.status,"completionDate":"" ,"PrimarySponsors":{"name": [],   "person": [],"address":[]}, "SecondarySponsors":{"name": [],   "person": [],"address":[]},"Contact":[], "registry": "NTR", "source_json": tojson}' ${f} >> ${html_dir}output/json/utdm_json.json

done

  if [ -d ${html_dir}ntr ]; then
        rm -rf ${html_dir}ntr
  fi


#########################   CUBA   #####################################
find ${html_dir}cubct/studies/json/ -type f -name "*.json"  | while read f
do

jq -c -R 'fromjson? | {"trialid":.UniqueIDNumber,"secondary_id":.SecondaryIDs,"Date_of_Registration":.DateOfRegistrationinPrimaryRegisrty,"Public_Title":.Acronym_of_Public_Title,"Scientific_Title":.Acronym_Of_Scientific_Title,"TypeStudy":.study_type,"date_of_first_enrollment":.DateoffirstEnrollment,"RecruitmentStatus":.RecruitmentStatus,"completionDate":"" ,"PrimarySponsors":{"name": .PrimarySponsors,   "person": [],"address":[]}, "SecondarySponsors":{"name": .SecondarySponsors,   "person": [],"address":[]},"Contact":[], "registry": "CUBA", "source_json": tojson}' ${f} >> ${html_dir}output/json/utdm_json.json

done

  if [ -d ${html_dir}cubct ]; then
        rm -rf ${html_dir}cubct
  fi

##########################   PERCTR   #####################################
find ${html_dir}perct/studies/json/ -type f -name "*.json"  | while read f
do

jq -c -R 'fromjson? | {"trialid":.main.trial_id,"secondary_id":[.secondary_ids[].secondary_id],"Date_of_Registration":.main.date_registration,"Public_Title":.main.public_title,"Scientific_Title":.main.scientific_title,"study_type":.main.study_type,"date_of_first_enrollment":.main.date_enrolment,"RecruitmentStatus":.main.recruitment_status,"completionDate":"" ,"PrimarySponsors":{"name": [.main.primary_sponsor],   "person": [],"address":[]},"SecondarySponsors":{"name": [.secondary_sponsor[].sponsor_name],   "person": [],"address":[]}, "Contact":[], "registry": "PERCTR", "source_json": tojson}' ${f} >> ${html_dir}output/json/utdm_json.json

done

  if [ -d ${html_dir}perct ]; then
        rm -rf ${html_dir}perct
  fi

#########################   SLCTR   #####################################
find ${html_dir}slctr/studies/json/ -type f -name "*.json"  | while read f
do

jq -c -R 'fromjson? | {"trialid":.slctr_registration_number,"secondary_id":[.SecondaryId],"Date_of_Registration":.DateOfRegistration,"Public_Title":.PublicTitleOftrial,"Scientific_Title":.ScientificTitleOftrial,"TypeStudy":.TypeOfStudy,"date_of_first_enrollment":"","RecruitmentStatus":.RecruitmentStatus,"completionDate":"" ,"PrimarySponsors":{"name": [],   "person": [],"address":[]}, "SecondarySponsors":{"name": [],   "person": [],"address":[]},"Contact":[], "registry": "SLCTR", "source_json": tojson}' ${f} >> ${html_dir}output/json/utdm_json.json

done

  if [ -d ${html_dir}slctr ]; then
        rm -rf ${html_dir}slctr
  fi


#########################   TCTR   #####################################
# find ${html_dir}tctr/studies/json/ -type f -name "*.json"  | while read f
# do

# jq -c -R 'fromjson? | {"trialid":.main.trial_id,"secondary_id":[.secondary_ids[].secondary_id],"Date_of_Registration":.main.date_registration,"Public_Title":.main.public_title,"Scientific_Title":.main.scientific_title,"study_type":.main.study_type,"date_of_first_enrollment":.main.date_enrolment,"RecruitmentStatus":.main.recruitment_status,"completionDate":"" ,"PrimarySponsors":{"name": [.main.primary_sponsor],   "person": [],"address":[]},"SecondarySponsors":{"name": [.secondary_sponsor[].sponsor_name],   "person": [],"address":[]}, "Contact":[], "registry": "TCTR", "source_json": tojson}' ${f} >> ${html_dir}output/json/utdm_json.json

# done


  # if [ -d ${html_dir}tctr ]; then
    #    rm -rf ${html_dir}tctr
  # fi

#########################   ISRCTN   #####################################
find ${html_dir}isrctn/studies/json/ -type f -name "*.json"  | while read f
do

jq -c -R 'fromjson? | {"trialid":.IRCTN_NUMBER,"secondary_id":[.SecondaryIds],"Date_of_Registration":.dateApplied,"Public_Title":.Acronym,"Scientific_Title":.ScientificTitle,"study_type":.Type,"date_of_first_enrollment":"","RecruitmentStatus":.RecruitmentStatus,"completionDate":"" ,"PrimarySponsors":{"name": [.SponsorDetails],   "person": [],"address":[]},"SecondarySponsors":{"name": [],   "person": [],"address":[]}, "Contact":[], "registry": "ISRCTN", "source_json": tojson}' ${f} >> ${html_dir}output/json/utdm_json.json

done


  if [ -d ${html_dir}isrctn ]; then
        rm -rf ${html_dir}isrctn
  fi

#########################   CRISTR   #####################################
find ${html_dir}cristr/studies/json/ -type f -name "*.json"  | while read f
do

jq -c -R 'fromjson? | {"trialid":.cris_registration_number,"secondary_id":[.Secondary_Id],"Date_of_Registration":"","Public_Title":.public_or_brief_title,"Scientific_Title":.scientific_title,"study_type":.study_type,"date_of_first_enrollment":"","RecruitmentStatus":.sites[].recruitment_status,"completionDate":"" ,"PrimarySponsors":{"name": [.sponsor_organisation[].organization_name],   "person": [],"address":[]},"SecondarySponsors":{"name": [],   "person": [],"address":[]}, "Contact":[], "registry": "CRISTR", "source_json": tojson}' ${f} >> ${html_dir}output/json/utdm_json.json

done


  if [ -d ${html_dir}cristr ]; then
        rm -rf ${html_dir}cristr
  fi


aws s3 sync ${html_dir}/output/ ${s3_utdm_bucket}  --delete
