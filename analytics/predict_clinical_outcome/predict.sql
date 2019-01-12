CREATE EXTERNAL TABLE `hsdlc.ct_studies`(
  `participant_flow` struct<recruitment_details:string,pre_assignment_details:string,group_list:struct<group:array<struct<title:string,description:string,group_id:string>>>,period_list:struct<period:array<struct<title:string,milestone_list:struct<milestone:array<struct<title:string,participants:array<struct<group_id:string,count:string,text_node_value:string>>>>>,group_id:string>>>> COMMENT 'from deserializer',
  `baseline` struct<population:string,group_list:struct<group:array<struct<title:string,description:string,group_id:string>>>,analyzed_list:struct<analyzed:array<struct<units:string,scope:string,count_list:struct<count:array<struct<group_id:string,value:string,text_node_value:string>>>>>>,measure_list:struct<measure:array<struct<title:string,description:string,population:string,units:string,param:string,dispersion:string,units_analyzed:string,analyzed_list:struct<analyzed:array<struct<units:string,scope:string,count_list:struct<count:array<struct<group_id:string,value:string,text_node_value:string>>>>>>,class_list:struct<class:array<struct<title:string,analyzed_list:struct<analyzed:array<struct<units:string,scope:string,count_list:struct<count:array<struct<group_id:string,value:string,text_node_value:string>>>>>>,category_list:struct<category:array<struct<title:string,measurement_list:struct<measurement:array<struct<group_id:string,value:string,spread:string,lower_limit:string,upper_limit:string,text_node_value:string>>>>>>>>>>>>> COMMENT 'from deserializer', 
  `outcome_list` struct<outcome:array<struct<type:string,title:string,description:string,time_frame:string,safety_issue:string,posting_date:string,population:string,group_list:struct<group:array<struct<title:string,description:string,group_id:string>>>,measure:struct<title:string,description:string,population:string,units:string,param:string,dispersion:string,units_analyzed:string,analyzed_list:struct<analyzed:array<struct<units:string,scope:string,count_list:struct<count:array<struct<group_id:string,value:string,text_node_value:string>>>>>>,class_list:struct<class:array<struct<title:string,analyzed_list:struct<analyzed:array<struct<units:string,scope:string,count_list:struct<count:array<struct<group_id:string,value:string,text_node_value:string>>>>>>,category_list:struct<category:array<struct<title:string,measurement_list:struct<measurement:array<struct<group_id:string,value:string,spread:string,lower_limit:string,upper_limit:string,text_node_value:string>>>>>>>>>>,analysis_list:struct<analysis:array<struct<group_id_list:struct<group_id:string>,groups_desc:string,non_inferiority_type:string,non_inferiority_desc:string,p_value:string,p_value_desc:string,method:string,method_desc:string,param_type:string,param_value:string,dispersion_type:string,dispersion_value:string,ci_percent:string,ci_n_sides:string,ci_lower_limit:string,ci_upper_limit:string,ci_upper_limit_na_comment:string,estimate_desc:string,other_analysis_desc:string>>>>>> COMMENT 'from deserializer', 
  `reported_events` struct<time_frame:string,desc:string,group_list:struct<group:array<struct<title:string,description:string,group_id:string>>>,serious_events:struct<frequency_threshold:string,default_vocab:string,default_assessment:string,category_list:struct<category:array<struct<title:string,event_list:struct<event:array<struct<sub_title:struct<vocab:string,text_node_value:string>,assessment:string,description:string,counts:array<struct<group_id:string,subjects_affected:string,subjects_at_risk:string,events:string,text_node_value:string>>>>>>>>>,other_events:struct<frequency_threshold:string,default_vocab:string,default_assessment:string,category_list:struct<category:array<struct<title:string,event_list:struct<event:array<struct<sub_title:struct<vocab:string,text_node_value:string>,assessment:string,description:string,counts:array<struct<group_id:string,subjects_affected:string,subjects_at_risk:string,events:string,text_node_value:string>>>>>>>>>> COMMENT 'from deserializer', 
  `certain_agreements` struct<pi_employee:string,restrictive_agreement:string> COMMENT 'from deserializer', 
  `limitations_and_caveats` string COMMENT 'from deserializer', 
  `point_of_contact` struct<name_or_title:string,organization:string,phone:string,email:string> COMMENT 'from deserializer', 
  `patient_data` struct<sharing_ipd:string,ipd_description:string> COMMENT 'from deserializer', 
  `study_docs` struct<study_doc:array<struct<doc_id:string,doc_type:string,doc_url:string,doc_comment:string>>> COMMENT 'from deserializer', 
  `responsible_party` struct<responsible_party_type:string,investigator_affiliation:string,investigator_full_name:string,invewastigator_title:string> COMMENT 'from deserializer', 
  `intervention` array<struct<intervention_type:string,intervention_name:string,description:string,arm_group_label:string,other_name:string>> COMMENT 'from deserializer', 
  `eligibility` struct<study_pop:struct<textblock:string>,sampling_method:string,criteria:struct<textblock:string>,gender:string,gender_based:string,minimum_age:string,maximum_age:string,healthy_volunteers:string> COMMENT 'from deserializer', 
  `overall_official` array<struct<first_name:string,middle_name:string,last_name:string,degrees:string,role:string,affiliation:string>> COMMENT 'from deserializer', 
  `overall_contact` struct<first_name:string,middle_name:string,last_name:string,degrees:string,phone:string,phone_ext:string,email:string> COMMENT 'from deserializer', 
  `overall_contact_backup` struct<first_name:string,middle_name:string,last_name:string,degrees:string,phone:string,phone_ext:string,email:string> COMMENT 'from deserializer', 
  `oversight_info` struct<has_dmc:string,is_fda_regulated_drug:string,is_fda_regulated_device:string,is_unapproved_device:string,is_ppsd:string,is_us_export:string> COMMENT 'from deserializer', 
  `arm_group` struct<arm_group_label:string,arm_group_type:string,description:string> COMMENT 'from deserializer', 
  `expanded_access_info` struct<expanded_access_type_individual:string,expanded_access_type_intermediate:string,expanded_access_type_treatment:string> COMMENT 'from deserializer', 
  `study_design_info` struct<allocation:string,intervention_model:string,intervention_model_description:string,primary_purpose:string,observational_model:string,time_perspective:string,masking:string,masking_description:string> COMMENT 'from deserializer', 
  `required_header` struct<download_date:string,link_text:string,url:string> COMMENT 'from deserializer', 
  `id_info` struct<org_study_id:string,secondary_id:array<string>,nct_id:string,nct_alias:array<string>> COMMENT 'from deserializer', 
  `brief_title` string COMMENT 'from deserializer', 
  `acronym` string COMMENT 'from deserializer', 
  `official_title` string COMMENT 'from deserializer', 
  `sponsors` struct<lead_sponsor:struct<agency:string,agency_class:string>,collaborator:array<struct<agency:string,agency_class:string>>> COMMENT 'from deserializer', 
  `source` string COMMENT 'from deserializer', 
  `why_stopped` string COMMENT 'from deserializer', 
  `target_duration` string COMMENT 'from deserializer', 
  `overall_status` string COMMENT 'from deserializer', 
  `last_known_status` string COMMENT 'from deserializer', 
  `phase` string COMMENT 'from deserializer', 
  `study_type` string COMMENT 'from deserializer', 
  `has_expanded_access` string COMMENT 'from deserializer', 
  `biospec_retention` string COMMENT 'from deserializer', 
  `number_of_arms` string COMMENT 'from deserializer', 
  `number_of_groups` string COMMENT 'from deserializer', 
  `verification_date` string COMMENT 'from deserializer', 
  `study_first_submitted` string COMMENT 'from deserializer', 
  `study_first_submitted_qc` string COMMENT 'from deserializer', 
  `results_first_submitted` string COMMENT 'from deserializer', 
  `results_first_submitted_qc` string COMMENT 'from deserializer', 
  `disposition_first_submitted` string COMMENT 'from deserializer', 
  `disposition_first_submitted_qc` string COMMENT 'from deserializer', 
  `last_update_submitted` string COMMENT 'from deserializer', 
  `last_update_submitted_qc` string COMMENT 'from deserializer', 
  `enrollment` struct<type:string,text_node_value:string> COMMENT 'from deserializer', 
  `study_first_posted` struct<type:string,text_node_value:string> COMMENT 'from deserializer', 
  `results_first_posted` struct<type:string,text_node_value:string> COMMENT 'from deserializer', 
  `disposition_first_posted` struct<type:string,text_node_value:string> COMMENT 'from deserializer', 
  `last_update_posted` struct<type:string,text_node_value:string> COMMENT 'from deserializer', 
  `completion_date` struct<type:string,text_node_value:string> COMMENT 'from deserializer', 
  `start_date` struct<type:string,text_node_value:string> COMMENT 'from deserializer', 
  `primary_completion_date` struct<type:string,text_node_value:string> COMMENT 'from deserializer', 
  `brief_summary` struct<textblock:string> COMMENT 'from deserializer', 
  `detailed_description` struct<textblock:string> COMMENT 'from deserializer', 
  `biospec_descr` struct<textblock:string> COMMENT 'from deserializer', 
  `keyword` string COMMENT 'from deserializer', 
  `condition` string COMMENT 'from deserializer', 
  `primary_outcome` array<struct<measure:string,time_frame:string,description:string>> COMMENT 'from deserializer', 
  `secondary_outcome` array<struct<measure:string,time_frame:string,description:string>> COMMENT 'from deserializer', 
  `other_outcome` array<struct<measure:string,time_frame:string,description:string>> COMMENT 'from deserializer', 
  `reference` array<struct<citation:string,pmid:string>> COMMENT 'from deserializer', 
  `results_reference` array<struct<citation:string,pmid:string>> COMMENT 'from deserializer', 
  `link` array<struct<url:string,description:string>> COMMENT 'from deserializer', 
  `location` array<struct<facility:struct<name:string,address:struct<city:string,state:string,zip:string,country:string>>, status:string, contact:struct<first_name:string,middle_name:string,last_name:string,degrees:string,phone:string,phone_ext:string,email:string>, contact_backup:struct<first_name:string,middle_name:string,last_name:string,degrees:string,phone:string,phone_ext:string,email:string>, investigator:array<struct<first_name:string,middle_name:string,last_name:string,degrees:string,role:string,affiliation:string>>>> COMMENT 'from deserializer',
  `location_countries` string COMMENT 'from deserializer', 
  `removed_countries` string COMMENT 'from deserializer', 
  `condition_browse` string COMMENT 'from deserializer', 
  `intervention_browse` string COMMENT 'from deserializer')
PARTITIONED BY ( 
  `p_id` string)
ROW FORMAT SERDE 
  'org.openx.data.jsonserde.JsonSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://hsdlc-results/ct-adapter/json'
TBLPROPERTIES (
  'ignore.malformed.json'='true', 
  'transient_lastDdlTime'='1531602351')

select distinct overall_status from ct_studies;
 overall_status
---------------------------
 Completed
 Unknown status
 Temporarily not available
 Withdrawn
 Suspended
 Approved for marketing
 Not yet recruiting
 Active, not recruiting
 No longer available
 Terminated
 Recruiting
 Withheld
 Available
 Enrolling by invitation
(14 rows)

select overall_status, count(1) as cnt from ct_studies group by overall_status
https://console.aws.amazon.com/athena/query/results/bd2c303f-c778-4a0d-b4e8-373f12c95e2a/csv
aws s3 cp s3://default-query-results-519510601754-us-east-1/bd2c303f-c778-4a0d-b4e8-373f12c95e2a.csv ~/projects/ctd/DI_ETL/analytics/predict_clinical_outcome/datasets/

select distinct why_stopped from ct_studies;
https://console.aws.amazon.com/athena/query/results/06a736aa-dd99-4b4c-8563-200f54b1423f/csv
aws s3 cp s3://default-query-results-519510601754-us-east-1/06a736aa-dd99-4b4c-8563-200f54b1423f.csv ~/projects/ctd/DI_ETL/analytics/predict_clinical_outcome/datasets/

select word, count(1) as cnt from ct_studies cross join unnest(split(why_stopped, ' ')) as i(word)
where overall_status in ('Withdrawn', 'Terminated', 'Suspended') and length(word) > 6 group by word order by cnt desc;
https://console.aws.amazon.com/athena/query/results/a10bcb18-bc6a-4e09-af85-7f577861f9fb/csv
aws s3 cp s3://default-query-results-519510601754-us-east-1/a10bcb18-bc6a-4e09-af85-7f577861f9fb.csv ~/projects/ctd/DI_ETL/analytics/predict_clinical_outcome/datasets/

select p.mesh_term_condition, count(1) as cnt
from ct_studies c cross join unnest(cast(json_extract(condition_browse, '$') as array(JSON))) as p(mesh_term_condition)
group by mesh_term_condition
https://console.aws.amazon.com/athena/query/results/1238f5fd-5a89-4bc1-9efd-6b2222c6794a/csv
aws s3 cp s3://default-query-results-519510601754-us-east-1/1238f5fd-5a89-4bc1-9efd-6b2222c6794a.csv ~/projects/ctd/DI_ETL/analytics/predict_clinical_outcome/datasets/

select p.mesh_term_intervention, count(1) as cnt
from ct_studies c cross join unnest(cast(json_extract(intervention_browse, '$') as array(JSON))) as p(mesh_term_intervention)
group by mesh_term_intervention
https://console.aws.amazon.com/athena/query/results/a7cec982-743b-4c53-a391-ad3ab03d4bf2/csv
aws s3 cp s3://default-query-results-519510601754-us-east-1/a7cec982-743b-4c53-a391-ad3ab03d4bf2.csv ~/projects/ctd/DI_ETL/analytics/predict_clinical_outcome/datasets/

select
id_info, official_title, study_design_info, sponsors, overall_status, enrollment, keyword, condition, location, why_stopped, phase, study_type, number_of_arms, number_of_groups, condition_browse, intervention_browse, primary_outcome, secondary_outcome, responsible_party, eligibility
from hsdlc.ct_studies
where overall_status != '' and overall_status in ('Completed', 'Approved for marketing', 'Withdrawn', 'Terminated', 'Suspended');
https://console.aws.amazon.com/athena/query/results/3b876a3c-5151-4c00-b7c8-8d4738a3d809/csv
aws s3 cp s3://default-query-results-519510601754-us-east-1/3b876a3c-5151-4c00-b7c8-8d4738a3d809.csv ~/projects/ctd/DI_ETL/analytics/predict_clinical_outcome/datasets/

mvn exec:java -Dexec.args="/home/mahalaxmi/projects/ctd/DI_ETL/analytics/predict_clinical_outcome/datasets/3b876a3c-5151-4c00-b7c8-8d4738a3d809.csv replaceDelimiter  /home/mahalaxmi/temp/temp3.csv"

-- multiclass classification (https://console.aws.amazon.com/machinelearning/home?region=us-east-1#/predictor-insight/ml-NcemxohvNYA?tabId=summary)
select cast(id_info as JSON), official_title, cast(study_design_info as JSON), cast(sponsors as JSON), overall_status,
cast(enrollment as JSON), keyword, condition, cast(location as JSON), why_stopped, phase, study_type, number_of_arms,
number_of_groups, condition_browse, intervention_browse, cast(primary_outcome as JSON), cast(secondary_outcome as JSON),
cast(responsible_party as JSON), cast(eligibility as JSON) from hsdlc.ct_studies where overall_status != ''
and overall_status in ('Completed', 'Approved for marketing', 'Withdrawn', 'Terminated', 'Suspended');
https://console.aws.amazon.com/athena/query/results/fb5dfaee-ea61-47e6-be3b-1fed5681364e/csv
aws s3 cp s3://default-query-results-519510601754-us-east-1/fb5dfaee-ea61-47e6-be3b-1fed5681364e.csv ~/projects/ctd/DI_ETL/analytics/predict_clinical_outcome/datasets/

mvn exec:java -Dexec.args="/home/mahalaxmi/projects/ctd/DI_ETL/analytics/predict_clinical_outcome/datasets/fb5dfaee-ea61-47e6-be3b-1fed5681364e.csv replaceDelimiter  /home/mahalaxmi/temp/temp4.csv"

-- binary classification (https://console.aws.amazon.com/machinelearning/home?region=us-east-1#/predictor-insight/ml-wtrQLxxZVlX?tabId=summary)
select id_info.nct_id as trial_id, official_title,phase, study_type, number_of_arms, number_of_groups,

json_extract_scalar(json_parse(keyword), '$[1]') as first_keyword,
json_extract_scalar(json_parse(keyword), '$[2]') as second_keyword,
json_extract_scalar(json_parse(keyword), '$[3]') as third_keyword,

json_extract_scalar(json_parse(condition_browse), '$[1]') as first_condition,
json_extract_scalar(json_parse(condition_browse), '$[2]') as second_condition,
json_extract_scalar(json_parse(condition_browse), '$[3]') as third_condition,

json_extract_scalar(json_parse(intervention_browse), '$[1]') as first_intervention,
json_extract_scalar(json_parse(intervention_browse), '$[2]') as second_intervention,
json_extract_scalar(json_parse(intervention_browse), '$[3]') as third_intervention,

study_design_info.allocation as allocation,
study_design_info.intervention_model as intervention_model,
study_design_info.primary_purpose as primary_purpose,
study_design_info.observational_model as observational_model,
study_design_info.time_perspective as time_perspective,
study_design_info.masking as masking,
sponsors.lead_sponsor.agency_class as lead_sponsor_agency_class,

element_at(sponsors.collaborator, 1).agency_class as first_collaborator_agency_class,
element_at(sponsors.collaborator, 2).agency_class as second_collaborator_agency_class,
element_at(sponsors.collaborator, 3).agency_class as third_collaborator_agency_class,

enrollment.type as enrollment_type,
enrollment.text_node_value as enrollment_value,

element_at(location, 1).facility.address.zip as first_location_zip,
element_at(location, 1).facility.address.country as first_location_country,
element_at(element_at(location, 1).investigator, 1).degrees as first_location_first_vestigator_degrees,
element_at(element_at(location, 1).investigator, 2).degrees as first_location_second_vestigator_degrees,
element_at(element_at(location, 1).investigator, 3).degrees as first_location_third_vestigator_degrees,

element_at(location, 2).facility.address.zip as second_location_zip,
element_at(location, 2).facility.address.country as second_location_country,
element_at(element_at(location, 2).investigator, 1).degrees as second_location_first_investigator_degrees,
element_at(element_at(location, 2).investigator, 2).degrees as second_location_second_vestigator_degrees,
element_at(element_at(location, 2).investigator, 3).degrees as second_location_third_vestigator_degrees,

element_at(location, 3).facility.address.zip as third_location_zip,
element_at(location, 3).facility.address.country as third_location_country,
element_at(element_at(location, 3).investigator, 1).degrees as third_location_first_investigator_degrees,
element_at(element_at(location, 3).investigator, 2).degrees as third_location_second_vestigator_degrees,
element_at(element_at(location, 3).investigator, 3).degrees as third_location_third_vestigator_degrees,

element_at(primary_outcome, 1).measure as first_primary_outcome_measure,
element_at(primary_outcome, 2).measure as second_primary_outcome_measure,
element_at(primary_outcome, 3).measure as third_primary_outcome_measure,

element_at(secondary_outcome, 1).measure as first_secondary_outcome_outcome_measure,
element_at(secondary_outcome, 2).measure as second_secondary_outcome_outcome_measure,
element_at(secondary_outcome, 3).measure as third_secondary_outcome_outcome_measure,

responsible_party.responsible_party_type as responsible_party_type,

biospec_descr.textblock as biospec,
eligibility.study_pop.textblock as eligibility_study_population,
eligibility.sampling_method as eligibility_sampling_method,
eligibility.gender_based as eligibility_gender_based,
eligibility.gender as eligibility_gender,
eligibility.minimum_age as eligibility_minimum_age,
eligibility.maximum_age as eligibility_maximum_age,
eligibility.healthy_volunteers as eligibility_healthy_volunteers,

case when overall_status = 'Completed' then 'Completed'
     when overall_status = 'Approved for marketing' then 'Completed'
     else 'Did not complete'
     end as status

from hsdlc.ct_studies
where overall_status in ('Completed', 'Approved for marketing', 'Withdrawn', 'Terminated', 'Suspended') ;


https://console.aws.amazon.com/athena/query/results/f958bb55-06be-431c-ae33-0e06b30f5b3b/csv
aws s3 cp s3://default-query-results-519510601754-us-east-1/f958bb55-06be-431c-ae33-0e06b30f5b3b.csv ~/projects/ctd/DI_ETL/analytics/predict_clinical_outcome/datasets/


-- Multi-Class Classification  (v3 in machinelearning - https://console.aws.amazon.com/machinelearning/home?region=us-east-1#/predictor-insight/ml-OJpWMzO47RJ?tabId=summary)

select id_info.nct_id as trial_id, official_title,phase, study_type, number_of_arms, number_of_groups,

json_extract_scalar(json_parse(keyword), '$[1]') as first_keyword,
json_extract_scalar(json_parse(keyword), '$[2]') as second_keyword,
json_extract_scalar(json_parse(keyword), '$[3]') as third_keyword,

json_extract_scalar(json_parse(condition_browse), '$[1]') as first_condition,
json_extract_scalar(json_parse(condition_browse), '$[2]') as second_condition,
json_extract_scalar(json_parse(condition_browse), '$[3]') as third_condition,

json_extract_scalar(json_parse(intervention_browse), '$[1]') as first_intervention,
json_extract_scalar(json_parse(intervention_browse), '$[2]') as second_intervention,
json_extract_scalar(json_parse(intervention_browse), '$[3]') as third_intervention,

study_design_info.allocation as allocation,
study_design_info.intervention_model as intervention_model,
study_design_info.primary_purpose as primary_purpose,
study_design_info.observational_model as observational_model,
study_design_info.time_perspective as time_perspective,
study_design_info.masking as masking,
sponsors.lead_sponsor.agency_class as lead_sponsor_agency_class,

element_at(sponsors.collaborator, 1).agency_class as first_collaborator_agency_class,
element_at(sponsors.collaborator, 2).agency_class as second_collaborator_agency_class,
element_at(sponsors.collaborator, 3).agency_class as third_collaborator_agency_class,

enrollment.type as enrollment_type,
enrollment.text_node_value as enrollment_value,

element_at(location, 1).facility.address.zip as first_location_zip,
element_at(location, 1).facility.address.country as first_location_country,
element_at(element_at(location, 1).investigator, 1).degrees as first_location_first_vestigator_degrees,
element_at(element_at(location, 1).investigator, 2).degrees as first_location_second_vestigator_degrees,
element_at(element_at(location, 1).investigator, 3).degrees as first_location_third_vestigator_degrees,

element_at(location, 2).facility.address.zip as second_location_zip,
element_at(location, 2).facility.address.country as second_location_country,
element_at(element_at(location, 2).investigator, 1).degrees as second_location_first_investigator_degrees,
element_at(element_at(location, 2).investigator, 2).degrees as second_location_second_vestigator_degrees,
element_at(element_at(location, 2).investigator, 3).degrees as second_location_third_vestigator_degrees,

element_at(location, 3).facility.address.zip as third_location_zip,
element_at(location, 3).facility.address.country as third_location_country,
element_at(element_at(location, 3).investigator, 1).degrees as third_location_first_investigator_degrees,
element_at(element_at(location, 3).investigator, 2).degrees as third_location_second_vestigator_degrees,
element_at(element_at(location, 3).investigator, 3).degrees as third_location_third_vestigator_degrees,

element_at(primary_outcome, 1).measure as first_primary_outcome_measure,
element_at(primary_outcome, 2).measure as second_primary_outcome_measure,
element_at(primary_outcome, 3).measure as third_primary_outcome_measure,

element_at(secondary_outcome, 1).measure as first_secondary_outcome_outcome_measure,
element_at(secondary_outcome, 2).measure as second_secondary_outcome_outcome_measure,
element_at(secondary_outcome, 3).measure as third_secondary_outcome_outcome_measure,

responsible_party.responsible_party_type as responsible_party_type,

eligibility.study_pop.textblock as eligibility_study_population,
eligibility.sampling_method as eligibility_sampling_method,
eligibility.gender_based as eligibility_gender_based,
eligibility.gender as eligibility_gender,
eligibility.minimum_age as eligibility_minimum_age,
eligibility.maximum_age as eligibility_maximum_age,
eligibility.healthy_volunteers as eligibility_healthy_volunteers,

overall_status

from hsdlc.ct_studies
where overall_status in ('Completed', 'Approved for marketing', 'Withdrawn', 'Terminated', 'Suspended') ;

https://console.aws.amazon.com/athena/query/results/0a8c8d78-4ccf-4da4-a3b6-1fcd5c368475/csv
aws s3 cp s3://default-query-results-519510601754-us-east-1/0a8c8d78-4ccf-4da4-a3b6-1fcd5c368475.csv ~/projects/ctd/DI_ETL/analytics/predict_clinical_outcome/datasets/


-- binary classification ()
select id_info.nct_id as trial_id, official_title,phase, study_type, number_of_arms, number_of_groups, target_duration,

json_extract_scalar(json_parse(keyword), '$[1]') as first_keyword,
json_extract_scalar(json_parse(keyword), '$[2]') as second_keyword,
json_extract_scalar(json_parse(keyword), '$[3]') as third_keyword,
json_extract_scalar(json_parse(keyword), '$[4]') as fourth_keyword,
json_extract_scalar(json_parse(keyword), '$[5]') as fifth_keyword,

json_extract_scalar(json_parse(condition_browse), '$[1]') as first_condition,
json_extract_scalar(json_parse(condition_browse), '$[2]') as second_condition,
json_extract_scalar(json_parse(condition_browse), '$[3]') as third_condition,
json_extract_scalar(json_parse(condition_browse), '$[4]') as fourth_condition,
json_extract_scalar(json_parse(condition_browse), '$[5]') as fifth_condition,

json_extract_scalar(json_parse(intervention_browse), '$[1]') as first_intervention,
json_extract_scalar(json_parse(intervention_browse), '$[2]') as second_intervention,
json_extract_scalar(json_parse(intervention_browse), '$[3]') as third_intervention,
json_extract_scalar(json_parse(intervention_browse), '$[4]') as fourth_intervention,
json_extract_scalar(json_parse(intervention_browse), '$[5]') as fifth_intervention,

study_design_info.allocation as allocation,
study_design_info.intervention_model as intervention_model,
study_design_info.primary_purpose as primary_purpose,
study_design_info.observational_model as observational_model,
study_design_info.time_perspective as time_perspective,
study_design_info.masking as masking,
sponsors.lead_sponsor.agency_class as lead_sponsor_agency_class,

element_at(sponsors.collaborator, 1).agency_class as first_collaborator_agency_class,
element_at(sponsors.collaborator, 2).agency_class as second_collaborator_agency_class,
element_at(sponsors.collaborator, 3).agency_class as third_collaborator_agency_class,
element_at(sponsors.collaborator, 4).agency_class as fourth_collaborator_agency_class,
element_at(sponsors.collaborator, 5).agency_class as fifth_collaborator_agency_class,

enrollment.type as enrollment_type,
enrollment.text_node_value as enrollment_value,

element_at(location, 1).facility.address.zip as first_location_zip,
element_at(location, 1).facility.address.country as first_location_country,

element_at(location, 2).facility.address.zip as second_location_zip,
element_at(location, 2).facility.address.country as second_location_country,

element_at(location, 3).facility.address.zip as third_location_zip,
element_at(location, 3).facility.address.country as third_location_country,

element_at(location, 4).facility.address.zip as fourth_location_zip,
element_at(location, 4).facility.address.country as fourth_location_country,

element_at(location, 5).facility.address.zip as fifth_location_zip,
element_at(location, 5).facility.address.country as fifth_location_country,

element_at(primary_outcome, 1).measure as first_primary_outcome_measure,
element_at(primary_outcome, 2).measure as second_primary_outcome_measure,
element_at(primary_outcome, 3).measure as third_primary_outcome_measure,
element_at(primary_outcome, 4).measure as fourth_primary_outcome_measure,
element_at(primary_outcome, 5).measure as fifth_primary_outcome_measure,

element_at(secondary_outcome, 1).measure as first_secondary_outcome_measure,
element_at(secondary_outcome, 2).measure as second_secondary_outcome_measure,
element_at(secondary_outcome, 3).measure as third_secondary_outcome_measure,
element_at(secondary_outcome, 4).measure as fourth_secondary_outcome_measure,
element_at(secondary_outcome, 5).measure as fifth_secondary_outcome_measure,

element_at(other_outcome, 1).measure as first_other_outcome_measure,
element_at(other_outcome, 2).measure as second_other_outcome_measure,
element_at(other_outcome, 3).measure as third_other_outcome_measure,
element_at(other_outcome, 4).measure as fourth_other_outcome_measure,
element_at(other_outcome, 5).measure as fifth_other_outcome_measure,

eligibility.sampling_method as eligibility_sampling_method,
eligibility.gender as eligibility_gender,
eligibility.minimum_age as eligibility_minimum_age,
eligibility.maximum_age as eligibility_maximum_age,
eligibility.healthy_volunteers as eligibility_healthy_volunteers,


oversight_info.has_dmc has_dmc,
oversight_info.is_fda_regulated_drug is_fda_regulated_drug,
oversight_info.is_fda_regulated_device is_fda_regulated_device,
oversight_info.is_unapproved_device is_unapproved_device,
oversight_info.is_ppsd is_ppsd,
oversight_info.is_us_export is_us_export,

responsible_party.responsible_party_type as responsible_party_type,
responsible_party.investigator_affiliation as investigator_affiliation,
responsible_party.invewastigator_title as invewastigator_title,

case when overall_status = 'Completed' then 'Completed'
     when overall_status = 'Approved for marketing' then 'Completed'
     else 'Did not complete'
     end as status

from hsdlc.ct_studies
where overall_status in ('Completed', 'Approved for marketing', 'Withdrawn', 'Terminated', 'Suspended') ;


https://console.aws.amazon.com/athena/query/results/5e7a096a-0619-46d5-9e38-a41eccf96fa1/csv
aws s3 cp s3://default-query-results-519510601754-us-east-1/5e7a096a-0619-46d5-9e38-a41eccf96fa1.csv ~/projects/ctd/DI_ETL/analytics/predict_clinical_outcome/datasets/
