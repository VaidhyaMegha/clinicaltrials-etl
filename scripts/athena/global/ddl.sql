-- $ athena --schema global --execute 'show create table ct_studies' >> scripts/db/global/ddl.sql
-- $ athena --schema global --execute 'show create table ctri_studies' >> scripts/db/global/ddl.sql
-- $ athena --schema global --execute 'show create table trials' >> scripts/db/global/ddl.sql

--  createtab_stmt
-- ---------------------------------------------------------------

CREATE EXTERNAL TABLE `global_registries`(
 `ctd_id` string,
 `ctri_number` string,
 `nct_id` string,
 `secondary_ids` string,
 `identifiers` string,
 `date_of_registration` string,
 `study_type` string,
 `public_title` string,
 `scientific_title` string,
 `brief_summary` string,
 `phase` string,
 `exclusion_criteria` string,
 `inclusion_criteria` string,
 `sample_size` string,
 `recruitment_status` string,
 `primary_outcome` string,
 `secondary_outcome` string,
 `intervention` string,
 `enrollment_type` string,
 `ethics_review` string,
 `primary_sponsor` string,
 `secondary_sponsor` string,
 `public_query_contact` string,
 `scientific_query_contact` string,
 `completiondate` string)
 ROW FORMAT DELIMITED
 FIELDS TERMINATED BY '|'
 STORED AS INPUTFORMAT
 'org.apache.hadoop.mapred.TextInputFormat'
 OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
 LOCATION
 's3://datainsights-results/temp/global/athena/ctd_utdm'
 TBLPROPERTIES (
 'classification'='csv',
 'columnsOrdered'='true',
 'delimiter'='|',
 'escapeChar'='\\',
 'quoteChar'='\"')


 CREATE EXTERNAL TABLE `ct_studies`(
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
 ROW FORMAT DELIMITED
 FIELDS TERMINATED BY '|'
 STORED AS INPUTFORMAT
 'org.apache.hadoop.mapred.TextInputFormat'
 OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
 LOCATION
 's3://datainsights-in/clinicaltrials/aact/studies/partition1'
 TBLPROPERTIES (
 'classification'='csv',
 'columnsOrdered'='true',
 'compressionType'='none',
 'delimiter'='|',
 'skip.header.line.count'='1',
 'transient_lastDdlTime'='1525783091',
 'typeOfData'='file')



--  createtab_stmt
--------------------------------------------------------------
 CREATE EXTERNAL TABLE `ctri_studies`(
 `s3_file_path` string,
 `file_guid` string,
 `source` string,
 `sector` string,
 `organization` string,
 `ctri_number` string,
 `registered_on` string,
 `last_modified_on` string,
 `pg_thesis` string,
 `type_of_study` string,
 `type_of_trial` string,
 `study_design` string,
 `public_title` string,
 `scientific_title` string,
 `secondary_ids` string,
 `pi_or_tc` string,
 `scientific_query_contact` string,
 `public_query_contact` string,
 `support_source` string,
 `primary_sponsor` string,
 `secondary_sponsor` string,
 `countries_of_recruitment` string,
 `sites` string,
 `ethics_committee` string,
 `regulatory_clearance_status` string,
 `condition_or_problems` string,
 `intervention_or_comparator_agent` string,
 `inclusion_criteria` string,
 `exclusion_criteria` string,
 `method_of_generating_random_sequence` string,
 `method_of_concealment` string,
 `blinding_and_masking` string,
 `primary_outcome` string,
 `secondary_outcome` string,
 `target_sample_size` string,
 `phase` string,
 `date_of_first_enrollment_india` string,
 `date_of_completion_india` string,
 `date_of_first_enrollment_global` string,
 `date_of_completion_global` string,
 `estimated_duration` string,
 `recruitment_status_global` string,
 `recruitment_status_india` string,
 `publication_details` string,
 `brief_summary` string)
 ROW FORMAT DELIMITED
 FIELDS TERMINATED BY '~'
 STORED AS INPUTFORMAT
 'org.apache.hadoop.mapred.TextInputFormat'
 OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
 LOCATION
 's3://datainsights-results/ctri.nic.in/analysis'
 TBLPROPERTIES (
 'classification'='csv',
 'columnsOrdered'='true',
 'compressionType'='gzip',
 'delimiter'='~',
 'skip.header.line.count'='1',
 'transient_lastDdlTime'='1525780589',
 'typeOfData'='file')

--  createtab_stmt
--------------------------------------------------------------
 CREATE EXTERNAL TABLE `trials`(
 `id` string,
 `identifiers` string,
 `registration_date` string,
 `public_title` string,
 `brief_summary` string,
 `scientific_title` string,
 `description` string,
 `recruitment_status` string,
 `eligibility_criteria` string,
 `target_sample_size` bigint,
 `first_enrollment_date` string,
 `study_type` string,
 `study_design` string,
 `study_phase` string,
 `primary_outcomes` string,
 `secondary_outcomes` string,
 `created_at` string,
 `updated_at` string,
 `has_published_results` string,
 `gender` string,
 `source_id` string,
 `status` string,
 `completion_date` string,
 `results_exemption_date` string,
 `age_range` struct<max_age:string,min_age:string>)
 ROW FORMAT DELIMITED
 FIELDS TERMINATED BY '\t'
 STORED AS INPUTFORMAT
 'org.apache.hadoop.mapred.TextInputFormat'
 OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
 LOCATION
 's3://datainsights-results/opentrials.net/trials2'
 TBLPROPERTIES (
 'classification'='csv',
 'columnsOrdered'='true',
 'compressionType'='gzip',
 'delimiter'='\t',
 'escapeChar'='\\',
 'quoteChar'='\"',
 'skip.header.line.count'='1',
 'transient_lastDdlTime'='1525701880',
 'typeOfData'='file')
