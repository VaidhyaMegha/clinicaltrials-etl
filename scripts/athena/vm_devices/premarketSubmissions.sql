CREATE EXTERNAL TABLE `fda_premarket_submissions`(
 `primaryDI` string,
 `submissionNumber` string,
 `supplementNumber` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
LOCATION 's3://hsdlc-results/healthdevicesdata.org/fda/premarketSubmissions/'
TBLPROPERTIES ('skip.header.line.count'='1')
;