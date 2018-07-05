#!/usr/bin/env bash
set -ex
set +H


html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/irct-adapter'}
context_dir=${4:-'/usr/local/dataintegration'}


function analyse_file() {
    sed "s/&quot;/ /g" ${1} > ${1}.tmp
    tr '\n' ' ' < ${1}.tmp > ${2}
}

function gen_json() {
 cat ${1}  | pup 'div.section json{}' | jq '{ "Protocol_Summary":.[0].children[1].children[0].children[1].children[0].text,"IRCT_RegistrationNumber":.[1].children[1].children[0].children[3].children[0].children[0].children[1].text,"Registration date":.[1].children[1].children[0].children[3].children[0].children[1].children[1].text,"Registration_timing":.[1].children[1].children[0].children[3].children[0].children[2].children[1].text,"Last_Update":.[1].children[1].children[0].children[3].children[0].children[4].children[1].text,"Update":.[1].children[1].children[0].children[3].children[0].children[5].children[1].text,"Registrant_Name":.[1].children[1].children[1].children[1].children[0].children[0].children[1].text,"Registrant_Name_Of_Organization_or_Entity":.[1].children[1].children[1].children[1].children[0].children[1].children[1].text,"Country":.[1].children[1].children[1].children[1].children[0].children[2].children[1].text,"Phone":.[1].children[1].children[1].children[1].children[0].children[3].children[1].text,"Email":.[1].children[1].children[1].children[1].children[0].children[4].children[1].text, "Recruitment_status":.[1].children[1].children[2].children[1].children[0].text,"Funding_source":.[1].children[1].children[2].children[3].children[0].text,"Expected_Recruitment_start_Date":.[1].children[1].children[4].children[1].text,"Expected_Recruitment_End_Date":.[1].children[1].children[4].children[3].text,"Actual_recruitment_start_date":.[1].children[1].children[4].children[5].children[0].text,"Actual_recruitment_End_date":.[1].children[1].children[4].children[7].children[0].text,"Scientific_title":.[1].children[1].children[5].children[1].text,"Public_title":.[1].children[1].children[6].children[1].text,"Purpose":.[1].children[1].children[6].children[3].text,"Inclusion_or_Exclusion_Criteria":.[1].children[1].children[6].children[5].text,"Age":.[1].children[1].children[6].children[7].text,"Gender":.[1].children[1].children[6].children[9].text,"phase":.[1].children[1].children[7].children[1].text,"Groups_that_have_been_masked":.[1].children[1].children[7].children[3].children[0].text,"Target_sample_size":.[1].children[1].children[7].children[5].children[0].children[0].text,"Randomization_investigator_s_opinion":.[1].children[1].children[7].children[7].text,"Randomization_description":.[1].children[1].children[7].children[9].text,"Blinding_investigator_s_opinion":.[1].children[1].children[7].children[11].text,"Blinding_description":.[1].children[1].children[7].children[13].text,"Placebo":.[1].children[1].children[7].children[15].text,"Assignment":.[1].children[1].children[7].children[17].text,"Other_design-features":.[1].children[1].children[7].children[19].text,"Secondary_Ids":[[{"Registry_name":.[2].children[1].children[].children[].children[1].text | select (.!=null)}],[{"Secondary_trial_Id":.[2].children[1].children[].children[].children[3].text| select(.!=null)}],[{"Registration_date":.[2].children[1].children[].children[].children[5].text| select(.!=null)}]]| transpose| map(add),"Health_Conditions_studies":[[{"Description_of_health_condition_studied":.[4].children[1].children[].children[].children[1].text | select (.!=null)}],[{"ICD_10_code":.[4].children[1].children[].children[].children[3].text| select(.!=null)}],[{"ICD_10_code_description":.[4].children[1].children[].children[].children[5].text| select(.!=null)}]]| transpose| map(add),
"Primary_outcomes":[[{"Description":.[5].children[1].children[].children[].children[1].text | select (.!=null)}],[{"Timepoint":.[5].children[1].children[].children[].children[3].text| select(.!=null)}],[{"Method_of_measurement":.[5].children[1].children[].children[].children[5].text| select(.!=null)}]]| transpose| map(add), "Secondary_outcomes":[[{"Description":.[6].children[1].children[].children[].children[1].text | select (.!=null)}],[{"Timepoint":.[6].children[1].children[].children[].children[3].text| select(.!=null)}],[{"Method_of_measurement":.[6].children[1].children[].children[].children[5].text| select(.!=null)}]]| transpose| map(add),"Intervention_groups":[[{"Description":.[7].children[1].children[].children[].children[1].text | select (.!=null)}],[{"Category":.[7].children[1].children[].children[].children[3].text| select(.!=null)}]]| transpose| map(add), "Recruitment_centers":[[{"Name_of_recruitment_center":.[8].children[1].children[].children[1].children[1].children[0].children[0].children[1].text | select (.!=null)}],[{"Full_name_of_responsible_person":.[8].children[1].children[].children[1].children[1].children[0].children[2].children[1].text| select(.!=null)}],[{"Street_Address":.[8].children[1].children[].children[1].children[1].children[0].children[4].children[1].text| select(.!=null)}],[{"City":.[8].children[1].children[].children[1].children[1].children[0].children[6].children[1].text| select(.!=null)}],[{"Country":.[8].children[1].children[].children[1].children[1].children[0].children[8].children[1].text| select(.!=null)}]]| transpose| map(add),"Sponsors__or_FundingSources":[[{"Name_of_organization_or_entity":.[9].children[1].children[].children[1].children[1].children[0].children[0].children[1].text | select (.!=null)}],[{"Full_name_of_responsible_person":.[9].children[1].children[].children[1].children[1].children[0].children[2].children[1].text | select (.!=null)}],[{"Street_address":.[9].children[1].children[].children[1].children[1].children[0].children[4].children[1].text | select (.!=null)}],[{"City":.[9].children[1].children[].children[1].children[1].children[0].children[6].children[1].text | select (.!=null)}],[{"City":.[9].children[1].children[].children[1].children[1].children[0].children[8].children[1].text | select (.!=null)}],[{"Country":.[9].children[1].children[].children[1].children[1].children[0].children[10].children[1].text | select (.!=null)}],[{"Grant_name":.[9].children[1].children[].children[1].children[7].text}],[{"Grant_name":.[9].children[1].children[].children[1].children[3].text}],[{"Grant_code_Reference_number":.[9].children[1].children[].children[1].children[5].text}],[{"Is_the_source_of_funding_the_same_sponsor_organization_entity?":.[9].children[1].children[].children[1].children[7].text}],[{"Title_of_funding_source":.[9].children[1].children[].children[1].children[9].text}],[{"Proportion_provided_by_this_source":.[9].children[1].children[].children[1].children[11].text}],[{"Public_or_private_sector":.[9].children[1].children[].children[1].children[13].text}],[{"Domestic_or_foreign_origin":.[9].children[1].children[].children[1].children[15].text}],[{"Category_of_foreign_source_of_funding":.[9].children[1].children[].children[1].children[17].text}],[{"Country_of_origin":.[9].children[1].children[].children[1].children[19].text}],[{"Type_of_organization_providing_the_funding":.[9].children[1].children[].children[1].children[21].text}] ]| transpose | map(add)}'
}


pushd ${context_dir}

source "/root/.gvm/scripts/gvm"

gvm install go1.4 --binary

gvm use "go1.4"

go get -u -f github.com/ericchiang/pup

if [[ ${download} == 'yes' ]]; then

    if [ -d ${html_dir}/irct ]; then
        rm -rf ${html_dir}/irct
    fi

    mkdir ${html_dir}/irct
    mkdir ${html_dir}/irct/studies
    mkdir ${html_dir}/irct/studies/analysis
    mkdir ${html_dir}/irct/json

    aws s3 sync ${s3_bucket}/studies ${html_dir}/irct/studies  --delete


    ls ${html_dir}/irct/studies | grep -oE "[^ ]*\.html" | while read f

    do
        analyse_file ${html_dir}/irct/studies/${f} ${html_dir}/irct/studies/analysis/${f}
    done

    ls ${html_dir}/irct/studies/analysis | grep -oE "[^ ]*\.html" | while read f
    do
       gen_json  ${html_dir}/irct/studies/analysis/${f} ${html_dir}/irct/json/
    done

    aws s3 sync ${html_dir}/irct/json ${s3_bucket}/json  --delete

else
    rm -rf ${html_dir}/irct

    mkdir ${html_dir}/irct
    mkdir ${html_dir}/irct/studies
    mkdir ${html_dir}/irct/studies/analysis
    mkdir ${html_dir}/irct/json

    aws s3 sync ${s3_bucket} ${html_dir}/irct/  --delete

    ls ${html_dir}/irct/studies | grep -oE "[^ ]*\.html" | while read f

    do
        analyse_file ${html_dir}/irct/studies/${f} ${html_dir}/irct/studies/analysis/${f}
    done

    ls ${html_dir}/irct/studies/analysis | grep -oE "[^ ]*\.html" | while read f
     do
       gen_json  ${html_dir}/irct/studies/analysis/${f} ${html_dir}/irct/studies/json/
    done

     aws s3 sync ${html_dir}/irct/json ${s3_bucket}/json  --delete
fi

popd

