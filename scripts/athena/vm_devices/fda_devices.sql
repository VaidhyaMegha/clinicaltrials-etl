CREATE EXTERNAL TABLE `fda_devices`(
 `primarydi` string,
 `publicdevicerecordkey` string,
 `publicversionstatus` string,
 `devicerecordstatus` string,
 `publicversionnumber` string,
 `publicversiondate` string,
 `devicepublishdate` string,
 `devicecommdistributionenddate` string,
 `devicecommdistributionstatus` string,
 `brandname` string,
 `versionmodelnumber` string,
 `catalognumber` string,
 `dunsnumber` string,
 `companyname` string,
 `devicecount` string,
 `devicedescription` string,
 `dmexempt` string,
 `premarketexempt` string,
 `devicehctp` string,
 `devicekit` string,
 `devicecombinationproduct` string,
 `singleuse` string,
 `lotbatch` string,
 `serialnumber` string,
 `manufacturingdate` string,
 `expirationdate` string,
 `donationidnumber` string,
 `labeledcontainsnrl` string,
 `labelednonrl` string,
 `mrisafetystatus` string,
 `rx` string,
 `otc` string,
 `devicesterile` string,
 `sterilizationpriortouse` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
LOCATION 's3://hsdlc-results/healthdevicesdata.org/fda/device/'
TBLPROPERTIES ('skip.header.line.count'='1')
;