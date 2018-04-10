import re
import json
import collections
from sys import argv

kv = json.load(open('./ctri.nic.in/replace_keys.json'), object_pairs_hook=collections.OrderedDict) # define desired replacements here

# use these three lines to do the replacement
rep = dict((re.escape(k), v) for k, v in kv.iteritems())
pattern = re.compile("|".join(rep.keys()))
text = pattern.sub(lambda m: rep[re.escape(m.group(0))], argv[1])

print("S3FilePath~FileGUID~Source~Sector~Organization~" + "~".join(kv.keys()))
print('\n')
print(text)

# Example
# ---- OUTPUT -----
# CTRI/2007/091/000002~13/09/2007~17/06/2014 ~No ~Interventional  ~ Dentistry ~Randomized, Parallel Group Trial  ~ A clinical investigation of the extrinsic stain removal efficacy of Colgate total advanced fresh tooth paste as compared to crest regular tooth paste.  ~ A randomized double-blind parallel clinical trial to compare the stain removal efficacy of Colgate total advanced fresh tooth paste and crest regular tooth paste on extrinsic stains on the teeth.   Secondary IDs if Any     Secondary ID Identifier   NIL NIL      Details of Principal Investigator or overall Trial Coordinator (multi-center study)     Name Prof K V V Prasad  Designation   Affiliation    Address Prof. and Head, Dept of , Public Health DentistrySDM college of dental sciencesDharwadKARNATAKA580009India   Phone 08362468142   Fax 08362467612   Email kakarlap@hotmai.com     Details of Contact PersonScientific Query     Name Dr C Bhasker Rao  Designation   Affiliation    Address SDM College of dental sciences &amp; hospitalSatturDharwadKARNATAKA580009India   Phone 08362467676   Fax 08362467612   Email baskerrao@hotmail.com     Details of Contact PersonPublic Query     Name Dr C Bhasker Rao  Designation   Affiliation    Address SDM College of dental sciences &amp; hospitalDharwadKARNATAKA580009India   Phone 08362467676   Fax 08362467612   Email baskerrao@hotmail.com     Source of Monetary or Material Support     S.D. M college of Dental Sciences and Hospital, Dharwad and Colgate Palmolive company     Primary Sponsor     Name SDM College of Dental sciences   Address Stature,Dharwad,Karnataka .580009   Type of Sponsor Research institution and hospital     Details of Secondary Sponsor     Name Address   Mr Prem srinivasan PhD Colgate palmolive company      Countries of Recruitment   India    Sites of Study     No of Sites = 1    Name of PrincipalInvestigator Name of Site Site Address Phone/Fax/Email   ProfKVVPrasad SDM College of Dental Sciences Sattur,-580009DharwadKARNATAKA 0836246814208362467612kakarlap@hotmail.com     Details of Ethics Committee     No of Ethics Committees= 1    Name of Committee Approval Status    Ethical committee, S.D.M College of Dental Sciences and Hospital, Dharwad Approved      Regulatory Clearance Status from DCGI     Status    Not Applicable      Health Condition / Problems Studied     Health Type Condition   Healthy Human Volunteers Subjects with extrinsic stains on teeth.      Intervention / Comparator Agent     Type Name Details   Comparator Agent sodium Flouride topical application,twice dailly for 8 weeks   Intervention stain removal -silica topical application,twice dailly for 8 weeks     Inclusion Criteria     Age From 18.00Year(s)   Age To 70.00Year(s)   Gender Both   Details 1. Signed Informed Consent Form2. Good General Health3. Male and female subjects, aged 18-70, inclusive4. At least eleven scorable anterior teeth free of large restorations or dental prosthetic crowns.5. A minimum Lobene Stain Index Area composite score of 25.6. Available for the entire duration of the study.7. Clinical evidence of a tendency to form extrinsic stain on anterior teeth.    ExclusionCriteria       Details 1. 1. Presence of orthodontic appliances or more than one incisor with a prosthetic crown or veneer.2. Tumors or significant pathology of the soft or hard tissues of the oral cavity.3. Moderate or advanced periodontal disease.4. Five or more carious lesions requiring immediate care.5. Use of stain inducing medications or oral products up to one month prior to the start of the clinical study.6. Participation in any other clinical study or panel test or completion of clinical studies in the one month prior to the start of this study.7. Pregnant or breast feeding women.8. History of allergies to triclosan. Allergies to dentifrice products, personal care products or their ingredients.9. Intrinsic stain or restorations on the teeth to be scored which may interfere with the scoring of extrinsic stain.10. Antibiotic or steroid therapy in the preceding month. 11. Oral prophylaxis in the preceding three months or periodontal treatments in the preceding year.12. Subjects with grade III calculus.      Method of Generating Random Sequence  Random Number Table  Method of Concealment  Pre-numbered or coded identical Containers  Blinding/Masking  Participant, Investigator and Outcome Assessor Blinded  Primary Outcome     Outcome TimePoints   Initial stain scores of Lobene Stain Index after four and eight weeks stain score 0 week and 8weeks     Secondary Outcome     Outcome TimePoints   stain scores of Lobene Stain Index after four and eight weeks 4 and 8 weeks     Target Sample Size  Total Sample Size="120"Sample Size from India="125" Final Enrollment numbers achieved (Total)= "" Final Enrollment numbers achieved (India)=""  Phase of Trial  Phase 3  Date of First Enrollment (India)  Date MissingDate of Study Completion (India)Date Missing Date of First Enrollment (Global) 04/11/2007Date of Study Completion (Global)Date Missing  Estimated Duration of Trial  Years="0"Months="3"Days="0"  Recruitment Status of Trial (Global)  Not Applicable Recruitment Status of Trial (India) Completed  Publication Details  Efficay of two commerically available dentifrices in reducing dentinal hypersensitivity. Indian journal of Dental Research, 21(2),2010:224-230.  Brief Summary  Study Title:Clinical investigation of the extrinsic stain removal efficacy of Colgate Total Advanced Fresh Toothpaste as compared to Crest Regular Toothpaste. Study Phase:III Name of Drug: Active Ingredients:0.243% Sodium Fluoride (1100 ppm F ) Study Dosage:Twice a day Route of Administration:Oral - Topical Objective:The objective of this clinical study is to assess the extrinsic stain removal efficacy of two Toothpastes. Patient Population:One hundred and twenty (120), healthy, adult, female and male subjects will participate in this study. Structure:Parallel:Number of treatments:2X daily Duration of study:8 WeeksNumber of test products:2 Multicenter:This is a single-center study. Blinding:Double-blind Method of Patient Assignment:This is a parallel study with subjects placed in two study groups. Test products will be randomly assigned to each group. Population:Adult males and females with evidence of extrinsic dental stain Examination points:Baseline, 4 weeks and 8 weeks for dental stain. Control:Crest Regular Fluoride Toothpaste (a non-whitening fluoride toothpaste) Estimated Total Sample Size:120 (60 per cell) Primary Efficacy Variable(s):Lobene Stain Index Adverse Reactions: The primary reporting of adverse experiences will be through volunteered comments as well as through clinician observations.Close# ---- INPUT -----
# CTRINumberCTRI/2007/091/000002[Registeredon:13/09/2007]LastModifiedOn:17/06/2014PostGraduateThesisNoTypeofTrialInterventionalTypeofStudyModification(s)DentistryStudyDesignRandomized,ParallelGroupTrialPublicTitleofStudyModification(s)AclinicalinvestigationoftheextrinsicstainremovalefficacyofColgatetotaladvancedfreshtoothpasteascomparedtocrestregulartoothpaste.ScientificTitleofStudyModification(s)Arandomizeddouble-blindparallelclinicaltrialtocomparethestainremovalefficacyofColgatetotaladvancedfreshtoothpasteandcrestregulartoothpasteonextrinsicstainsontheteeth.SecondaryIDsifAnyModification(s)SecondaryIDIdentifierNILNILDetailsofPrincipalInvestigatororoverallTrialCoordinator(multi-centerstudy)Modification(s)NameProfKVVPrasadDesignationAffiliationAddressProf.andHead,Deptof,PublicHealthDentistrySDMcollegeofdentalsciencesDharwadKARNATAKA580009IndiaPhone08362468142Fax08362467612Emailkakarlap@hotmai.comDetailsofContactPersonScientificQueryModification(s)NameDrCBhaskerRaoDesignationAffiliationAddressSDMCollegeofdentalsciences&amp;hospitalSatturDharwadKARNATAKA580009IndiaPhone08362467676Fax08362467612Emailbaskerrao@hotmail.comDetailsofContactPersonPublicQueryModification(s)NameDrCBhaskerRaoDesignationAffiliationAddressSDMCollegeofdentalsciences&amp;hospitalDharwadKARNATAKA580009IndiaPhone08362467676Fax08362467612Emailbaskerrao@hotmail.comSourceofMonetaryorMaterialSupportModification(s)S.D.McollegeofDentalSciencesandHospital,DharwadandColgatePalmolivecompanyPrimarySponsorModification(s)NameSDMCollegeofDentalsciencesAddressStature,Dharwad,Karnataka.580009TypeofSponsorResearchinstitutionandhospitalDetailsofSecondarySponsorModification(s)NameAddressMrPremsrinivasanPhDColgatepalmolivecompanyCountriesofRecruitmentModification(s)IndiaSitesofStudyModification(s)NoofSites=1NameofPrincipalInvestigatorNameofSiteSiteAddressPhone/Fax/EmailProfKVVPrasadSDMCollegeofDentalSciencesSattur,-580009DharwadKARNATAKA0836246814208362467612kakarlap@hotmail.comDetailsofEthicsCommitteeNoofEthicsCommittees=1NameofCommitteeApprovalStatusEthicalcommittee,S.D.MCollegeofDentalSciencesandHospital,DharwadApprovedRegulatoryClearanceStatusfromDCGIStatusNotApplicableHealthCondition/ProblemsStudiedModification(s)HealthTypeConditionHealthyHumanVolunteersSubjectswithextrinsicstainsonteeth.Intervention/ComparatorAgentModification(s)TypeNameDetailsComparatorAgentsodiumFlouridetopicalapplication,twicedaillyfor8weeksInterventionstainremoval-silicatopicalapplication,twicedaillyfor8weeksInclusionCriteriaModification(s)AgeFrom18.00Year(s)AgeTo70.00Year(s)GenderBothDetails1.SignedInformedConsentForm2.GoodGeneralHealth3.Maleandfemalesubjects,aged18-70,inclusive4.Atleastelevenscorableanteriorteethfreeoflargerestorationsordentalprostheticcrowns.5.AminimumLobeneStainIndexAreacompositescoreof25.6.Availablefortheentiredurationofthestudy.7.Clinicalevidenceofatendencytoformextrinsicstainonanteriorteeth.ExclusionCriteriaDetails1.1.Presenceoforthodonticappliancesormorethanoneincisorwithaprostheticcrownorveneer.2.Tumorsorsignificantpathologyofthesoftorhardtissuesoftheoralcavity.3.Moderateoradvancedperiodontaldisease.4.Fiveormorecariouslesionsrequiringimmediatecare.5.Useofstaininducingmedicationsororalproductsuptoonemonthpriortothestartoftheclinicalstudy.6.Participationinanyotherclinicalstudyorpaneltestorcompletionofclinicalstudiesintheonemonthpriortothestartofthisstudy.7.Pregnantorbreastfeedingwomen.8.Historyofallergiestotriclosan.Allergiestodentifriceproducts,personalcareproductsortheiringredients.9.Intrinsicstainorrestorationsontheteethtobescoredwhichmayinterferewiththescoringofextrinsicstain.10.Antibioticorsteroidtherapyintheprecedingmonth.11.Oralprophylaxisintheprecedingthreemonthsorperiodontaltreatmentsintheprecedingyear.12.SubjectswithgradeIIIcalculus.MethodofGeneratingRandomSequenceModification(s)RandomNumberTableMethodofConcealmentModification(s)Pre-numberedorcodedidenticalContainersBlinding/MaskingModification(s)Participant,InvestigatorandOutcomeAssessorBlindedPrimaryOutcomeModification(s)OutcomeTimePointsInitialstainscoresofLobeneStainIndexafterfourandeightweeksstainscore0weekand8weeksSecondaryOutcomeModification(s)OutcomeTimePointsstainscoresofLobeneStainIndexafterfourandeightweeks4and8weeksTargetSampleSizeModification(s)TotalSampleSize="120"SampleSizefromIndia="125"FinalEnrollmentnumbersachieved(Total)=""FinalEnrollmentnumbersachieved(India)=""PhaseofTrialModification(s)Phase3DateofFirstEnrollment(India)Modification(s)DateMissingDateofStudyCompletion(India)DateMissingDateofFirstEnrollment(Global)04/11/2007DateofStudyCompletion(Global)DateMissingEstimatedDurationofTrialModification(s)Years="0"Months="3"Days="0"RecruitmentStatusofTrial(Global)Modification(s)NotApplicableRecruitmentStatusofTrial(India)CompletedPublicationDetailsModification(s)Efficayoftwocommericallyavailabledentifricesinreducingdentinalhypersensitivity.IndianjournalofDentalResearch,21(2),2010:224-230.BriefSummaryModification(s)StudyTitle:ClinicalinvestigationoftheextrinsicstainremovalefficacyofColgateTotalAdvancedFreshToothpasteascomparedtoCrestRegularToothpaste.StudyPhase:IIINameofDrug:ActiveIngredients:0.243%SodiumFluoride(1100ppmF)StudyDosage:TwiceadayRouteofAdministration:Oral-TopicalObjective:TheobjectiveofthisclinicalstudyistoassesstheextrinsicstainremovalefficacyoftwoToothpastes.PatientPopulation:Onehundredandtwenty(120),healthy,adult,femaleandmalesubjectswillparticipateinthisstudy.Structure:Parallel:Numberoftreatments:2XdailyDurationofstudy:8WeeksNumberoftestproducts:2Multicenter:Thisisasingle-centerstudy.Blinding:Double-blindMethodofPatientAssignment:Thisisaparallelstudywithsubjectsplacedintwostudygroups.Testproductswillberandomlyassignedtoeachgroup.Population:AdultmalesandfemaleswithevidenceofextrinsicdentalstainExaminationpoints:Baseline,4weeksand8weeksfordentalstain.Control:CrestRegularFluorideToothpaste(anon-whiteningfluoridetoothpaste)EstimatedTotalSampleSize:120(60percell)PrimaryEfficacyVariable(s):LobeneStainIndexAdverseReactions:Theprimaryreportingofadverseexperienceswillbethroughvolunteeredcommentsaswellasthroughclinicianobservations.Close