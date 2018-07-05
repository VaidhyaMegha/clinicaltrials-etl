#!/usr/bin/env bash
set -ex
set +H


html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/actrn-adapter'}
context_dir=${4:-'/usr/local/dataintegration'}


function analyse_file() {
    sed "s/&quot;/ /g" ${1} > ${1}.tmp
    tr '\n' ' ' < ${1}.tmp > ${2}
}

function gen_json() {
 cat ${1} |  pup 'div.section json{}' | jq '{ "Protocol_Summary":.[0].children[1].children[0].children[1].children[0].text,"IRCT_RegistrationNumber":.[1].children[1].children[0].children[3].children[0].children[0].children[1].text,"Registration date":.[1].children[1].children[0].children[3].children[0].children[1].children[1].text,"Registration_timing":.[1].children[1].children[0].children[3].children[0].children[2].children[1].text,"Last_Update":.[1].children[1].children[0].children[3].children[0].children[4].children[1].text,"Update":.[1].children[1].children[0].children[3].children[0].children[5].children[1].text,"Registrant_Name":.[1].children[1].children[1].children[1].children[0].children[0].children[1].text,"Registrant_Name_Of_Organization_or_Entity":.[1].children[1].children[1].children[1].children[0].children[1].children[1].text,"Country":.[1].children[1].children[1].children[1].children[0].children[2].children[1].text,"Phone":.[1].children[1].children[1].children[1].children[0].children[3].children[1].text,"Email":.[1].children[1].children[1].children[1].children[0].children[4].children[1].text, "Recruitment_status":.[1].children[1].children[2].children[1].children[0].text,"Funding_source":.[1].children[1].children[2].children[3].children[0].text,"Expected_Recruitment_start_Date":.[1].children[1].children[4].children[1].text,"Expected_Recruitment_End_Date":.[1].children[1].children[4].children[3].text,"Actual_recruitment_start_date":.[1].children[1].children[4].children[5].children[0].text,"Actual_recruitment_End_date":.[1].children[1].children[4].children[7].children[0].text,"Scientific_title":.[1].children[1].children[5].children[1].text,"Public_title":.[1].children[1].children[6].children[1].text,"Purpose":.[1].children[1].children[6].children[3].text,"Inclusion_or_Exclusion_Criteria":.[1].children[1].children[6].children[5].text,"Age":.[1].children[1].children[6].children[7].text,"Gender":.[1].children[1].children[6].children[9].text,"phase":.[1].children[1].children[7].children[1].text,"Groups_that_have_been_masked":.[1].children[1].children[7].children[3].children[0].text,"Target_sample_size":.[1].children[1].children[7].children[5].children[0].children[0].text,"Randomization_investigator_s_opinion":.[1].children[1].children[7].children[7].text,"Randomization_description":.[1].children[1].children[7].children[9].text,"Blinding_investigator_s_opinion":.[1].children[1].children[7].children[11].text,"Blinding_description":.[1].children[1].children[7].children[13].text,"Placebo":.[1].children[1].children[7].children[15].text,"Assignment":.[1].children[1].children[7].children[17].text,"Other_design-features":.[1].children[1].children[7].children[19].text}'
}


pushd ${context_dir}

source "/root/.gvm/scripts/gvm"

gvm install go1.4 --binary

gvm use "go1.4"

go get -u -f github.com/ericchiang/pup

if [[ ${download} == 'yes' ]]; then

    if [ -d ${html_dir}/actrn ]; then
        rm -rf ${html_dir}/actrn
    fi

    mkdir ${html_dir}/actrn
    mkdir ${html_dir}/actrn/studies
    mkdir ${html_dir}/actrn/studies/analysis
    mkdir ${html_dir}/actrn/json

    aws s3 sync ${s3_bucket}/studies ${html_dir}/actrn/studies  --delete


    ls ${html_dir}/actrn/studies | grep -oE "[^ ]*\.html" | while read f

    do
        analyse_file ${html_dir}/actrn/studies/${f} ${html_dir}/actrn/studies/analysis/${f}
    done

    ls ${html_dir}/actrn/studies/analysis | grep -oE "[^ ]*\.html" | while read f
    do
       gen_json  ${html_dir}/actrn/studies/analysis/${f} ${html_dir}/actrn/json/
    done

    aws s3 sync ${html_dir}/actrn/json ${s3_bucket}/json  --delete

else
    rm -rf ${html_dir}/actrn

    mkdir ${html_dir}/actrn
    mkdir ${html_dir}/actrn/studies
    mkdir ${html_dir}/actrn/studies/analysis
    mkdir ${html_dir}/actrn/json

    aws s3 sync ${s3_bucket} ${html_dir}/actrn/  --delete

    ls ${html_dir}/actrn/studies | grep -oE "[^ ]*\.html" | while read f

    do
        analyse_file ${html_dir}/actrn/studies/${f} ${html_dir}/actrn/studies/analysis/${f}
    done

    ls ${html_dir}/actrn/studies/analysis | grep -oE "[^ ]*\.html" | while read f
     do
       gen_json  ${html_dir}/actrn/studies/analysis/${f} ${html_dir}/actrn/studies/json/
    done

     aws s3 sync ${html_dir}/actrn/json ${s3_bucket}/json  --delete
fi

popd

