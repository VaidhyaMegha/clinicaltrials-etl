SELECT Trial_id,
         Secondary_trial_identifiers,
         Study_type,
         Public_title,
         Scientific_title,
         summary,
         phase,
         exclusion_criteria,
         inclusion_criteria,
         sample_size,
         recruitment_status_global,
         recruitment_status_india,
         recruitment_status,
         primary_outcome,
         secondary_outcome,
         intervention,
         erollment_type,
         ethics_review,
         primary_sponsor,
         secondary_sponsor,
         public_query_contact,
         scientific_query_contact,
         date_of_completion_global,
         date_of_completion_india,
         completion_date
FROM
    (SELECT ctri_number AS trial_id ,
         secondary_ids secondary_trial_identifiers ,
         type_of_study study_type ,
         public_title public_title ,
         scientific_title scientific_title ,
         brief_summary summary ,
         phase phase ,
         exclusion_criteria exclusion_criteria ,
         inclusion_criteria inclusion_criteria ,
         target_sample_size AS sample_size ,
         recruitment_status_global recruitment_status_global ,
         recruitment_status_india recruitment_status_india ,
         '' recruitment_status ,primary_outcome primary_outcome ,secondary_outcome secondary_outcome ,intervention_or_comparator_agent intervention ,'' erollment_type ,ethics_committee ethics_review ,primary_sponsor primary_sponsor ,secondary_sponsor secondary_sponsor ,public_query_contact public_query_contact ,scientific_query_contact scientific_query_contact, date_of_completion_global date_of_completion_global, date_of_completion_india date_of_completion_india, '' completion_date
    FROM ctri_studies
    UNION
    SELECT nct_id AS trial_id,
         '' AS secondary_trial_identifiers ,study_type AS study_type ,brief_title AS public_title ,official_title AS scientific_title ,'' summary ,phase phase ,'' AS exclusion_criteria ,'' AS inclusion_criteria ,baseline_population AS sample_size ,'' recruitment_status_global ,'' recruitment_status_india ,overall_status recruitment_status ,'' primary_outcome ,'' secondary_outcome ,'' intervention , enrollment_type enrollment_type ,'' ethics_review ,source primary_sponsor , '' secondary_sponsor ,'' public_query_contact ,'' scientific_query_contact, '' date_of_completion_global, '' date_of_completion_india, completion_date completion_date
    FROM ct_studies
    UNION
    SELECT id AS trial_id,
         identifiers AS secondary_trial_identifiers ,
         study_type AS study_type ,
         public_title AS public_title ,
         scientific_title AS scientific_title ,
         brief_summary summary,
         study_phase phase ,
         '' AS exclusion_criteria ,'' AS inclusion_criteria ,cast(target_sample_size AS varchar) AS samplesize ,'' recruitment_status_global ,'' recruitment_status_india ,recruitment_status recruitment_status ,primary_outcomes primary_outcome ,secondary_outcomes secondary_outcome ,'' intervention ,'' enrollment_type ,'' ethics_review ,'' primary_sponsor ,'' secondary_sponsor ,'' public_query_contact ,'' scientific_query_contact, '' date_of_completion_global, '' date_of_completion_india, completion_date completion_date
    FROM trials)

