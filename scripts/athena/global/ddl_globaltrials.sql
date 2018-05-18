REATE EXTERNAL TABLE `Global_registries`(
         `ctri_number` string,
         `nct_id` string,
         `identifiers` string,   
         `secondary_ids` string, 
         `Date_Of_Registration` string
         `Study_type` string,
         `Public_title` string,
         `Scientific_title` string,
         `brief_summary` string,
         `phase` string,
         `exclusion_criteria string,
         `inclusion_criteria` string,
         `sample_size` string,
         `ctris_recruitment_status_global` string,
         `ctris_recruitment_status_india` string,
         `cts_recruitment_status` string,
         `trials_recruitment_status` string,
         `recruitment_status` string,
         `primary_outcome` string,
         `secondary_outcome` string,
         `intervention` string,
         `erollment_type` string,
         `ethics_review` string,
         `primary_sponsor` string,
         `secondary_sponsor` string,
         `public_query_contact` string,
         `scientific_query_contact` string,
         `ctris_date_of_completion_global` DATE,
         `ctris_date_of_completion_india` DATE,
         `completion_date` DATE` 
 ROW FORMAT DELIMITED
 FIELDS TERMINATED BY '\t'
 STORED AS INPUTFORMAT
 'org.apache.hadoop.mapred.TextInputFormat'
 OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
 LOCATION
 ''
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
