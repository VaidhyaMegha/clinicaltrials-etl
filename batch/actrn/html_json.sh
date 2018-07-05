#!/usr/bin/env bash
set -x
set +H


html_dir=${1}
download=${2:-'no'}
s3_bucket=${3:-'s3://hsdlc-results/actrn-adapter'}
context_dir=${4:-'/usr/local/dataintegration'}


function analyse_file() {
    sed "s/&quot;/ /g" ${1} > ${1}.tmp
    tr '\n' ' ' < ${1}.tmp > ${2}
    rm ${1}.tmp
}

function gen_json() {
 cat 1412.html | pup 'div.review-form-block json{}' | jq -c '{  "trial_id":.[0].children[0].children[1].children[0].text,  "ethics_application_status":.[1].children[0].children[1].children[0].text,  "date_submitted":.[2].children[0].children[1].children[0].text,  "date_registered":.[3].children[0].children[1].children[0].text,  "date_last_updated":.[4].children[0].children[1].children[0].text,  "type_of_registration":.[5].children[0].children[1].children[0].text,  "public_title":.[7].children[0].children[1].children[0].text,  "scientific_title":.[8].children[0].children[1].children[0].text,  "secondary_id":.[9].children[0].children[1].children[0:]| select(.!=null)|[.[].text|select(.!=null)],  "UTN":.[10].children[0].children[1].children[0].text,  "trial_acronym":.[11].children[0].children[1].children[0].text,  "linked_study_record":.[12].children[0].children[1].children[0].text,  "health_conditions_or_problems_studied":[.[[.[] | .children[0].children[0].text | ( if . == null then false else startswith("Health condition(s) or problem(s) studied") end)]| index(true):[.[] |.children[0].children[0].text | ( if . == null then false else startswith("Condition category") end)]| index(true)] | .[]|.children[0].children[0].children[0].text | select(.!=null)],  "Condition_category":[.[[.[] | .children[0].children[0].text | ( if . == null then false else startswith("Condition category") end)]| index(true):[.[] |.children[0].text | ( if . == null then false else startswith("Intervention/exposure") end)]| index(true)] | .[]| {"condition_category":.children[].children[0].children[0].text| select(.!=null),"Condition_code":.children[].children[1].children[0].text}| select(.!=null)] ,  "Study_Type":.[] | (if .children[0].children[0].children[0].text == "Study type" then .children[]  else false end) | select (.!= false) | .children[1].children[0].text,  "Primary_Registry":[.[] | (if .children[0].children[0].children[0].text== "Patient registry" then .children[0].children[1].children[0].text  else null end )]| sort | last,  "Target_follow_up_duration":[.[] | (if .children[0].children[0].children[0].text== "Target follow-up duration" then .children[0].children[1].children[0].text  else null end )]| sort | last,  "Target_follow_up_type":[.[] | (if .children[0].children[0].children[0].text== "Target follow-up type" then .children[0].children[1].children[0].text  else null end )]| sort | last,  "Description_of_intervention(s)/exposure":.[] | (if .children[0].children[0].children[0].text == "Description of intervention(s) / exposure" then .children[]  else false end) | select (.!= false) | .children[1].children[0].text,  "Intervention_code":[.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Intervention code [1]") end)]| index(true):[.[] |.children[0].children[0].children[0].text | ( if . == null then false else startswith("Comparator / control treatment") end)]| index(true)] | .[]|.children[0].children[1].children[0].text],  "Comparator/control_treatment":.[] | (if .children[0].children[0].children[0].text == "Comparator / control treatment" then .children[]  else false end) | select (.!= false) | .children[1].children[0].text,  "Control_group":.[] | (if .children[0].children[0].children[0].text == "Control group" then .children[]  else false end) | select (.!= false) | .children[1].children[0].text,  "Outcome":{"PrimaryOutcome":[[.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Primary outcome") end)] | index(true) : [.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Secondary outcome") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null) | startswith("Primary outcome") then .children[0].children[1].children[0].text else null end) | select(. != null)], [.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Primary outcome") end)] | index(true) : [.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Secondary outcome") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null) | startswith("Timepoint") then .children[0].children[1].children[0].text else null end) | select(. != null) ]] |  transpose | map( {"primary_outcome": .[0], "timepoint": .[1]}),"SecondaryOutcome":[[.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Secondary outcome") end)] | index(true) : [.[] |  .children[0].text == "Eligibility"] | index(true)] | .[] | (if .children[0].children[0].children[0].text |select(.!=null) | startswith("Secondary outcome") then .children[0].children[1].children[0].text else null end) | select(. != null)], [.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Secondary outcome") end)] | index(true) : [.[] |  .children[0].text == "Eligibility"] | index(true)] | .[] | (if .children[0].children[0].children[0].text |select(.!=null) | startswith("Timepoint") then .children[0].children[1].children[0].text else null end) | select(. != null) ]] |  transpose | map( {"secondary_outcome": .[0], "timepoint": .[1]})},  "Key_inclusion_criteria":.[] | (if .children[0].children[0].children[0].text == "Key inclusion criteria" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,  "Minimum_age":.[] | (if .children[0].children[0].children[0].text == "Minimum age" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,  "Maximum_age":.[] | (if .children[0].children[0].children[0].text == "Maximum age" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,  "Gender":.[] | (if .children[0].children[0].children[0].text == "Gender" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,  "Can_healthy_volunteers_participate?":.[] | (if .children[0].children[0].children[0].text == "Can healthy volunteers participate?" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,  "Key_exclusion_criteria":.[] | (if .children[0].children[0].children[0].text == "Key exclusion criteria" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,  "study_design" :    [{"Interventional":     { "Purpose_of_the_study":.[] | (if .children[0].children[0].children[0].text == "Purpose of the study" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,                                                               "Allocation_to_intervention":.[] | (if .children[0].children[0].children[0].text == "Allocation to intervention" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,                                                           "Procedure_for_enrolling_a_subject_and_allocating_the treatment(allocation_concealment_procedures)":.[] | (if .children[0].children[0].text == "Procedure for enrolling a subject and allocating the treatment (allocation concealment\n                  procedures)" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,                                                           "Methods_used_to_generate_the_sequence_in_which_subjects_will_be_randomised_(sequence_generation)":.[] | (if .children[0].children[0].text == "Methods used to generate the sequence in which subjects will be randomised (sequence\n                  generation)" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,                                                           "Masking/blinding":.[] | (if .children[0].children[0].children[0].text == "Masking / blinding" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,                                                           "Who_is/are_masked/blinded?":.[] | (if .children[0].children[0].text == "Who is / are masked / blinded?" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,                                                           "Intervention_assignment":.[] | (if .children[0].children[0].text == "Intervention assignment" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text, "Other_design_features":.[] | (if .children[0].children[0].children[0].text == "Other design features" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,                                                          "Phase":.[] | (if .children[0].children[0].children[0].text == "Phase" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text ,"Type_of_endpoint(s)":.[] | (if .children[0].children[0].children[0].text == "Type of endpoint(s)" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text, "Statistical_methods/analysis":.[] | (if .children[0].children[0].children[0].text == "Statistical methods / analysis" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text }},       {"Observational":{ "Purpose":.[] | (if .children[0].children[0].children[0].text == "Purpose" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,        "Purpose":.[] | (if .children[0].children[0].children[0].text == "Purpose" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,        "Duration":.[] | (if .children[0].children[0].children[0].text == "Duration" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,        "Selection":.[] | (if .children[0].children[0].children[0].text == "Selection" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,        "Timing":.[] | (if .children[0].children[0].children[0].text == "Timing" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text,        "Statistical methods / analysis":.[] | (if .children[0].children[0].children[0].text == "Statistical methods / analysis" then .children[] else false end)  | select (.!= false) | .children[1].children[0].text        }  }  ],"Recruitment_status":.[] | (if .children[0].children[0].children[0].text == "Recruitment status" then .children[]  else false end) | select (.!= false) | .children[1].children[0].text,"Date_of_first_participant_enrolment":[.[[.[] | .children[0].children[0].text |( if . == null then false else startswith("Date of first participant enrolment") end)]| index(true):[.[] |.children[0].children[0].text | ( if . == null then false else  startswith("Date of last participant enrolment") end)]|index(true)]|.[]|.children[0].children[].children[0].text | select(.!=null)]|{"Anticipated":.[0],"Actual":.[1]} ,"Date_of_last_participant_enrolment":[.[[.[] | .children[0].children[0].text |( if . == null then false else startswith("Date of last participant enrolment") end)]| index(true):[.[] |.children[0].children[0].text | ( if . == null then false else  startswith("Date of last data collection") end)]|index(true)]|.[]|.children[0].children[].children[0].text | select(.!=null)]|{"Anticipated":.[0],"Actual":.[1]},"Date_of_last_data_collection":[.[[.[] | .children[0].children[0].text |( if . == null then false else startswith("Date of last data collection") end)]| index(true):[.[] |.children[0].children[0].text | ( if . == null then false else  startswith("Sample size") end)]|index(true)]|.[]|.children[0].children[].children[0].text | select(.!=null)]|{"Anticipated":.[0],"Actual":.[1]},"Sample_Size":.[[.[] | .children[0].children[0].text |( if . == null then false else startswith("Sample size") end)]| index(true):[.[] |.children[0].children[0].text | ( if . == null then false else  (startswith("Recruitment in Australia") or startswith("Recruitment outside Australia")) end)]|index(true)] | .[1] | {"Target":.children[0].children[1].children[0].text,"Accrual_to_date":.children[0].children[3].children[0].text,"Final":.children[0].children[5].children[0].text},"Recruitment_outside_Australia":[[.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Country") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Funding &amp; Sponsors") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null)| startswith("Country") then .children[0].children[1].children[0].text else null end) | select(. != null)], [.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Country") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Funding &amp; Sponsors") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null) | startswith("State/province") then .children[0].children[1].children[0].text else null end) | select(. != null) ]] |  transpose | map( {"Country": .[0], "State/province": .[1]}) ,"Recruitment_state":[.[[.[] | .children[0].children[0].children[0].text  | ( if . == null then false else startswith("Recruitment state(s)") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Funding &amp; Sponsors") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null)| startswith("Recruitment state(s)") then .children[0].children[1].children[0].text else null end) | select(. != null)],  "Recruitment_Inside_Australia":[[.[[.[] | .children[0].children[0].children[0].text  | ( if . == null then false else startswith("Recruitment state(s)") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Funding &amp; Sponsors") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null)| startswith("Recruitment hospital") then .children[0].children[1].children[0].text else null end) | select(. != null)], [.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Recruitment state(s)") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Funding &amp; Sponsors") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null) | startswith("Recruitment postcode(s)") then .children[0].children[1].children[0].text else null end) | select(. != null) ]] |  transpose | map( {"Recruitment hospital": .[0], "Recruitment postcode": .[1]}) ,"Funding&Sponsors": { "Funding":[[.[[.[] | .children[0].children[0].children[0].text  | ( if . == null then false else startswith("Funding source category") end)] | index(true) : [.[] | .children[0].children[0].text | ( if . == null then false else startswith("Primary sponsor type") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null)| startswith("Funding source category") then .children[0].children[1].children[0].text else null end) | select(. != null)], [.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Funding source category") end)] | index(true) : [.[] | .children[0].children[0].text | ( if . == null then false else startswith("Primary sponsor type") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null) | startswith("Name") then .children[0].children[1].children[0].text else null end) | select(. != null) ],[.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Funding source category") end)] | index(true) : [.[] | .children[0].children[0].text | ( if . == null then false else startswith("Primary sponsor type") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null) | startswith("Address") then .children[0].children[1].children[0].text else null end) | select(. != null) ],[.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Funding source category") end)] | index(true) : [.[] | .children[0].children[0].text | ( if . == null then false else startswith("Primary sponsor type") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null) | startswith("Country") then .children[0].children[1].children[0].text else null end) | select(. != null) ] ] |  transpose | map( {"Funding_source_category": .[0], "Name": .[1], "Address": .[2],"Country": .[3]}),"PrimarySponsors":[[.[[.[] | .children[0].children[0].text  | ( if . == null then false else startswith("Primary sponsor type") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Ethics approval") end)] | index(true)] | .[] | (if .children[0].children[0].text | select(.!=null)| startswith("Primary sponsor type") then .children[0].children[1].children[0].text else null end) | select(. != null)], [.[[.[] | .children[0].children[0].text | ( if . == null then false else startswith("Primary sponsor type") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Ethics approval") end)] | index(true)] | .[] | (if .children[0].children[0].text | select(.!=null) | startswith("Name") then .children[0].children[1].children[0].text else null end) | select(. != null) ],[.[[.[] | .children[0].children[0].text | ( if . == null then false else startswith("Primary sponsor type") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Ethics approval") end)] | index(true)] | .[] | (if .children[0].children[0].text | select(.!=null) | startswith("Address") then .children[0].children[1].children[0].text else null end) | select(. != null) ],[.[[.[] | .children[0].children[0].text | ( if . == null then false else startswith("Primary sponsor type") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Ethics approval") end)] | index(true)] | .[] | (if .children[0].children[0].text | select(.!=null) | startswith("Country") then .children[0].children[1].children[0].text else null end) | select(. != null) ]] |  transpose | map( {"sponsor_type": .[0], "Name": .[1], "Address": .[2],"Country": .[3]}), "SecondarySponsors":[[.[[.[] | .children[0].children[0].children[0].text  | ( if . == null then false else startswith("Secondary sponsor category") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Ethics approval") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null)| startswith("Secondary sponsor category") then .children[0].children[1].children[0].text else null end) | select(. != null)], [.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Secondary sponsor category") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Ethics approval") end)] | index(true)] | .[] | (if .children[0].children[0].text | select(.!=null) | startswith("Name") then .children[0].children[1].children[0].text else null end) | select(. != null) ],[.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Secondary sponsor category") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Ethics approval") end)] | index(true)] | .[] | (if .children[0].children[0].text | select(.!=null) | startswith("Address") then .children[0].children[1].children[0].text else null end) | select(. != null) ],[.[[.[] | .children[0].children[0].children[0].text | ( if . == null then false else startswith("Secondary sponsor category") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Ethics approval") end)] | index(true)] | .[] | (if .children[0].children[0].text | select(.!=null) | startswith("Country") then .children[0].children[1].children[0].text else null end) | select(. != null) ]] | transpose | map( {"sponsor_type": .[0], "Name": .[1], "Address": .[2],"Country": .[3]})},"Ethics_approval" :{"Ethics_application_status":[.[[.[] | .children[0].children[0].children[0].text  | ( if . == null then false else startswith("Ethics application status") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Summary") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null)| startswith("Ethics application status") then .children[0].children[1].children[0].text else null end) | select(. != null)],"EthicsComitteDetails":[[.[[.[] | .children[0].children[0].children[0].text  | ( if . == null then false else startswith("Ethics committee name") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Summary") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null)| startswith("Ethics committee name") then .children[0].children[1].children[0].text else null end) | select(. != null)],[.[[.[] | .children[0].children[0].children[0].text  | ( if . == null then false else startswith("Ethics committee name") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Summary") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null)| startswith("Ethics committee address") then .children[0].children[1].children[0].text else null end) | select(. != null)],[.[[.[] | .children[0].children[0].children[0].text  | ( if . == null then false else startswith("Ethics committee name") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Summary") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null)| startswith("Ethics committee country") then .children[0].children[1].children[0].text else null end) | select(. != null)],[.[[.[] | .children[0].children[0].children[0].text  | ( if . == null then false else startswith("Ethics committee name") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Summary") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null)| startswith("Date submitted for ethics approval") then .children[0].children[1].children[0].text else null end) | select(. != null)],[.[[.[] | .children[0].children[0].children[0].text  | ( if . == null then false else startswith("Ethics committee name") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Summary") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null)| startswith("Approval date") then .children[0].children[1].children[0].text else null end) | select(. != null)],[.[[.[] | .children[0].children[0].children[0].text  | ( if . == null then false else startswith("Ethics committee name") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Summary") end)] | index(true)] | .[] | (if .children[0].children[0].children[0].text | select(.!=null)| startswith("Ethics approval number") then .children[0].children[1].children[0].text else null end) | select(. != null)]] |  transpose | map( {"Ethics_committee_name": .[0], "Ethics_committee_address": .[1], "Ethics_committee_country": .[2],"Date_submitted_for_ethics_approval": .[3],"Approval_date": .[4],"Ethics_approval_number": .[3]})}, "Summary": .[[.[] | .children[0].text  | ( if . == null then false else startswith("Summary") end)] | index(true) : [.[] | .children[0].text | ( if . == null then false else startswith("Contacts") end)] | index(true)]| {"Brief_summary": .[1].children[0].children[1].children[0].text,"Trial_website": .[2].children[0].children[1].children[0].text,"Trial_related_presentations_publications": .[3].children[0].children[1].children[0].text,"Public_notes": .[4].children[0].children[1].children[0].text},"Principal_investigator":.[[.[] | .children[0].children[0].text  | ( if . == null then false else startswith("Principal investigator") end)] | index(true) : [.[] | .children[0].children[0].text | ( if . == null then false else startswith("Contact person for public queries") end)] | index(true)] | {"name": .[2].children[0].children[1].children[0].text,"address": .[3].children[0].children[1].children[0].text,"Country": .[4].children[0].children[1].children[0].text,"Phone": .[5].children[0].children[1].children[0].text,"Fax": .[6].children[0].children[1].children[0].text,"Email": .[7].children[0].children[1].children[0].text},         "Contact_person_for_public_queries":.[[.[] | .children[0].children[0].text  | ( if . == null then false else startswith("Contact person for public queries") end)] | index(true) : [.[] | .children[0].children[0].text | ( if . == null then false else startswith(" Contact person for scientific queries") end)] | index(true)] | {"name": .[2].children[0].children[1].children[0].text,"address": .[3].children[0].children[1].children[0].text,"Country": .[4].children[0].children[1].children[0].text,"Phone": .[5].children[0].children[1].children[0].text,"Fax": .[6].children[0].children[1].children[0].text,"Email": .[7].children[0].children[1].children[0].text},"Contact_person_for_scientific_queries":.[[.[] | .children[0].children[0].text  | ( if . == null then false else startswith("Contact person for scientific queries") end)] | index(true) :]| {"name": .[2].children[0].children[1].children[0].text,"address": .[3].children[0].children[1].children[0].text,"Country": .[4].children[0].children[1].children[0].text,"Phone": .[5].children[0].children[1].children[0].text,"Fax": .[6].children[0].children[1].children[0].text,"Email": .[7].children[0].children[1].children[0].text} }' >> ${2}/studies.json
}
set -e

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

    #aws s3 sync ${s3_bucket}/studies ${html_dir}/actrn/studies  --delete


    ls ${html_dir}/actrn/studies | grep -oE "[^ ]*\.html" | while read f

    do
        analyse_file ${html_dir}/actrn/studies/${f} ${html_dir}/actrn/studies/analysis/${f}
    done

    ls ${html_dir}/actrn/studies/analysis | grep -oE "[^ ]*\.html" | while read f
    do
       gen_json  ${html_dir}/actrn/studies/analysis/${f} ${html_dir}/actrn/json/ || true
    done

    aws s3 sync ${html_dir}/actrn/json ${s3_bucket}/json  --delete

else
    rm -rf ${html_dir}/actrn

    mkdir ${html_dir}/actrn
    mkdir ${html_dir}/actrn/studies
    mkdir ${html_dir}/actrn/studies/analysis
    mkdir ${html_dir}/actrn/json

    aws s3 sync ${s3_bucket} ${html_dir}/actrn/  --delete

 #   ls ${html_dir}/actrn/studies | grep -oE "[^ ]*\.html" | while read f

 #   do
        analyse_file ${html_dir}/actrn/studies/${f} ${html_dir}/actrn/studies/analysis/${f}
 #   done

  #  ls ${html_dir}/actrn/studies/analysis | grep -oE "[^ ]*\.html" | while read f
  #   do
       gen_json  ${html_dir}/actrn/studies/analysis/${f} ${html_dir}/actrn/studies/json/ || true
  #  done

     aws s3 sync ${html_dir}/actrn/json ${s3_bucket}/json  --delete
fi

popd

