CREATE EXTERNAL TABLE `cris_studies`(
 `cris_registration_number` string,
  `unique_protocol id` string,
  `public_or_brief_title` string,
  `scientific_title` string,
  `mfds_regulated_study` string,
  `registered_at_other_registry` string,
  `board_approval_status` string,
  `board_approval_number` string,
  `approval_date` string,
 `institutional_review_board`:struct<name:string,adress:string,telephone:string>,
 `data_monitoring_committee` string,
 `contact_details` array<map<string,string>>,
 `study_site`  string,
 `overall_recruitment_status`  string,
 `date_of_first_enrollment`  string,
 `target_number_of_participant` string,
 `primary_completion_date`  string,
 `study_completion_date` string,
 `recruitment_status_by_participating_study_site` array<map<string,string>>,
 `source_of_monetary_material_support` array<map<string,string>>,
 `sponsor_organization` array<map<string,string>>,
 `lay_summary` string,
 `study_type` string,
 `study_purpose` string,
 `phase` string,
 `intervention_model` string,
 `blinding_or_masking` string,
 `allocation` string,
 `intervention_type` string,
 `intervention_description` string,
 `number_of_arms` string,
 `arms` array<map<string,string>>,
 `conditions_or_problems` string,
 `rare_disease` string,
 `inclusion_criteria`:struct<gender:string,age:string,description:string>,
 `exclusion_criteria` string,
 `healthy_volunteers` string,
 `type_of_primary_income` string,
 `primary_outcome` array<map<string,string>>,
 `secondary_outcome` array<map<string,string>>,
 `result_registered` string,
 `sharing_statement` string
 )
  ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
      LOCATION 's3://hsdlc-results/cristr-adapter/studies/json'
      TBLPROPERTIES (
      'ignore.malformed.json'= 'true'
      );