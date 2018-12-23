CREATE EXTERNAL TABLE `icij_devices`(
`id` string,
`classification` string,
`code` string,
`description` string,
`distributed_to` string,
`implanted` string,
`name` string,
`number` string,
`quantity_in_commerce` string,
`risk_class` string,
`slug` string,
`country` string,
`manufacturer_id` string,
`created_at` string,
`updated_at` string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ("separatorChar" = ",", "escapeChar" = "\\")
LOCATION 's3://hsdlc-results/public_datasets/icij/imddb/devices/'
TBLPROPERTIES ('skip.header.line.count'='1')
;