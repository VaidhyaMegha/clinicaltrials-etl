SELECT   ctri_number,
         nct_id,
         secondary_ids,
         identifiers,
         CAST(MAP(ARRAY['ctris.registered_on', 'cts.first_received_date', 'trials.registration_date'], ARRAY[ctris.registered_on, cts.first_received_date, trials.registration_date]) AS JSON)Date_Of_Registration,
         CAST(MAP(ARRAY['ctris.type_of_study', 'cts.study_type', 'trials.study_type'], ARRAY[ctris.type_of_study, cts.study_type, trials.study_type]) AS JSON)study_type,
         CAST(MAP(ARRAY['ctris.public_title','cts.brief_title','trials.public_title'],ARRAY[ctris.public_title,cts.brief_title,trials.public_title]) AS JSON) Public_title,
         CAST(MAP(ARRAY['ctris.scientific_title','cts.official_title','trials.scientific_title'],ARRAY[ctris.scientific_title,cts.official_title,trials.scientific_title]) AS JSON) Scientific_title,
         CAST(MAP(ARRAY['ctris.brief_summary','cts.summary','trials.brief_summary'],ARRAY[ctris.brief_summary,'',trials.brief_summary]) AS JSON) brief_summary,
         CAST(MAP(ARRAY['ctris.phase','cts.phase','trials.study_phase'],ARRAY[ctris.phase,cts.phase,trials.study_phase]) AS JSON) phase,
         CAST(MAP(ARRAY['ctris.exclusion_criteria','cts.exclusion_criteria','trials.exclusion_criteria'],ARRAY[ctris.exclusion_criteria,'','']) AS JSON) exclusion_criteria,
         CAST(MAP(ARRAY['ctris.inclusion_criteria','cts.inclusion_criteria','trials.target_sample_size'],ARRAY[ctris.inclusion_criteria,'','']) AS JSON) inclusion_criteria,
         CAST(MAP(ARRAY['ctris.target_sample_size','cts.baseline_population','trials.target_sample_size'],ARRAY[ctris.target_sample_size,cts.baseline_population,cast (trials.target_sample_size AS varchar)]) AS JSON) sample_size,
         ctris.recruitment_status_global ctris_recruitment_status_global,
         ctris.recruitment_status_india ctris_recruitment_status_india,
         cts.overall_status cts_recruitment_status,
         trials.recruitment_status trials_recruitment_status,
         CAST(MAP(ARRAY['ctris.primary_outcome','cts.primary_outcomes','trials.primary_outcomes'],ARRAY[ctris.primary_outcome,'', trials.primary_outcomes]) AS JSON) primary_outcome,
         CAST(MAP(ARRAY['ctris.secondary_outcome','cts.secondary_outcome','trials.secondary_outcomes'],ARRAY[ctris.primary_outcome,'', trials.secondary_outcomes]) AS JSON)secondary_outcome,
         intervention_or_comparator_agent intervention,
         enrollment_type enrollment_type,
         ethics_committee ethics_review,
         primary_sponsor primary_sponsor ,
         secondary_sponsor secondary_sponsor,
         public_query_contact public_query_contact ,
         scientific_query_contact scientific_query_contact,
         date_of_completion_global ctris_date_of_completion_global,
         date_of_completion_india ctris_date_of_completion_india,
         CAST(MAP(ARRAY['cts.completion_date','trials.completion_date'],ARRAY[cts.completion_date, trials.completion_date]) AS JSON) completion_date
FROM global.ctri_studies ctris, global.ct_studies cts,global.trials trials
WHERE ctris.secondary_ids != 'Secondary ID Identifier NIL NIL'
        AND regexp_like(ctris.secondary_ids, 'NCT')
        AND regexp_like(trials.identifiers, 'NCT')
        AND substr(secondary_ids, strpos(secondary_ids, 'NCT'), 11)=cts.nct_id
        AND substr(trials.identifiers, strpos(trials.identifiers, 'NCT'), 11)=cts.nct_id

        UNION

        left outer join --> a - (a n b)
        full outer join --> a + b - (a n b)
        join --> (a n b)

        complement of
        ctri left outer join ct on
        ctris.secondary_ids != 'Secondary ID Identifier NIL NIL'
        AND regexp_like(ctris.secondary_ids, 'NCT')

        UNION

        complement of
                ct left outer join ctri on
                regexp_like(ctris.identifiers, 'NCT')
                AND substr(ctri.secondary_ids, strpos(secondary_ids, 'NCT'), 11) = ct.nct_id

        UNION


