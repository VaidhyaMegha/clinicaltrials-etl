create external table `registry_country` (
 `country` string,
  `latitude` string,
  `longitude` string,
  `name` string,
  `registry` string)
  ROW FORMAT serde 'org.openx.data.jsonserde.JsonSerDe'
  STORED AS INPUTFORMAT 'org.apache.hadoop.mapred.TextInputFormat'
  OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
  LOCATION 's3://hsdlc-results/public_datasets/country_lat_long'
  TBLPROPERTIES (
  'ignore.malformed.json'='true'
  )
