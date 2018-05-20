SELECT   ctri_number,
         nct_id,
         secondary_ids,
         identifiers,
         CAST(MAP(ARRAY['ctris.registered_on', 'cts.first_received_date', 'trials.registration_date'], ARRAY[ctri_cts.registered_on, ctri_cts.first_received_date, trials.registration_date]) AS JSON)Date_Of_Registration,
         CAST(MAP(ARRAY['ctris.type_of_study', 'cts.study_type', 'trials.study_type'], ARRAY[ctri_cts.type_of_study, ctri_cts.study_type, trials.study_type]) AS JSON)study_type,
         CAST(MAP(ARRAY['ctris.public_title','cts.brief_title','trials.public_title'],ARRAY[ctri_cts.public_title,ctri_cts.brief_title,trials.public_title]) AS JSON) Public_title,
         CAST(MAP(ARRAY['ctris.scientific_title','cts.official_title','trials.scientific_title'],ARRAY[ctri_cts.scientific_title,ctri_cts.official_title,trials.scientific_title]) AS JSON) Scientific_title,
         CAST(MAP(ARRAY['ctris.brief_summary','cts.summary','trials.brief_summary'],ARRAY[ctri_cts.brief_summary,'',trials.brief_summary]) AS JSON) brief_summary,
         CAST(MAP(ARRAY['ctris.phase','cts.phase','trials.study_phase'],ARRAY[ctri_cts.ctris_phase,ctri_cts.cts_phase,trials.study_phase]) AS JSON) phase,
         CAST(MAP(ARRAY['ctris.exclusion_criteria','cts.exclusion_criteria','trials.exclusion_criteria'],ARRAY[ctri_cts.exclusion_criteria,'','']) AS JSON) exclusion_criteria,
         CAST(MAP(ARRAY['ctris.inclusion_criteria','cts.inclusion_criteria','trials.target_sample_size'],ARRAY[ctri_cts.inclusion_criteria,'','']) AS JSON) inclusion_criteria,
         CAST(MAP(ARRAY['ctris.target_sample_size','cts.baseline_population','trials.target_sample_size'],ARRAY[ctri_cts.target_sample_size,ctri_cts.baseline_population,cast (trials.target_sample_size AS varchar)]) AS JSON) sample_size,
         CAST(MAP(ARRAY['ctris.recruitment_status_global','ctris.recruitment_status_india','cts.cts_recruitment_status','trials.recruitment_status'],ARRAY[ctri_cts.recruitment_status_global,ctri_cts.recruitment_status_india,ctri_cts.overall_status,trials.recruitment_status]) AS JSON) recruitment_status,
         CAST(MAP(ARRAY['ctris.primary_outcome','cts.primary_outcomes','trials.primary_outcomes'],ARRAY[ctri_cts.primary_outcome,'', trials.primary_outcomes]) AS JSON) primary_outcome,
         CAST(MAP(ARRAY['ctris.secondary_outcome','cts.secondary_outcome','trials.secondary_outcomes'],ARRAY[ctri_cts.primary_outcome,'', trials.secondary_outcomes]) AS JSON)secondary_outcome,
         ctri_cts.intervention intervention,
         ctri_cts.enrollment_type enrollment_type,
         ctri_cts.ethics_committee ethics_review,
         ctri_cts.primary_sponsor primary_sponsor ,
         ctri_cts.secondary_sponsor secondary_sponsor,
         ctri_cts.public_query_contact public_query_contact ,
         ctri_cts.scientific_query_contact scientific_query_contact,
         CAST(MAP(ARRAY['ctris.date_of_completion_global','ctri.date_of_completion_india','cts.completion_date',
         'trials.completion_date'],ARRAY[ctri_cts.date_of_completion_global,ctri_cts.date_of_completion_india,ctri_cts.completion_date, trials.completion_date]) AS JSON) CompletionDate

   FROM (
            SELECT ctri_number,
                nct_id,
                secondary_ids,
                ctris.registered_on,
                cts.first_received_date,
                ctris.type_of_study,
                cts.study_type,
                ctris.public_title,
                cts.brief_title,
                ctris.scientific_title,
                cts.official_title,
                ctris.brief_summary,
                ctris.phase ctris_phase,
                cts.phase cts_phase,
                ctris.exclusion_criteria,
                ctris.inclusion_criteria,
                ctris.target_sample_size,cts.baseline_population,ctris.recruitment_status_global,
                ctris.recruitment_status_india,cts.overall_status,ctris.primary_outcome,
                ctris.secondary_outcome,ctris.intervention_or_comparator_agent intervention,
                enrollment_type,ethics_committee,primary_sponsor,secondary_sponsor,public_query_contact,
                scientific_query_contact,date_of_completion_global,date_of_completion_india,cts.completion_date
           FROM global.ctri_studies ctris
                FULL OUTER JOIN global.ct_studies cts
                ON substr(secondary_ids, strpos(secondary_ids, 'NCT'), 11)=cts.nct_id  where ctri_number !='' or nct_id != ''
                 ) ctri_cts
    FULL OUTER JOIN global.trials trials
    ON substr(trials.identifiers, strpos(trials.identifiers, 'NCT'), 11)=ctri_cts.nct_id