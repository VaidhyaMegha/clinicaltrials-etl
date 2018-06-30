#!/usr/bin/env bash
set -ex

html_dir=${1}
download=${2:-'no'}
prefix_url="https://upload.umin.ac.jp/cgi-open-bin/ctr_e/index.cgi"
suffix_url="?sort=03&isicdr=1&page="


function download_main_index(){
    wget  -q ${prefix_url}${suffix_url}"1" \
         -O ${html_dir}/index.html  || true
}

function download_index_page(){
    wget -q ${prefix_url}${suffix_url}${1} -O ${html_dir}/${1}.html  || true
}

function download_and_analyse_trial(){
    g=${1//ctr_view.cgi?recptno=/}
    wget -q "https://upload.umin.ac.jp/cgi-open-bin/ctr_e/"${1} -O ${html_dir}/studies/${g}.html  || true
    cat ${html_dir}/studies/${g}.html  | pup 'table tr td table:nth-of-type(2) tr td:nth-of-type(2) json{}' | jq -c  '{
      "Basic_information": {
        "Official_scientific_title_of_the_study": "",
        "Title_of_the_study_(Brief_title)": "",
        "Region": ""
      },
      "Condition": {
        "Condition": "",
        "Classification_by_specialty": "",
        "Classification_by_malignancy": "",
        "Genomic_information": ""
      },
      "Objectives": {
        "Narrative_objectives1": "",
        "Basic_objectives2": "",
        "Basic_objectives_-Others": "",
        "Trial_characteristics_1": "",
        "Trial_characteristics_2": "",
        "Developmental_phase": ""
      },
      "Assessment": {
        "Primary_outcomes": "",
        "Key_secondary_outcomes": ""
      },
      "Base": {
        "Study_type": ""
      },
      "Study_design": {
        "Basic_design": "",
        "Randomization": "",
        "Randomization_unit": "",
        "Blinding": "",
        "Control": "",
        "Stratification": "",
        "Dynamic_allocation": "",
        "Institution_consideration": "",
        "Blocking": "",
        "Concealment": ""
      },
      "Intervention": {
        "No._of_arms": "",
        "Purpose_of_intervention": "",
        "Type_of_intervention": "",
        "Interventions/Control_1": "",
        "Interventions/Control_2": "",
        "Interventions/Control_3": "",
        "Interventions/Control_4": "",
        "Interventions/Control_5": "",
        "Interventions/Control_6": "",
        "Interventions/Control_7": "",
        "Interventions/Control_8": "",
        "Interventions/Control_9": "",
        "Interventions/Control_10": ""
      },
      "Eligibility": {
        "Age-lower_limit": "",
        "Age-upper_limit": "",
        "Gender": "",
        "Key_inclusion_criteria": "",
        "Key_exclusion_criteria": "",
        "Target_sample_size": ""
      },
      "Research_Contact_Person": {
        "Name_of_lead_principal_investigator": "",
        "Organization": "",
        "Division_name": "",
        "Address": "",
        "TEL": "",
        "Email": ""
      },
      "Public_Contact_Person": {
        "Name_of_contact_person": "",
        "Organization": "",
        "Division_name": "",
        "Address": "",
        "TEL": "",
        "Homepage_URL": "",
        "Email": ""
      },
      "Sponsor": {
        "Institute": "",
        "Department": ""
      },
      "Funding_Source": {
        "Organization": "",
        "Division": "",
        "Category_of_Funding_Organization": "",
        "Nationality_of_Funding_Organization": ""
      },
      "Other_related_Organizations": {
        "Co-sponsor": "",
        "Name_of_secondary_funｄer(s)": ""
      },
      "Secondary_IDs": {
        "Secondary_IDs": "",
        "Study_ID_1": "",
        "Org._issuing_International_ID_1": "",
        "Study_ID_2": "",
        "Org._issuing_International_ID_2": "",
        "IND_to_MHLW": ""
      },
      "Institutions": {
        "Institutions": ""
      },
      "Progress": {
        "Date_of_disclosure_of_the_study_information": "",
        "Recruitment_status": "",
        "Date_of_protocol_fixation": "",
        "Anticipated_trial_start_date": "",
        "Last_follow-up_date": "",
        "Date_of_closure_to_data_entry": "",
        "Date_trial_data_considered_complete": "",
        "Date_analysis_concluded": ""
      },
      "Related_information": {
        "URL_releasing_protocol": "",
        "Publication_of_results": "",
        "URL_releasing_results": "",
        "Results": "",
        "Other_related_information": ""
      },
      "Management_information": {
        "Registered_date": "",
        "Last_modified_on": ""
      },
      "Link_to_view_the_page": {
        "URL(English)": ""
      }
    }' >> ${2}/studies.json
}

if [[ ${download} == 'yes' ]]; then

    if [ -d ${html_dir} ]; then
        rm -rf ${html_dir}
    fi

    mkdir -p ${html_dir}/studies
    mkdir ${html_dir}/studies/json
    mkdir ${html_dir}/studies/analysis

    download_main_index

    cat ${html_dir}/index.html | pup 'table tr td a font[color="#3300FF"] json{}' | jq '.[].text' | while read f
    do
            g=${f//\"/}
            download_index_page ${g}
    done

    cat ${html_dir}/*.html | grep -oE "ctr_view.cgi\?recptno=[^\"]*" | while read f
    do

        download_and_analyse_trial ${f} ${html_dir}/studies/json
    done
fi
