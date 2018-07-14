 CREATE EXTERNAL TABLE `irct_studies`(
 `protocol_summary` string,
 `irct_registrationnumber` string,
 `registration` string,
 `registration_timing` string,
 `last_update` string,
 `updatecount` string,
 `registrant_name_of_organization_or_entity` string,
 `country` string,
 `phone` string,
 `email` string,
 `recruitment_status` string,
 `funding_source` string,
 `expected_recruitment_start_date` string,
 `expected_recruitment_end_date` string,
 `actual_recruitment_start_date` string,
 `actual_recruitment_end_date` string,
 `scientific_title` string,
 `public_title` string,
 `incluionexclusioncriteria` string,
 `age` string,
 `gender` string,
 `phase` string,
 `groups_that_have_been_masked` string,
 `target_sample_size` string,
 `randomization_investigator_s_opinion` string,
 `randomization_description` string,
 `blinding_investigator_s_opinion` string,
 `blinding_description` string,
 `assignment` string,
 `secondary_ids` array<map<string,string>>,
 `health_conditions_studies` array<map<string,string>>,
 `primary_outcomes` array<map<string,string>>,
 `secondary_outcomes` array<map<string,string>>,
 `intervention_groups` array<map<string,string>>,
 `recruitment_centers` array<map<string,string>>,
 `sponsors__or_fundingsources` array<map<string,string>>,
 `ethicscommitte` array<map<string,string>>,
 `personresponsibleforgeneralqueries` array<map<string,string>>,
 `personresponsibleforscientificqueries` array<map<string,string>>,
 `personresponsibleforupdatingdata` array<map<string,string>>)
 ROW FORMAT SERDE
 'org.openx.data.jsonserde.JsonSerDe'
 STORED AS INPUTFORMAT
 'org.apache.hadoop.mapred.TextInputFormat'
 OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
 LOCATION
 's3://hsdlc-results/irct-adapter/json'
 TBLPROPERTIES (
 'ignore.malformed.json'='true')