CREATE EXTERNAL TABLE `icij_events`(
`id` string,
`action` string,
`action_classification` string,
`action_level` string,
`action_summary` string,
`authorities_link` string,
`country` string,
`create_date` string,
`data_notes` string,
`date` string,
`date_initiated_by_firm` string,
`date_posted` string,
`date_terminated` string,
`date_updated` string,
`determined_cause` string,
`documents` string,
`icij_notes` string,
`number` string,
`reason` string,
`source` string,
`status` string,
`target_audience` string,
`type` string,
`uid` string,
`uid_hash` string,
`url` string,
`slug` string,
`device_id` string,
`created_at` string,
`updated_at` string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ("separatorChar" = ",")
LOCATION 's3://hsdlc-results/public_datasets/icij/imddb/events/'
TBLPROPERTIES ('skip.header.line.count'='1')
;