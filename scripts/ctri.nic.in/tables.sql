CREATE EXTERNAL TABLE `ctri`.`studies`(
`S3FilePath` string,
`FileGUID` string,
`Source` string,
`Sector` string,
`Organization` string,
`ctri number ` string,
`registered on: ` string,
`last modified on: ` string,
`post graduate thesis ` string,
`type of study ` string,
`type of trial ` string,
`study design ` string,
`public title of study ` string,
`scientific title of study ` string,
`secondary ids if any ` string,
`details of principal investigator or overall trial coordinator (multi-center study) ` string,
`details of contact person scientific query ` string,
`details of contact person public query ` string,
`source of monetary or material support ` string,
`primary sponsor ` string,
`details of secondary sponsor ` string,
`countries of recruitment ` string,
`sites of study ` string,
`details of ethics committee ` string,
`regulatory clearance status from dcgi ` string,
`health condition / problems studied ` string,
`intervention / comparator agent ` string,
`inclusion criteria ` string,
`exclusioncriteria ` string,
`method of generating random sequence ` string,
`method of concealment ` string,
`blinding/masking ` string,
`primary outcome ` string,
`secondary outcome ` string,
`target sample size ` string,
`phase of trial ` string,
`date of first enrollment (india) ` string,
`date of study completion (india) ` string,
`date of first enrollment (global) ` string,
`date of study completion (global) ` string,
`estimated duration of trial ` string,
`recruitment status of trial (global) ` string,
`recruitment status of trial (india) ` string,
`publication details ` string,
`brief summary ` string)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '~'
STORED AS INPUTFORMAT
'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
's3://datainsights-results/ctri.nic.in/analysis/'
TBLPROPERTIES (
'classification'='csv',
'columnsOrdered'='true',
'compressionType'='gzip',
'delimiter'='~',
'skip.header.line.count'='1',
'typeOfData'='file')