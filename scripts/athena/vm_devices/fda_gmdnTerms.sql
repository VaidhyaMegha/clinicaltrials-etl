CREATE EXTERNAL TABLE `fda_gmdn_terms`(
 `primarydi` string,
 `gmdnptname` string,
 `gmdnptdefinition` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
LOCATION 's3://hsdlc-results/healthdevicesdata.org/fda/gmdnTerms/'
TBLPROPERTIES ('skip.header.line.count'='1')
;