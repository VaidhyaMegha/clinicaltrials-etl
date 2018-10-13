CREATE EXTERNAL TABLE `fda_contacts`(
`PrimaryDI` string,
`phone` string,
`phoneExtension` string,
`email` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
LOCATION 's3://hsdlc-results/healthdevicesdata.org/fda/contacts/'
TBLPROPERTIES ('skip.header.line.count'='1')
;