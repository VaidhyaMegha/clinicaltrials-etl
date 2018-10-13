CREATE EXTERNAL TABLE `fda_device_sizes`(
 `PrimaryDI` string,
 `sizeType` string,
 `sizeUnit` string,
 `sizeValue` string,
 `sizeText` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
LOCATION 's3://hsdlc-results/healthdevicesdata.org/fda/deviceSizes/'
TBLPROPERTIES ('skip.header.line.count'='1')
;