CREATE EXTERNAL TABLE `global_registries`(
  `trialid` string , 
  `secondary_id` string,  
  `date_of_registration` string ,  
  `public_title` string , 
  `scientific_title` string ,  
  `study_type` string , 
  `date_of_first_enrollment` string , 
  `enrollment` string , 
  `recruitmentstatus` string ,
  `CompletionDate` string,
  `registry` string,
  `source_json` string )
ROW FORMAT SERDE 
  'org.openx.data.jsonserde.JsonSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://hsdlc-results/utdm-adapter/json'
TBLPROPERTIES (
  'ignore.malformed.json'='true')