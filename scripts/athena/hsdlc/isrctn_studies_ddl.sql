  CREATE EXTERNAL TABLE `isrctn_studies`(
   `conditionCategory` string,
    `dateApplied` string,
    `dateAssigned` string,
    `LastEdited` string,
    `Prospective_Retrospective` string,
    `PublicTitleOftrial` string,
    `OverAllTrialStatus` string,
    `RecruitmentStatus` string,
    `IRCTN_NUMBER`  string,
    `PlainEnglishWebsite` string,
    `Type` string,
    `SecondaryId`  string,
    `PrimaryContact`  string,
    `ContactDetails` Array<string>,
    `SecondaryIds`  Array<string>,
    `ScientificTitle`  string,
     `Acronym` string,
   `StudyHypothesis` string,
   `EthicsApproval` string,
   `PrimaryStudyDesign` string,
   `SecondaryStudyDesign` string,
   `TrialSetting` string,
   `TrialType` string,
   `PatientInformationSheet` string,
   `Intervention` Array<string>,
    `InterventionType` string,
   `Phase` string,
   `PrimaryOutcomeMeasure` Array<string>,
   `SecondaryOutcomeMeasure` Array<string>,
   `OverallTrialstartDate` string,
    `OverallTrialEndDate` string,
    `ParticipantInclusionCriteria` Array<string>,
    `ParticipantType` string,
    `AgeGroup` string,
    `Gender` string,
    `TargetNumberOfParticipants` string,
    `ParticipantExclusionCriteria` Array<string>,
    `RecruitmentStartDate` string,
    `RecruitmentEndDate` string,
    `Organisation` string,
    `CountriesOfRecruitment` Array<string>,
    `TrialParcipatingCentre` Array<string>,
      `SponsorDetails` Array<string>,
    `SponsorType` string,
      `Website` string,
      `FunderType` string,
      `FunderName` string
   )
    ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
        LOCATION 's3://hsdlc-results/isrctn-adapter/json'
        TBLPROPERTIES (
        'ignore.malformed.json'= 'true'
        );
