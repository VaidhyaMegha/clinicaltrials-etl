CREATE EXTERNAL TABLE `drks_studies`(
 `DRKS_ID` string,
  `Title` string,
  `TrialAcronym` string,
  `URLOfTrial` string,
  `BriefSummaryInLayLanguage` string,
  `BriefSummaryInScientificLanguage` string,
  `DateOfRegistration` string,
  `DateOfRegistrationInPartnerOrPrimaryRegistry` string,
  `InvestigatorSponsored_InitiatedTrial`  string,
  `EthicsApproval_ApprovalOfTheEthicsCommittee` string,
  `EthicsCommitteeNo` string,
  `SecondaryIds`  Map<string,string>,
  `HealthConditionProblemStudied` Map<string,string>,
   `Interventions_Observational` Map<string,string>,
 `Characteristics` Map<string,string>,
 `PrimaryOutcome` Array<string>,
 `CountriesOfRecruitment` Map<string,string>,
 `LocationsOfRecruitment` Array<string>,
 `Recruitment` Map<string,string>,
 `InclusionCriteria` Map<string,string>,
 `AdditionalInclusionCriteria` Array<string>,
 `ExclusionCriteria` Array<string>,
 `PrimarySponsorAdd` Array<struct<Address:Array<string>,Telephone:string,Fax:string,Url:string>>,
 `PublicQueryAddressAdd` Array<struct<Address:Array<string>,Telephone:string,Fax:string,Url:string>>,
`SourceOfMonetaryMaterialSupp` Array<struct<Address:Array<string>,Telephone:string,Fax:string,Url:string>>,
`RecruitmentStatus` string,
`StudyClosing` string
 )
  ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
      LOCATION 's3://hsdlc-results/drk-adapter/studies/json'
      TBLPROPERTIES (
      'ignore.malformed.json'= 'true'
      );