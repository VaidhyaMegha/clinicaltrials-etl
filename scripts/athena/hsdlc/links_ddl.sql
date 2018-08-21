 CREATE EXTERNAL TABLE `links`(
  `component` Array<string>
)
  ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
      LOCATION 's3://hsdlc-results/discover'
      TBLPROPERTIES (
      'ignore.malformed.json'= 'true'
      );