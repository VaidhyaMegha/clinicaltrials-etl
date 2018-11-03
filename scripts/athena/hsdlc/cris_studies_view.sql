CREATE OR REPLACE VIEW  cris_Studies_view AS SELECT  b.cris_registration_number,
unique_protocol_id ,
public_or_brief_title,
scientific_title ,
mfds_regulated_study,
registered_at_other_registry,
board_approval_status ,
board_approval_number ,
approval_date ,
institutional_review_board ,
contact_for_scientific_queries ,
contact_for_public_queries,
contact_person_for_updating_Info ,
data_monitoring_committee ,
study_site  ,
overall_recruitment_status  ,
date_of_first_enrollment  ,
target_number_of_participant ,
primary_completion_date  ,
study_completion_date ,
sites ,
source_of_monetary_or_material_support ,
sponsor_organisation  ,
lay_summary ,
study_type ,
study_purpose ,
phase ,
intervention_model ,
blinding_or_masking ,
allocation ,
intervention_type ,
intervention_description ,
number_of_arms ,
arm ,
Observational_Study_Model
TimePerspective   ,
TargetNumberOfParticipant ,
Cohortgroup ,
BiospecimenCollection ,
BiospecimenDescription  ,
StudyPopulationDesc ,
SamplingMethod ,
conditions_problems ,
rare_disease ,
inclusion_criteria,
exclusion_criteria ,
healthy_volunteers ,
type_of_primary_income ,
primary_outcome  ,
secondary_outcome  ,
result_registered ,
sharing_statement ,
time_of_sharing ,
way_of_sharing ,
SEQ_NUMBER number
FROM cris_studies b
JOIN (
SELECT   cris_registration_number, MAX(SEQ_NUMBER) max_value FROM cris_studies
group by cris_registration_number
) a ON
a.cris_registration_number = b.cris_registration_number AND a.max_value = b.seq_number 