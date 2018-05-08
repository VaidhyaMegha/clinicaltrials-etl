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
 'transient_lastDdlTime'='1524549129',
 'typeOfData'='file')
