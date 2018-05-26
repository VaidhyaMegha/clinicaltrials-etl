CREATE EXTERNAL TABLE `ct_studies_new` (
  `overall_official`:array<struct
    <
      `first_name` :string,
      `middle_name` :string,
      `last_name` :string,
      `degrees` :string,
      `role` :string,
      `affiliation` :string
    >
  >,
`overall_contact` struct<
  `first_name` :string,
  `middle_name` :string,
  `last_name` :string,
  `degrees` :string,
  `phone` :string,
  `phone_ext` :string,
  `email` :string
  >,
`overall_contact_backup` struct<
  `first_name`:srting,
  `middle_name`:srting,
  `last_name`:srting,
  `degrees`:srting,
  `phone`:srting,
  `phone_ext`:srting,
  `email`:srting
  >,
`oversight_info` struct<
  `has_dmc`:string,
  `is_fda_regulated_drug`:string,
  `is_fda_regulated_device`:string,
  `is_unapproved_device`:string,
  `is_ppsd`:string,
  `is_us_export`:string
  >,
`arm_group` struct<
  `arm_group_label` :string,
  `arm_group_type` :string,
  `description` :string
  >,
`expanded_access_info struct<
  `expanded_access_type_individual`:string,
  `expanded_access_type_intermediate`:string,
  `expanded_access_type_treatment`:string
  >,
`study_design_info` struct<
 `allocation`:string,
 `intervention_model`:string,
 `intervention_model_description`:string,
 `primary_purpose`:string,
 `observational_model`:string,
 `time_perspective`:string,
 `masking`:string,
 `masking_description`:string
>,
`required_header` struct<
`download_date`:string,
`link_text`:string,
`url`:string
>,
`id_info` struct<
`org_study_id`:string,
`secondary_id`:string,
`nct_id`:string
>,
`brief_title` string,
`official_title` string,
`sponsors` struct<
`lead_sponsor`:struct<
`agency`:string,
`agency_class`:string
>,
`collaborator`:struct<
`agency`:string,
`agency_class`:string
>
>,
`source` string,
`oversight_info` struct<
`has_dmc`:string
>,
`brief_summary` struct<
`textblock`:string
>,
`overall_status` string,
`why_stopped` string,
`start_date` string,
`completion_date` struct<
`type`:string,
`text`:string
>,
`primary_completion_date` struct<
`type`:string,
`text`:string
>,
`phase` string,
`study_type` string,
`has_expanded_access` string,
`study_design_info` struct<
`allocation`:string,
`intervention_model`:string,
`primary_purpose`:string,
`masking`:string
>,
`primary_outcome` struct<
`measure`:string,
`time_frame`:string,
`description`:string
>,
`secondary_outcome` struct<
`measure`:string,
`time_frame`:string
>,
`number_of_arms` string,
`enrollment` struct<
`type`:string,
`text`:string
>,
`condition` string,
`arm_group` array<struct<
`arm_group_label`:string,
`arm_group_type`:string,
`description`:string
>>,
`intervention` array<struct<
`intervention_type`:string,
`intervention_name`:string,
`arm_group_label`:array<string>
>>,
`eligibility` struct<
`criteria`:struct<
`textblock`:string
>,
`gender`:string,
`minimum_age`:string,
`maximum_age`:string,
`healthy_volunteers`:string
>,
`location` struct<
`facility`:struct<
`name`:string,
`address`:struct<
`city`:string,
`state`:string,
`zip`:string,
`country`:string
>
>
>,
`location_countries` struct<
`country`:string
>,
`verification_date` struct<
`tail`:string,
`text`:string
>,
`study_first_submitted` string,
`study_first_submitted_qc` string,
`study_first_posted` struct<
`type`:string,
`text`:string
>,
`last_update_submitted` string,
`last_update_submitted_qc` string,
`last_update_posted` struct<
`type`:string,
`text`:string
>,
`responsible_party` struct<
`responsible_party_type`:string,
`investigator_affiliation`:string,
`investigator_full_name`:string,
`investigator_title`:string
>,
`condition_browse` struct<
`mesh_term`:array<string>
>,
`intervention_browse` struct<
`mesh_term`:array<string>
>
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://datainsights-results/temp/AllPublicXMLs/NCT0338xxxx/';


--  createtab_stmt
----------------------------------------------------------------------
 CREATE EXTERNAL TABLE `studies`(
 `nct_id` string,
 `nlm_download_date_description` string,
 `first_received_date` string,
 `last_changed_date` string,
 `first_received_results_date` string,
 `received_results_disposit_date` string,
 `study_first_submitted_date` string,
 `results_first_submitted_date` string,
 `disposition_first_submitted_date` string,
 `last_update_submitted_date` string,
 `study_first_submitted_qc_date` string,
 `study_first_posted_date` string,
 `study_first_posted_date_type` string,
 `results_first_submitted_qc_date` string,
 `results_first_posted_date` string,
 `results_first_posted_date_type` string,
 `disposition_first_submitted_qc_date` string,
 `disposition_first_posted_date` string,
 `disposition_first_posted_date_type` string,
 `last_update_submitted_qc_date` string,
 `last_update_posted_date` string,
 `last_update_posted_date_type` string,
 `start_month_year` string,
 `start_date_type` string,
 `start_date` string,
 `verification_month_year` string,
 `verification_date` string,
 `completion_month_year` string,
 `completion_date_type` string,
 `completion_date` string,
 `primary_completion_month_year` string,
 `primary_completion_date_type` string,
 `primary_completion_date` string,
 `target_duration` string,
 `study_type` string,
 `acronym` string,
 `baseline_population` string,
 `brief_title` string,
 `official_title` string,
 `overall_status` string,
 `last_known_status` string,
 `phase` string,
 `enrollment` bigint,
 `enrollment_type` string,
 `source` string,
 `limitations_and_caveats` string,
 `number_of_arms` bigint,
 `number_of_groups` bigint,
 `why_stopped` string,
 `has_expanded_access` string,
 `expanded_access_type_individual` string,
 `expanded_access_type_intermediate` string,
 `expanded_access_type_treatment` string,
 `has_dmc` string,
 `is_fda_regulated_drug` string,
 `is_fda_regulated_device` string,
 `is_unapproved_device` string,
 `is_ppsd` string,
 `is_us_export` string,
 `biospec_retention` string,
 `biospec_description` string,
 `plan_to_share_ipd` string,
 `plan_to_share_ipd_description` string,
 `created_at` string,
 `updated_at` string)
 PARTITIONED BY (
 `partition_0` string)
 ROW FORMAT DELIMITED
 FIELDS TERMINATED BY '|'
 STORED AS INPUTFORMAT
 'org.apache.hadoop.mapred.TextInputFormat'
 OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
 LOCATION
 's3://datainsights-in/clinicaltrials/aact/studies/'
 TBLPROPERTIES (
 'CrawlerSchemaDeserializerVersion'='1.0',
 'CrawlerSchemaSerializerVersion'='1.0',
 'UPDATED_BY_CRAWLER'='CT',
 'averageRecordSize'='747',
 'classification'='csv',
 'columnsOrdered'='true',
 'compressionType'='none',
 'delimiter'='|',
 'exclusions'='[\"s3://datainsights-in/clinicaltrials/aact/*.zip\"]',
 'objectCount'='1',
 'recordCount'='251391',
 'sizeKey'='187789699',
 'skip.header.line.count'='1',
 'typeOfData'='file')
