CREATE EXTERNAL TABLE `cubct_studies`(
 `Acronym_of_Public_Title` string,
  `Scientific_Title` string,
  `Acronym_Of_Scientific_Title` string,
  `SecondaryIDs` struct<code:string>,
  `IssuingAuthotiryOfSecondaryIds` string,
  `PrimarySponsors` array<string>,
  `SecondarySponsors` array<string>,
  `Source_Of_Monetary_Material_support` string,
  `Regulatory_instance_to_authorize_the_initiation_of_the_study`  string,
  `AuthorizationDate` string,
  `ReferenceNumber` string,
  `Principalinvestigator` ARRAY<STRUCT<First_Name:STRING,Last_Name:STRING,Medical_Specialty:STRING,Affiliation:STRING,PostalAddress:STRING,City:STRING,Country:STRING,Zipcode:STRING,Telephone:STRING,EmailAddresses:ARRAY<STRING> >>,
  `Clinicalsitestoparticipate` ARRAY<STRUCT<CountriesOfRecruitment:STRING,Clinical_Sites:STRING,Researchethicscommittees:STRING>>,
  `RecruitmentStatus` string,
  `DateoffirstEnrollment` string, 
  `HealthconditionIntervention` ARRAY<STRUCT<HealthCondition:STRING,HealthConditionCode:STRING,InterventionCode:ARRAY<STRING>,InterventionCode:ARRAY<STRING>,InterventionKeyWord:ARRAY<STRING> >>,
  `OutcomesAndTimepoints` ARRAY<STRUCT<PrimaryOutcome:STRING,SEcondaryOutcome:STRING>>,
  `SelectionCriterias`  ARRAY<STRUCT<InclusionCriteria:ARRAY<STRING>,ExclusionCriteria:ARRAY<STRING>,TypeOfPopulation:string,Typeofparticipant:string>> ,
 `TypeStudy` string,
 `Purpose` string,
 `OtherPurpose` string,
 `Allocation` string,
 `Masking` string,
 `ControlGroup` string,
 `StudyDesign` string,
 `Phase` string,
 `TargetSampleSize` string,
 `ContactForPublicQUeries` ARRAY<STRUCT<Pub_First_Name:STRING,Pub_Last_Name:STRING,Pub_Medical_Specialty:STRING,Pub_Affiliation:STRING,Pub_PostalAddress:STRING,Pub_City:STRING,Pub_Country:STRING,Pub_Zipcode:STRING,Pub_Telephone:STRING,Pub_EmailAddresses:ARRAY<STRING> >>,
 `ContactForScientificQueries` ARRAY<STRUCT<Sci_First_Name:STRING,Sci_Last_Name:STRING,Sci_Medical_Specialty:STRING,Sci_Affiliation:STRING,Sci_PostalAddress:STRING,Sci_City:STRING,Sci_Country:STRING,Sci_Zipcode:STRING,Sci_Telephone:STRING,Sci_EmailAddresses:ARRAY<STRING> >>,
 `PrimaryRegistry` string,
 `UniqueIDNumber` string,
 `DateOfRegistrationinPrimaryRegisrty` string,
 `RecordVerificationDate` string
 
 )
  ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
      LOCATION 's3://hsdlc-results/cubct-adapter/studies/json'
      TBLPROPERTIES (
      'ignore.malformed.json'= 'true'
      );