CREATE EXTERNAL TABLE `fda_identifiers`(
 `primarydi` string,
 `deviceid` string,
 `deviceidtype` string,
 `deviceidissuingagency` string,
 `containsdinumber` string,
 `pkgquantity` string,
 `pkgdiscontinuedate` string,
 `pkgstatus` string,
 `pkgtype` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
LOCATION 's3://hsdlc-results/healthdevicesdata.org/fda/identifiers/'
TBLPROPERTIES ('skip.header.line.count'='1')
;