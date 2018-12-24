CREATE EXTERNAL TABLE `icij_manufacturers`(
`id` string,
`address` string,
`comment` string,
`name` string,
`parent_company` string,
`representative` string,
`slug` string,
`source` string,
`created_at` string,
`updated_at` string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ("separatorChar" = ",", "escapeChar" = "\\")
LOCATION 's3://hsdlc-results/public_datasets/icij/imddb/manufacturers/'
TBLPROPERTIES ('skip.header.line.count'='1')
;