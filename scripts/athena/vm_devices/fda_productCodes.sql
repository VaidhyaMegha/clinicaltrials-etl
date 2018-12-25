CREATE EXTERNAL TABLE `fda_product_codes`(
`primarydi` string,
`productcode` string,
`productcodename` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
LOCATION 's3://hsdlc-results/healthdevicesdata.org/fda/productCodes/'
TBLPROPERTIES ('skip.header.line.count'='1')
;