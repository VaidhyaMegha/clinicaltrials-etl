#!/usr/bin/env bash
cat ${1} | pup 'table tr td table:nth-of-type(2) tr td:nth-of-type(2) json{}' | jq -c '{"ctri_number":.[0].children[0].text,"registered_on": .[0].text,"last_modified_on":.[1].text,"pg_thesis":.[2].text,"type_of_trial":.[3].text,"type_of_study":.[4].text,"study_design":.[5].text,"public_title":.[6].text,"scientific_title":.[7].text,"secondary_ids":{"Secondary ID":.[8].children[0].children[0].children[1].children[0].text,"Identifier":.[8].children[0].children[0].children[1].children[1].text},"pi_or_tc":{Name :.[9].children[0].children[0].children[0].children[1].text,"Designation":.[9].children[0].children[0].children[1].children[1].text,"Affiliation":.[9].children[0].children[0].children[2].children[1].text,"Address":.[9].children[0].children[0].children[3].children[1].text,"Phone":.[9].children[0].children[0].children[4].children[1].text,"Fax":.[9].children[0].children[0].children[5].children[1].text,"Email":.[9].children[0].children[0].children[6].children[1].text},"scientific_query_contact":{"Name":.[10].children[0].children[0].children[0].children[1].text,"Designation":.[10].children[0].children[0].children[1].children[1].text,"Affiliation":.[10].children[0].children[0].children[2].children[1].text,"Address":.[10].children[0].children[0].children[3].children[1].text,"Phone":.[10].children[0].children[0].children[4].children[1].text,"Fax":.[10].children[0].children[0].children[5].children[1].text,"Email":.[10].children[0].children[0].children[6].children[1].text},"public_query_contact":{"Name":.[11].children[0].children[0].children[0].children[1].text,"Designation":.[11].children[0].children[0].children[1].children[1].text,"Affiliation":.[11].children[0].children[0].children[2].children[1].text,"Address":.[11].children[0].children[0].children[3].children[1].text,"Phone":.[11].children[0].children[0].children[4].children[1].text,"Fax":.[11].children[0].children[0].children[5].children[1].text,"Email":.[11].children[0].children[0].children[6].children[1].text},"support_source":.[12].children[0].children[0].children[0].children[0].text,"primary_sponsor":{"Name":.[13].children[0].children[0].children[0].children[1].text,"Address":.[13].children[0].children[0].children[0].children[1].text,"Type":.[13].children[0].children[0].children[0].children[1].text},"secondary_sponsor":{"Name":.[14].children[0].children[0].children[1].children[0].text,"Address":.[14].children[0].children[0].children[1].children[1].text}, "countries_of_recruitment":.[15].text, "sites":"", "ethics_committee":"", "regulatory_clearance_status":"", "condition_or_problems":"", "intervention_or_comparator_agent":"", "inclusion_criteria":"", "exclusion_criteria":"", "method_of_generating_random_sequence":.[23].text, "method_of_concealment":.[24].text, "blinding_and_masking":.[25].text, "primary_outcome":"", "secondary_outcome":"", "target_sample_size":"", "phase":.[29].text, "date_of_first_enrollment_india":.[30].text, "date_of_completion_india":.[31].text, "date_of_first_enrollment_global":.[32].text, "date_of_completion_global":.[33].text, "estimated_duration":{"Years":"","Months":"","Days":""}, "recruitment_status_global":.[35].text, "recruitment_status_india":.[36].text, "publication_details":.[37].text, "brief_summary":.[38].text}'