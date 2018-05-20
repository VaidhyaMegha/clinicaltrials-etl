CREATE EXTERNAL TABLE `Global_registries`(
           `ctd_id`,
           `ctri_number`,
           `nct_id`,
           `secondary_ids`,
           `identifiers`,
           `Date_Of_Registration`,
           `study_type`,
           `Public_title`,
           `Scientific_title`,
           `brief_summary`,
           `phase`,
           `exclusion_criteria`,
           `inclusion_criteria`,
           `sample_size`,
           `recruitment_status`,
           `primary_outcome`,
           `secondary_outcome`,
           `intervention`,
           `enrollment_type`,
           `ethics_review`,
           `primary_sponsor`,
           `secondary_sponsor`,
           `public_query_contact` ,
           `scientific_query_contact`,
           `CompletionDate`
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