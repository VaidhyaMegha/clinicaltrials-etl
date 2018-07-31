 CREATE EXTERNAL TABLE `brtr_studies`(
 `main` Struct<trial_id:string,utrn:string,reg_name:string,date_registration:string,primary_sponsor:string,public_title:string,acronym:string,scientific_title:string,scientific_acronym:string,date_enrolment:string,type_enrolment:string,target_size:string,recruitment_status:string,url:string,study_type:string>,
 `contacts` Map<string, Array<String>>,
 `countries` Map<string, Array<String>>,
 `criteria` Struct<inclusion_criteria:string,agemin:string,agemax:string,gender:string,exclusion_criteria:string>,
 `health_condition_code` Map<string, Array<String>>,
 `health_condition_keyword` Map<string, Array<String>>,
 `intervention_code` Struct<i_code:string>,
 `intervention_keyword` Map<string, Array<String>>,
 `primary_outcome` Struct<prim_outcome:string>,
 `secondary_outcome` Map<string, Array<String>>,
 `secondary_sponsor` Map<string, Array<String>>,
 `secondary_ids` Map<string, Array<String>>,
 `source_support` Map<string, Array<String>>
)
  ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
      LOCATION 's3://hsdlc-results/brtr-adapter/json'
      TBLPROPERTIES (
      'ignore.malformed.json'= 'true'
      );