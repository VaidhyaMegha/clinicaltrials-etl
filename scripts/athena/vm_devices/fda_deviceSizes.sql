CREATE EXTERNAL TABLE `fda_device_sizes`(
 `primarydi` string,
 `sizetype` string,
 `sizeunit` string,
 `sizevalue` string,
 `sizetext` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
LOCATION 's3://hsdlc-results/healthdevicesdata.org/fda/deviceSizes/'
TBLPROPERTIES ('skip.header.line.count'='1')
;