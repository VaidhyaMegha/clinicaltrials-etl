CREATE EXTERNAL TABLE `fda_identifiers`(
 `PrimaryDI` string,
 `deviceId` string,
 `deviceIdType` string,
 `deviceIdIssuingAgency` string,
 `containsDINumber` string,
 `pkgQuantity` string,
 `pkgDiscontinuedate` string,
 `pkgStatus` string,
 `pkgType` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
LOCATION 's3://hsdlc-results/healthdevicesdata.org/fda/identifiers/'
TBLPROPERTIES ('skip.header.line.count'='1')
;