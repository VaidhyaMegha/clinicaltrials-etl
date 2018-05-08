--  createtab_stmt
--------------------------------------------------------------
 CREATE EXTERNAL TABLE `studies`(
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
 'transient_lastDdlTime'='1524484063',
 'typeOfData'='file')
