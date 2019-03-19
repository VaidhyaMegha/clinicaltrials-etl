CREATE EXTERNAL TABLE `tctr_studies`(
  `main` Struct<trial_id:string,utrn:string,reg_name:string,date_registration:string,primary_sponsor:string,public_title:string,acronym:string,scientific_title:string,scientific_acronym:string,date_enrolment:string,type_enrolment:string,target_size:string,recruitment_status:string,url:string,study_type:string>,
   `contacts` Array<Map<string,string>>,
   `countries` Array<Map<string,string>>,
   `criteria` Struct<inclusion_criteria:string,agemin:string,agemax:string,gender:string,exclusion_criteria:string>,
   `health_condition_code` Array<Map<string,string>>,
   `health_condition_keyword` Array<Map<string,string>>,
   `intervention_code` Struct<i_code:string>,
   `intervention_keyword` Array<Map<string,string>>,
   `primary_outcome` Array<Map<string,string>>,
   `secondary_outcome` Array<Map<string,string>>,
   `primary_sponsor` Array<Map<string,string>>,
   `secondary_sponsor` Array<Map<string,string>>,
   `secondary_ids` Array<Map<string,string>>,
   `source_support` Array<Map<string,string>>

 )
  PARTITIONED BY (
      p_id string
      )
  ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
      LOCATION 's3://hsdlc-results/tctr-adapter/studies/json'
      TBLPROPERTIES (
      'ignore.malformed.json'= 'true'
      );

MSCK REPAIR TABLE tctr_studies;
