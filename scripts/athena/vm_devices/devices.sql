CREATE EXTERNAL TABLE `fda_devices`(
 `PrimaryDI` string,
 `publicDeviceRecordKey` string,
 `publicVersionStatus` string,
 `deviceRecordStatus` string,
 `publicVersionNumber` string,
 `publicVersionDate` string,
 `devicePublishDate` string,
 `deviceCommDistributionEndDate` string,
 `deviceCommDistributionStatus` string,
 `brandName` string,
 `versionModelNumber` string,
 `catalogNumber` string,
 `dunsNumber` string,
 `companyName` string,
 `deviceCount` string,
 `deviceDescription` string,
 `DMExempt` string,
 `premarketExempt` string,
 `deviceHCTP` string,
 `deviceKit` string,
 `deviceCombinationProduct` string,
 `singleUse` string,
 `lotBatch` string,
 `serialNumber` string,
 `manufacturingDate` string,
 `expirationDate` string,
 `donationIdNumber` string,
 `labeledContainsNRL` string,
 `labeledNoNRL` string,
 `MRISafetyStatus` string,
 `rx` string,
 `otc` string,
 `deviceSterile` string,
 `sterilizationPriorToUse` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
LOCATION 's3://hsdlc-results/healthdevicesdata.org/fda/device/'
TBLPROPERTIES ('skip.header.line.count'='1')
;