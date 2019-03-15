CREATE EXTERNAL TABLE symptoms_diseases
(
disease varchar(100),
fever_greater_than_100 varchar (5),
fever_less_than_100 varchar (5)
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ("separatorChar" = ",", "escapeChar" = "\\")
LOCATION 's3://hsdlc-results/public_health/ph_kdb/'
TBLPROPERTIES (
  "skip.header.line.count"="1")
