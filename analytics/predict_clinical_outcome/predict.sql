 CREATE EXTERNAL TABLE `ct_studies`(
 `participant_flow` struct<recruitment_details:string,pre_assignment_details:string,group_list:struct<group:array<struct<title:string,description:string,group_id:string>>>,period_list:struct<period:array<
 `baseline` struct<population:string,group_list:struct<group:array<struct<title:string,description:string,group_id:string>>>,analyzed_list:struct<analyzed:array<struct<units:string,scope:string,count_list
 `outcome_list` struct<outcome:array<struct<type:string,title:string,description:string,time_frame:string,safety_issue:string,posting_date:string,population:string,group_list:struct<group:array<struct<tit
 `reported_events` struct<time_frame:string,desc:string,group_list:struct<group:array<struct<title:string,description:string,group_id:string>>>,serious_events:struct<frequency_threshold:string,default_voc
 `certain_agreements` struct<pi_employee:string,restrictive_agreement:string>,
 `limitations_and_caveats` string,
 `point_of_contact` struct<name_or_title:string,organization:string,phone:string,email:string>,
 `patient_data` struct<sharing_ipd:string,ipd_description:string>,
 `study_docs` struct<study_doc:array<struct<doc_id:string,doc_type:string,doc_url:string,doc_comment:string>>>,
 `responsible_party` struct<responsible_party_type:string,investigator_affiliation:string,investigator_full_name:string,invewastigator_title:string>,
 `intervention` array<struct<intervention_type:string,intervention_name:string,description:string,arm_group_label:string,other_name:string>>,
 `eligibility` struct<study_pop:struct<textblock:string>,sampling_method:string,criteria:struct<textblock:string>,gender:string,gender_based:string,minimum_age:string,maximum_age:string,healthy_volunteers
 `overall_official` array<struct<first_name:string,middle_name:string,last_name:string,degrees:string,role:string,affiliation:string>>,
 `overall_contact` struct<first_name:string,middle_name:string,last_name:string,degrees:string,phone:string,phone_ext:string,email:string>,
 `overall_contact_backup` struct<first_name:string,middle_name:string,last_name:string,degrees:string,phone:string,phone_ext:string,email:string>,
 `oversight_info` struct<has_dmc:string,is_fda_regulated_drug:string,is_fda_regulated_device:string,is_unapproved_device:string,is_ppsd:string,is_us_export:string>,
 `arm_group` struct<arm_group_label:string,arm_group_type:string,description:string>,
 `expanded_access_info` struct<expanded_access_type_individual:string,expanded_access_type_intermediate:string,expanded_access_type_treatment:string>,
 `study_design_info` struct<allocation:string,intervention_model:string,intervention_model_description:string,primary_purpose:string,observational_model:string,time_perspective:string,masking:string,maski
 `required_header` struct<download_date:string,link_text:string,url:string>,
 `id_info` struct<org_study_id:string,secondary_id:array<string>,nct_id:string,nct_alias:array<string>>,
 `brief_title` string,
 `acronym` string,
 `official_title` string,
 `sponsors` struct<lead_sponsor:struct<agency:string,agency_class:string>,collaborator:array<struct<agency:string,agency_class:string>>>,
 `source` string,
 `why_stopped` string,
 `target_duration` string,
 `overall_status` string,
 `last_known_status` string,
 `phase` string,
 `study_type` string,
 `has_expanded_access` string,
 `biospec_retention` string,
 `number_of_arms` string,
 `number_of_groups` string,
 `verification_date` string,
 `study_first_submitted` string,
 `study_first_submitted_qc` string,
 `results_first_submitted` string,
 `results_first_submitted_qc` string,
 `disposition_first_submitted` string,
 `disposition_first_submitted_qc` string,
 `last_update_submitted` string,
 `last_update_submitted_qc` string,
 `enrollment` struct<type:string,text_node_value:string>,
 `study_first_posted` struct<type:string,text_node_value:string>,
 `results_first_posted` struct<type:string,text_node_value:string>,
 `disposition_first_posted` struct<type:string,text_node_value:string>,
 `last_update_posted` struct<type:string,text_node_value:string>,
 `completion_date` struct<type:string,text_node_value:string>,
 `start_date` struct<type:string,text_node_value:string>,
 `primary_completion_date` struct<type:string,text_node_value:string>,
 `brief_summary` struct<textblock:string>,
 `detailed_description` struct<textblock:string>,
 `biospec_descr` struct<textblock:string>,
 `keyword` string,
 `condition` string,
 `primary_outcome` array<struct<measure:string,time_frame:string,description:string>>,
 `secondary_outcome` array<struct<measure:string,time_frame:string,description:string>>,
 `other_outcome` array<struct<measure:string,time_frame:string,description:string>>,
 `reference` array<struct<citation:string,pmid:string>>,
 `results_reference` array<struct<citation:string,pmid:string>>,
 `link` array<struct<url:string,description:string>>,
 `location` array<struct<facility:struct<name:string,address:struct<city:string,state:string,zip:string,country:string>>,status:string,contact:struct<first_name:string,middle_name:string,last_name:string,
 `location_countries` string,
 `removed_countries` string,
 `condition_browse` string,
 `intervention_browse` string)
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


