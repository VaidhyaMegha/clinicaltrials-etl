 CREATE EXTERNAL TABLE `jprn_studies`(
 `Recruitment_status` string,
 `Unique_ID_issued_by_UMIN` string,
 `Receipt_No` string,
 `Official_scientific_title_of_the_study` string,
 `Date_of_disclosure_of_the_study_information` string,
 `Last_modified_on` string,
 `Basic_information`  Struct<Official_scientific_title_of_the_study:string,Title_of_the_study_Brief_title:string,Region:string>,
 `Condition`  Struct<Condition:string,Classification_by_specialty:string,Classification_by_malignancy:string,Genomic_information:string>,
 `Objectives`  Struct<Narrative_objectives1:string,Basic_objectives2:string,Basic_objectives_Others:string,Trial_characteristics_1:string,Trial_characteristics_2:string,Developmental_phase:string>,
 `Assessment` Struct<Primary_outcomes:string,Key_secondary_outcomes:string>,
 `Base` Struct<Study_type:string>,
 `Study_design` Struct<Basic_design:string,Randomization:string,Randomization_unit:string,Blinding:string,Control:string,Stratification:string,Dynamic_allocation:string,Institution_consideration:string,Blocking:string,Concealment:string>,
 `Intervention` Struct<No_of_arms:string,Purpose_of_intervention:string,Type_of_intervention:string,Interventions_Control_1:string,Interventions_Control_2:string,Interventions_Control_3:string,Interventions_Control_4:string,Interventions_Control_5:string,Interventions_Control_6:string,Interventions_Control_7:string,Interventions_Control_8:string,Interventions_Control_9:string,Interventions_Control_10:string>,
 `Eligibility` Struct<Age_lower_limit:string,Age_upper_limit:string,Gender:string,Key_inclusion_criteria:string,Key_exclusion_criteria:string,Target_sample_size:string>,
 `Research_Contact_Person` Struct<Name_of_lead_principal_investigator:string,Organization:string,Division_name:string,Address:string,TEL:string,Email:string>,
 `Public_Contact_Person` Struct<Name_of_contact_person:string,Organization:string,Division_name:string,Address:string,TEL:string,Homepage_URL:string,Email:string>,
 `Sponsor` Struct<Institute:string,Department:string>,
 `Funding_Source`Struct<Organization:string,Division:string,Category_of_Funding_Organization:string,Nationality_of_Funding_Organization:string>,
 `Other_related_Organizations` Struct<Co_sponsor:string,Name_of_secondary_funder_s:string>,
 `Secondary_IDs`Struct<Secondary_IDs:string,Study_ID_1:string,Org_issuing_International_ID_1:string,Study_ID_2:string,Org_issuing_International_ID_2:string,IND_to_MHLW:string>,
 `Institutions`Struct<Institutions:string>, 
 `Progress`Struct<Date_of_protocol_fixation:string,Anticipated_trial_start_date:string,Last_follow_up_date:string,Date_of_closure_to_data_entry:string,Date_trial_data_considered_complete:string,Date_analysis_concluded:string>,
 `Related_information`Struct<URL_releasing_protocol:string,Publication_of_results:string,URL_releasing_results:string,Results:string,Other_related_information:string>,
 `Management_information`Struct<Registered_date:string,Last_modified_on:string>,
 `Link_to_view_the_page`Struct<URL_English:string>
)
  ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
      LOCATION 's3://hsdlc-results/jprn-adapter/json'
      TBLPROPERTIES (
      'ignore.malformed.json'= 'true'
      );