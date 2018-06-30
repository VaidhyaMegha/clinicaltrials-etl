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
    cat ${html_dir}/studies/${g}.html  | pup 'table tr td[colspan="1"]  json{}' | jq -c  ' [.[].text] | {
      "Receipt_No.": "'${g}'",
      "Basic_information": {
        "Official_scientific_title_of_the_study": .[0],
        "Title_of_the_study_(Brief_title)": .[1],
        "Region": .[2]
      },
      "Condition": {
        "Condition": .[3],
        "Classification_by_specialty": .[4],
        "Classification_by_malignancy": .[5],
        "Genomic_information": .[6]
      },
      "Objectives": {
        "Narrative_objectives1": .[7],
        "Basic_objectives2": .[8],
        "Basic_objectives_-Others": .[9],
        "Trial_characteristics_1": .[10],
        "Trial_characteristics_2": .[11],
        "Developmental_phase": .[12]
      },
      "Assessment": {
        "Primary_outcomes": .[13],
        "Key_secondary_outcomes": .[14]
      },
      "Base": {
        "Study_type": .[15]
      },
      "Study_design": {
        "Basic_design": .[16],
        "Randomization": .[17],
        "Randomization_unit": .[18],
        "Blinding": .[19],
        "Control": .[20],
        "Stratification": .[21],
        "Dynamic_allocation": .[22],
        "Institution_consideration": .[23],
        "Blocking": .[24],
        "Concealment": .[25]
      },
      "Intervention": {
        "No._of_arms": .[26],
        "Purpose_of_intervention": .[27],
        "Type_of_intervention": .[28],
        "Interventions/Control_1": .[29],
        "Interventions/Control_2": .[30],
        "Interventions/Control_3": .[31],
        "Interventions/Control_4": .[32],
        "Interventions/Control_5": .[33],
        "Interventions/Control_6": .[34],
        "Interventions/Control_7": .[35],
        "Interventions/Control_8": .[36],
        "Interventions/Control_9": .[37],
        "Interventions/Control_10": .[38]
      },
      "Eligibility": {
        "Age-lower_limit": .[39],
        "Age-upper_limit": .[40],
        "Gender": .[41],
        "Key_inclusion_criteria": .[42],
        "Key_exclusion_criteria": .[43],
        "Target_sample_size": .[44]
      },
      "Research_Contact_Person": {
        "Name_of_lead_principal_investigator": .[45],
        "Organization": .[46],
        "Division_name": .[47],
        "Address": .[48],
        "TEL": .[49],
        "Email": .[50]
      },
      "Public_Contact_Person": {
        "Name_of_contact_person": .[51],
        "Organization": .[52],
        "Division_name": .[53],
        "Address": .[54],
        "TEL": .[55],
        "Homepage_URL": .[56],
        "Email": .[57]
      },
      "Sponsor": {
        "Institute": .[58],
        "Department": .[59]
      },
      "Funding_Source": {
        "Organization": .[60],
        "Division": .[61],
        "Category_of_Funding_Organization": .[62],
        "Nationality_of_Funding_Organization": .[63]
      },
      "Other_related_Organizations": {
        "Co-sponsor": .[64],
        "Name_of_secondary_funｄer(s)": .[65]
      },
      "Secondary_IDs": {
        "Secondary_IDs": .[66],
        "Study_ID_1": .[67],
        "Org._issuing_International_ID_1": .[68],
        "Study_ID_2": .[69],
        "Org._issuing_International_ID_2": .[70],
        "IND_to_MHLW": .[71]
      },
      "Institutions": {
        "Institutions": .[72]
      },
      "Progress": {
        "Date_of_disclosure_of_the_study_information": .[73],
        "Recruitment_status": .[74],
        "Date_of_protocol_fixation": .[75],
        "Anticipated_trial_start_date": .[76],
        "Last_follow-up_date": .[77],
        "Date_of_closure_to_data_entry": .[78],
        "Date_trial_data_considered_complete": .[79],
        "Date_analysis_concluded": .[80]
      },
      "Related_information": {
        "URL_releasing_protocol": .[81],
        "Publication_of_results": .[82],
        "URL_releasing_results": .[83],
        "Results": .[84],
        "Other_related_information": .[85]
      },
      "Management_information": {
        "Registered_date": .[86],
        "Last_modified_on": .[87]
      },
      "Link_to_view_the_page": {
        "URL(English)": .[88]
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
else
    cat ${html_dir}/*.html | grep -oE "ctr_view.cgi\?recptno=[^\"]*" | while read f
    do

        download_and_analyse_trial ${f} ${html_dir}/studies/json
    done
fi
