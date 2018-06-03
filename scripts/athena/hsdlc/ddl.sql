-- $ athena --schema global --execute 'show create table ct_studies' >> scripts/db/global/ct_studies.sql
-- $ athena --schema global --execute 'show create table ctri_studies' >> scripts/db/global/ctri_studies.sql
-- $ athena --schema global --execute 'show create table trials' >> scripts/db/global/ot_trials.sql


--  createtab_stmt
--------------------------------------------------------------
CREATE EXTERNAL TABLE `Global_registries`(
           `ctd_id` string,
           `ctri_number` string,
           `nct_id` string,
           `secondary_ids` string,
           `identifiers` string,
           `Date_Of_Registration` string,
           `study_type` string,
           `Public_title` string,
           `Scientific_title` string,
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
           `CompletionDate` string)
 ROW FORMAT DELIMITED
 FIELDS TERMINATED BY '\t'
 STORED AS INPUTFORMAT
 'org.apache.hadoop.mapred.TextInputFormat'
 OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
 LOCATION
 's3://datainsights-results/temp/global/athena/ctd_utdm'
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