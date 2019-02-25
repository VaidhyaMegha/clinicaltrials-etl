#!/usr/bin/env bash
set -ex

html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/irctn-adapter/'}
context_dir=${4:-'/usr/local/dataintegration'}
prefix_url="http://www.irct.ir/search/result?query=*&filters=[]"
suffix_url="&page="
download_trial_url="http://www.irct.ir/trial/"

 function download_main_index(){
    wget  -q ${prefix_url}${suffix_url}"1" \
         -O ${html_dir}/1.html  || true
}

function download_index_page(){
    wget -q ${prefix_url}${suffix_url}${1} -O ${html_dir}/${1}.html  || true
}

function download_and_analyse_trial() {

 wget -q ${download_trial_url}${1} -O ${html_dir}/studies/${1}.html  || true

  sed "s/&quot;/ /g" ${html_dir}/studies/${1}.html > ${1}.tmp
  tr '\n' ' ' < ${1}.tmp > ${3}.html
  rm ${1}.tmp

 cat ${3}.html | pup 'div.section json{}' | jq -c '{ "Protocol_Summary":.[0].children[1].children[0].children[1].children[0].text,
"IRCT_RegistrationNumber":.[1].children[1].children[0].children[3].children[0].children[0].children[1].text,
"Registration date":.[1].children[1].children[0].children[3].children[0].children[1].children[1].text,
"Registration_timing":.[1].children[1].children[0].children[3].children[0].children[2].children[1].text,
"Last_Update":.[1].children[1].children[0].children[3].children[0].children[4].children[1].text,
"UpdateCount":.[1].children[1].children[0].children[3].children[0].children[5].children[1].text,
"Registrant_Name":.[1].children[1].children[1].children[1].children[0].children[0].children[1].text,
"Registrant_Name_Of_Organization_or_Entity":.[1].children[1].children[1].children[1].children[0].children[1].children[1].text,
"Country":.[1].children[1].children[1].children[1].children[0].children[2].children[1].text,
"Phone":.[1].children[1].children[1].children[1].children[0].children[3].children[1].text,
"Email":.[1].children[1].children[1].children[1].children[0].children[4].children[1].text, "Recruitment_status":.[1].children[1].children[2].children[1].children[0].text,
"Funding_source":.[1].children[1].children[2].children[3].children[0].text,
"Expected_Recruitment_start_Date":.[1].children[1].children[4].children[1].text,
"Expected_Recruitment_End_Date":.[1].children[1].children[4].children[3].text,
"Actual_recruitment_start_date":.[1].children[1].children[4].children[5].children[0].text,
"Actual_recruitment_End_date":.[1].children[1].children[4].children[7].children[0].text,
"Scientific_title":.[1].children[1].children[5].children[1].text,
"Public_title":.[1].children[1].children[6].children[1].text,
"Purpose":.[1].children[1].children[6].children[3].text,
"InclusionCriteria":.[1].children[1].children[6].children[5].children[1].text,
"ExclusionCriteria":.[1].children[1].children[6].children[5].children[3].text,
"Age":.[1].children[1].children[6].children[7].text,
"Gender":.[1].children[1].children[6].children[9].text,
"phase":.[1].children[1].children[7].children[1].text,
"Groups_that_have_been_masked":.[1].children[1].children[7].children[3].children[0].text,
"Target_sample_size":.[1].children[1].children[7].children[5].children[0].children[0].text,
"Randomization_investigator_s_opinion":.[1].children[1].children[7].children[7].text,
"Randomization_description":.[1].children[1].children[7].children[9].text,
"Blinding_investigator_s_opinion":.[1].children[1].children[7].children[11].text,
"Blinding_description":.[1].children[1].children[7].children[13].text,
"Placebo":.[1].children[1].children[7].children[15].text,
"Assignment":.[1].children[1].children[7].children[17].text,
"Other_design-features":.[1].children[1].children[7].children[19].text,
"Secondary_Ids":[[{"Registry_name":.[2].children[1].children[].children[1].children[1].text | select (.!=null)}],[{"Secondary_trial_Id":.[2].children[1].children[].children[1].children[3].text| select(.!=null)}],[{"Registration_date":.[2].children[1].children[].children[1].children[5].text| select(.!=null)}]]| transpose| map(add),
"Health_Conditions_studies":[[{"Description_of_health_condition_studied":.[4].children[1].children[].children[1].children[1].text | select (.!=null)}],[{"ICD_10_code":.[4].children[1].children[].children[1].children[3].text| select(.!=null)}],[{"ICD_10_code_description":.[4].children[1].children[].children[1].children[5].text| select(.!=null)}]]| transpose| map(add),
"Primary_outcomes":[[{"Description":.[5].children[1].children[].children[1].children[1].text | select (.!=null)}],[{"Timepoint":.[5].children[1].children[].children[1].children[3].text| select(.!=null)}],[{"Method_of_measurement":.[5].children[1].children[].children[1].children[5].text| select(.!=null)}]]| transpose| map(add), "Secondary_outcomes":[[{"Description":.[6].children[1].children[].children[1].children[1].text | select (.!=null)}],[{"Timepoint":.[6].children[1].children[].children[1].children[3].text| select(.!=null)}],[{"Method_of_measurement":.[6].children[1].children[].children[1].children[5].text| select(.!=null)}]]| transpose| map(add),
"Intervention_groups":[[{"Description":.[7].children[1].children[].children[1].children[1].text | select (.!=null)}],[{"Category":.[7].children[1].children[].children[1].children[3].text| select(.!=null)}]]| transpose| map(add), "Recruitment_centers":[[{"Name_of_recruitment_center":.[8].children[1].children[].children[1].children[1].children[0].children[0].children[1].text | select (.!=null)}],[{"Full_name_of_responsible_person":.[8].children[1].children[].children[1].children[1].children[0].children[2].children[1].text| select(.!=null)}],[{"Street_Address":.[8].children[1].children[].children[1].children[1].children[0].children[4].children[1].text| select(.!=null)}],[{"City":.[8].children[1].children[].children[1].children[1].children[0].children[6].children[1].text| select(.!=null)}],[{"Country":.[8].children[1].children[].children[1].children[1].children[0].children[8].children[1].text| select(.!=null)}]]| transpose| map(add),
"Sponsors__or_FundingSources":[[{"Name_of_organization_or_entity":.[9].children[1].children[].children[1].children[1].children[0].children[0].children[1].text | select (.!=null)}],[{"Full_name_of_responsible_person":.[9].children[1].children[].children[1].children[1].children[0].children[2].children[1].text | select (.!=null)}],[{"Street_address":.[9].children[1].children[].children[1].children[1].children[0].children[4].children[1].text | select (.!=null)}],[{"City":.[9].children[1].children[].children[1].children[1].children[0].children[6].children[1].text | select (.!=null)}],[{"City":.[9].children[1].children[].children[1].children[1].children[0].children[8].children[1].text | select (.!=null)}],[{"Country":.[9].children[1].children[].children[1].children[1].children[0].children[10].children[1].text | select (.!=null)}],[{"Grant_name":.[9].children[1].children[].children[1].children[7].text}],[{"Grant_name":.[9].children[1].children[].children[1].children[3].text}],[{"Grant_code_Reference_number":.[9].children[1].children[].children[1].children[5].text}],[{"Is_the_source_of_funding_the_same_sponsor_organization_entity?":.[9].children[1].children[].children[1].children[7].text}],[{"Title_of_funding_source":.[9].children[1].children[].children[1].children[9].text}],[{"Proportion_provided_by_this_source":.[9].children[1].children[].children[1].children[11].text}],[{"Public_or_private_sector":.[9].children[1].children[].children[1].children[13].text}],[{"Domestic_or_foreign_origin":.[9].children[1].children[].children[1].children[15].text}],[{"Category_of_foreign_source_of_funding":.[9].children[1].children[].children[1].children[17].text}],[{"Country_of_origin":.[9].children[1].children[].children[1].children[19].text}],[{"Type_of_organization_providing_the_funding":.[9].children[1].children[].children[1].children[21].text}] ]| transpose | map(add), "EthicsCommitte":[[{"Name_Of_Ethics_committee":.[3].children[1].children[].children[1].children[1].children[0].children[0].children[1].text }], [{"Street_address":.[3].children[1].children[].children[1].children[1].children[0].children[2].children[1].text | select (.!=null)}],[{"City":.[3].children[1].children[].children[1].children[1].children[0].children[4].children[1].text | select (.!=null)}],[{"Country":.[3].children[1].children[].children[1].children[1].children[0].children[6].children[1].text | select (.!=null)}],[{"Approval_date":.[3].children[1].children[].children[1].children[3].text | select (.!=null)}],[{"Ethics_committee_reference_number":.[3].children[1].children[].children[1].children[5].text | select (.!=null)}]]| transpose | map(add) ,
"PersonResponsibleForGeneralQueries":[[{"Name_of_organization_or_entity":.[10].children[1].children[].children[1].children[0].children[2].children[1].text }], [{"Full_name_of_responsible_person":.[10].children[1].children[].children[1].children[0].children[4].children[1].text  }],[{"Position":.[10].children[1].children[].children[1].children[0].children[6].children[1].text  }],[{"Other_areas_of_specialty_work": .[10].children[1].children[].children[1].children[0].children[8].children[1].text  }],  [{"Street_address":.[10].children[1].children[].children[1].children[0].children[10].children[1].text  }],[{"City":.[10].children[1].children[].children[1].children[0].children[12].children[1].text  }],[{"Country": .[10].children[1].children[].children[1].children[0].children[14].children[1].text  }],[{"PostalCode":.[10].children[1].children[].children[1].children[0].children[16].children[1].text  }],[{"Phone":.[10].children[1].children[].children[1].children[0].children[18].children[1].text  }],[{"Fax":.[10].children[1].children[].children[1].children[0].children[20].children[1].text  }],[{"Email":.[10].children[1].children[].children[1].children[0].children[22].children[1].text  }]]| transpose| map(add),
"PersonResponsibleForScientificQueries":[[{"Name_of_organization_or_entity":.[11].children[1].children[].children[1].children[0].children[2].children[1].text }], [{"Full_name_of_responsible_person":.[11].children[1].children[].children[1].children[0].children[4].children[1].text  }],[{"Position":.[11].children[1].children[].children[1].children[0].children[6].children[1].text  }],[{"Other_areas_of_specialty_work": .[11].children[1].children[].children[1].children[0].children[8].children[1].text  }],  [{"Street_address":.[11].children[1].children[].children[1].children[0].children[10].children[1].text  }],[{"City":.[11].children[1].children[].children[1].children[0].children[12].children[1].text  }],[{"Country": .[11].children[1].children[].children[1].children[0].children[14].children[1].text  }],[{"PostalCode":.[11].children[1].children[].children[1].children[0].children[16].children[1].text  }],[{"Phone":.[11].children[1].children[].children[1].children[0].children[18].children[1].text  }],[{"Fax":.[11].children[1].children[].children[1].children[0].children[20].children[1].text  }],[{"Email":.[11].children[1].children[].children[1].children[0].children[22].children[1].text  }]]| transpose| map(add),
"PersonResponsibleForUpdatingData":[[{"Name_of_organization_or_entity":.[12].children[1].children[].children[1].children[0].children[2].children[1].text }], [{"Full_name_of_responsible_person":.[12].children[1].children[].children[1].children[0].children[4].children[1].text  }],[{"Position":.[12].children[1].children[].children[1].children[0].children[6].children[1].text  }],[{"Other_areas_of_specialty_work": .[12].children[1].children[].children[1].children[0].children[8].children[1].text  }],  [{"Street_address":.[12].children[1].children[].children[1].children[0].children[10].children[1].text  }],[{"City":.[12].children[1].children[].children[1].children[0].children[12].children[1].text  }],[{"Country": .[12].children[1].children[].children[1].children[0].children[14].children[1].text  }],[{"PostalCode":.[12].children[1].children[].children[1].children[0].children[16].children[1].text  }],[{"Phone":.[12].children[1].children[].children[1].children[0].children[18].children[1].text  }],[{"Fax":.[12].children[1].children[].children[1].children[0].children[20].children[1].text  }],[{"Email":.[12].children[1].children[].children[1].children[0].children[22].children[1].text  }]]| transpose| map(add)}'  >> ${2}/studies.json
}

pushd ${context_dir}


source ~/.gvm/scripts/gvm
gvm use "go1.9"

if [[ ${download} == 'yes' ]]; then

    if [ -d ${html_dir}/studies ]; then
        rm -rf ${html_dir}/studies
    fi

   mkdir -p ${html_dir}/studies
   mkdir ${html_dir}/studies/json
   mkdir ${html_dir}/studies/analysis

    download_main_index

    NUM_OF_PAGES=`cat ${html_dir}/1.html | grep -Eo '<a href="/search/*[^>]*>' |grep -oE '[0-9]*' | sort -g | tail -n 1`

    for (( i=2; i<=${NUM_OF_PAGES}; i++ ))
    do
        download_index_page ${i}
    done

    cat ${html_dir}/*.html | grep -Eo 'result-title"><a href="\/trial\/[0-9]*' | grep -oE "[0-9]*" | while read f
    do
        download_and_analyse_trial ${f} ${html_dir}/studies/json ${html_dir}/studies/analysis/${f}
    done

    aws s3 sync  ${html_dir}/studies/ ${s3_bucket} --delete

else
    cat ${html_dir}/*.html | grep -Eo 'result-title"><a href="\/trial\/[0-9]*' | grep -oE "[0-9]*" | while read f
    do
        download_and_analyse_trial ${f} ${html_dir}/studies/json ${html_dir}/studies/analysis/${f}
    done
fi
popd
