 CREATE EXTERNAL TABLE `irct_studies`( 
 `Protocol_Summary` string,
 `IRCT_RegistrationNumber` string,
 `Registration` string,
 `Registration_timing` string,
 `Last_Update` string,
 `UpdateCount` string,
 `Registrant_Name_Of_Organization_or_Entity` string,
 `Country` string,
 `Phone` string,
 `Email` string,
 `Recruitment_status` string,
 `Funding_source` string,
 `Expected_Recruitment_start_Date` string,
 `Expected_Recruitment_End_Date` string,
 `Actual_recruitment_start_date` string,
 `Actual_recruitment_End_date` string,
 `Scientific_title` string,
 `Public_title` string,
 `InclusionCriteria` string,
 `ExclusionCriteria` string,
 `Age` string,
 `Gender` string,
 `phase` string,
 `Groups_that_have_been_masked` string,
 `Target_sample_size` string,
 `Randomization_investigator_s_opinion` string,
 `Randomization_description` string,
 `Blinding_investigator_s_opinion` string,
 `Blinding_description` string,
 `Assignment` string,
 `Secondary_Ids` Array<Map<string,string>>,
 `Health_Conditions_studies` Array<Map<string,string>>,
 `Primary_outcomes` Array<Map<string,string>>,
 `Secondary_outcomes` Array<Map<string,string>>,
 `Intervention_groups` Array<Map<string,string>>,
 `Recruitment_centers` Array<Map<string,string>>,
 `Sponsors__or_FundingSources` Array<Map<string,string>>,
 `EthicsCommitte` Array<Map<string,string>>,
 `PersonResponsibleForGeneralQueries` Array<Map<string,string>>,
 `PersonResponsibleForScientificQueries` Array<Map<string,string>>,
 `PersonResponsibleForUpdatingData` Array<Map<string,string>>
)
  ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
      LOCATION 's3://hsdlc-results/irct-adapter/json'
      TBLPROPERTIES (
      'ignore.malformed.json'= 'true'
      );
=======
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
>>>>>>> 1ba658a9573873c07d08c980b289bd80a4a118f3
