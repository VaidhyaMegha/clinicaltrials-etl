#!/usr/bin/env node

let readline = require('readline');
let rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let study = [];


rl.on('line', function (line) {
    study.push(line);
});

rl.on('close', function () {
    let finalRecord = {};
    let sites = [];
    let temp = null;

    let i = 0;
    {

        // check for the current line and move to next line. Check if next line is a 'key' if not it must be a value.
        if (is(study, i, '"CRIS Registration Number"') && !is(study, ++i, '"Unique Protocol ID"'))
            finalRecord['cris_registration_number'] = cleanLine(study, i++);

        if (is(study, i, '"Unique Protocol ID"') && !is(study, ++i, '"Public/Brief Title"'))
            finalRecord['unique_protocol_id'] = cleanLine(study, i++);

        if (is(study, i, '"Public/Brief Title"') && !is(study, ++i, '"Scientific Title"'))
            finalRecord['public_or_brief_title'] = cleanLine(study, i++);

        if (is(study, i, '"Scientific Title"') && !is(study, ++i, '"Acronym"'))
            finalRecord['scientific_title'] = cleanLine(study, i++);

        if (is(study, i, '"Acronym"') && !is(study, ++i, '"MFDS Regulated Study"'))
            finalRecord['acronym'] = cleanLine(study, i++);

        if (is(study, i, '"MFDS Regulated Study"') && !is(study, ++i, '"IND/IDE Protocol"'))
            finalRecord['mfds_regulated_study'] = cleanLine(study, i++);

        if (is(study, i, '"IND/IDE Protocol"') && !is(study, ++i, '"Registered at Other Registry"'))
            finalRecord['ind_ide_protocol'] = cleanLine(study, i++);

        if (is(study, i, '"Registered at Other Registry"') && !is(study, ++i, '"Healthcare Benefit Approval Status"'))
            finalRecord['registered_at_other_registry'] = cleanLine(study, i++);

        if (is(study, i, '"Healthcare Benefit Approval Status"') && !is(study, ++i, '"Board Approval Status"'))
            finalRecord['healthcare_benefit_approval_status'] = cleanLine(study, i++);

        if (is(study, i, '"Board Approval Status"') && !is(study, ++i, '"Board Approval Number"'))
            finalRecord['board_approval_status'] = cleanLine(study, i++);

        if (is(study, i, '"Board Approval Number"') && !is(study, ++i, '"Approval Date"'))
            finalRecord['board_approval_number'] = cleanLine(study, i++);

        if (is(study, i, '"Approval Date"') && !is(study, ++i, '"Institutional Review Board"'))
            finalRecord['approval_date'] = cleanLine(study, i++);

        // check for the current line and move to next line. If its the start of an object get inside
        if (is(study, i++, '"Institutional Review Board"')){
            temp = {};

            // check for the current line and move to next line. Check if next line is a 'key' if not it must be a value.
            if (is(study, i, '"- Name"') && !is(study, ++i, '"- Address"'))
                temp['name'] = cleanLine(study, i++);

            if (is(study, i, '"- Address"') && !is(study, ++i, '"- Telephone"'))
                temp['address'] = cleanLine(study, i++);

            if (is(study, i, '"- Telephone"') && !is(study, ++i, '"Data Monitoring Committee"'))
                temp['telephone'] = cleanLine(study, i++);

            finalRecord['institutional_review_board'] = temp;
        }

        if (is(study, i, '"Data Monitoring Committee"') && !is(study, ++i, '"Contact Person for Principal Investigator / Scientific Queries"'))
            finalRecord['data_monitoring_committee'] = cleanLine(study, i++);

        if (is(study, i++, '"Contact Person for Principal Investigator / Scientific Queries"')){
            temp = {};

            if (is(study, i, '"- Name"') && !is(study, ++i, '"- Title"'))
                temp['name'] = cleanLine(study, i++);

            if (is(study, i, '"- Title"') && !is(study, ++i, '"- Telephone"'))
                temp['title'] = cleanLine(study, i++);

            if (is(study, i, '"- Telephone"') && !is(study, ++i, '"- Affiliation"'))
                temp['telephone'] = cleanLine(study, i++);

            if (is(study, i, '"- Affiliation"') && !is(study, ++i, '"- Address"'))
                temp['affiliation'] = cleanLine(study, i++);

            if (is(study, i, '"- Address"') && !is(study, ++i, '"Contact Person for Public Queries"'))
                temp['address'] = cleanLine(study, i++);

            finalRecord['contact_for_scientific_queries'] = temp;
        }

        if (is(study, i++, '"Contact Person for Public Queries"')){
            temp = {};

            if (is(study, i, '"- Name"') && !is(study, ++i, '"- Title"'))
                temp['name'] = cleanLine(study, i++);

            if (is(study, i, '"- Title"') && !is(study, ++i, '"- Telephone"'))
                temp['title'] = cleanLine(study, i++);

            if (is(study, i, '"- Telephone"') && !is(study, ++i, '"- Affiliation"'))
                temp['telephone'] = cleanLine(study, i++);

            if (is(study, i, '"- Affiliation"') && !is(study, ++i, '"- Address"'))
                temp['affiliation'] = cleanLine(study, i++);

            if (is(study, i, '"- Address"') && !is(study, ++i, '"Contact Person for Updating Information"'))
                temp['address'] = cleanLine(study, i++);

            finalRecord['contact_for_public_queries'] = temp;
        }

        if (is(study, i++, '"Contact Person for Updating Information"')){
            temp = {};

            if (is(study, i, '"- Name"') && !is(study, ++i, '"- Title"'))
                temp['name'] = cleanLine(study, i++);

            if (is(study, i, '"- Title"') && !is(study, ++i, '"- Telephone"'))
                temp['title'] = cleanLine(study, i++);

            if (is(study, i, '"- Telephone"') && !is(study, ++i, '"- Affiliation"'))
                temp['telephone'] = cleanLine(study, i++);

            if (is(study, i, '"- Affiliation"') && !is(study, ++i, '"- Address"'))
                temp['affiliation'] = cleanLine(study, i++);

            if (is(study, i, '"- Address"') && !is(study, ++i, '"Study Site"'))
                temp['address'] = cleanLine(study, i++);

            finalRecord['contact_for_updating_information'] = temp;
        }


        if (is(study, i, '"Study Site"') && !is(study, ++i, '"Overall Recruitment Status"'))
            finalRecord['study_site'] = cleanLine(study, i++);

        if (is(study, i, '"Overall Recruitment Status"') && !is(study, ++i, '"Date of First Enrollment"'))
            finalRecord['overall_recruitment_status'] = cleanLine(study, i++);

        if (is(study, i, '"Date of First Enrollment"') && !is(study, ++i, '"Target Number of Participant"'))
            finalRecord['date_of_first_enrollment'] = cleanLine(study, i++);

        if (is(study, i, '"Target Number of Participant"') && !is(study, ++i, '"Primary Completion Date"'))
            finalRecord['target_number_of_participants'] = cleanLine(study, i++);

        if (is(study, i, '"Primary Completion Date"') && !is(study, ++i, '"Study Completion Date"'))
            finalRecord['primary_completion_date'] = cleanLine(study, i++);

        if (is(study, i, '"Study Completion Date"') && !is(study, ++i, '"Recruitment Status by Participating Study Site 1"'))
            finalRecord['study_completion_date'] = cleanLine(study, i++);


        // check for the current line and move to next line. If its the start of an array of objects get inside

        if (is(study, i++, "Recruitment Status by Participating Study Site 1")) {
            sites = [];

            while (!is(study, i, '"Source of Monetary/Material Support1"')) {
                temp = {};

                if (is(study, i, '"- Name of Study Site"') && !is(study, ++i, '"- Recruitment Status"'))
                    temp['name_of_study_site'] = cleanLine(study, i++);

                if (is(study, i, '"- Recruitment Status"') && !is(study, ++i, '"- Date of First Enrollment"'))
                    temp['recruitment_status'] = cleanLine(study, i++);

                // check for the current line and move to next line. If its not the end of the current object or end of the array of objects it must be value

                if (is(study, i, '"- Date of First Enrollment"') && !(is(study, ++i, '"Source of Monetary/Material Support1"')
                                                                    || is(study, i, '"Recruitment Status by Participating Study Site')) ) {
                    temp['date_of_first_enrollment'] = cleanLine(study, i++);

                    // If its not the end of the array of objects move one more line to allow for object header.

                    if(!(is(study, i, '"Source of Monetary/Material Support1"')))
                        i++;
                }

                sites.push(temp);
            }

            finalRecord['sites'] = sites;
        }
         if (is(study, i++, "Source of Monetary/Material Support1")) {
                            source = [];

                            while (!is(study, i, '"Sponsor Organization 1"')) {
                                temp = {};

                                if (is(study, i, '"- Organization Name"') && !is(study, ++i, '"- Organization Type"'))
                                    temp['name_of_study_site'] = cleanLine(study, i++);

                                if (is(study, i, '"- Organization Type"') && !is(study, ++i, '"- Project ID"'))
                                    temp['recruitment_status'] = cleanLine(study, i++);

                                // check for the current line and move to next line. If its not the end of the current object or end of the array of objects it must be value

                                if (is(study, i, '"- Project ID"') && !(is(study, ++i, '"Sponsor Organization 1"')
                                                                                    || is(study, i, '"Source of Monetary/Material Support')) ) {
                                    temp['date_of_first_enrollment'] = cleanLine(study, i++);

                                    // If its not the end of the array of objects move one more line to allow for object header.

                                    if(!(is(study, i, '"Sponsor Organization 1"')))
                                        i++;
                                }

                                source.push(temp);
                            }

                            finalRecord['source_of_monetary_or_material_support'] = source;
                        }

         if (is(study, i++, "Sponsor Organization 1")) {
                    sponsor = [];

                    while (!is(study, i, '"Lay Summary"')) {
                        temp = {};

                        if (is(study, i, '"- Organization Name"') && !is(study, ++i, '"- Organization Type"'))
                            temp['organization_name'] = cleanLine(study, i++);


                        // check for the current line and move to next line. If its not the end of the current object or end of the array of objects it must be value

                        if (is(study, i, '"- Organization Type"') && !(is(study, ++i, '"Lay Summary"')
                                                                            || is(study, i, '"Sponsor Organization')) ) {
                            temp['organization_type'] = cleanLine(study, i++);

                            // If its not the end of the array of objects move one more line to allow for object header.

                            if(!(is(study, i, '"Lay Summary"')))
                                i++;
                        }

                        sponsor.push(temp);
                    }

                    finalRecord['sponsor_organisation'] = sponsor;
                }

          if (is(study, i, '"Lay Summary"') && !is(study, ++i, '"Study Type"'))
                     finalRecord['lay_summary'] = cleanLine(study, i++);

          if (is(study, i, '"Study Type"') && !is(study, ++i, '"Study Purpose"'))
                                 finalRecord['study_type'] = cleanLine(study, i++);
          if (is(study, i, '"Study Purpose"') && !is(study, ++i, '"Phase"'))
                                 finalRecord['study_purpose'] = cleanLine(study, i++);
          if (is(study, i, '"Phase"') && !is(study, ++i, '"Intervention Model"'))
                                 finalRecord['Phase'] = cleanLine(study, i++);
          if (is(study, i, '"Intervention Model"') && !is(study, ++i, '"Blinding/Masking"'))
                                 finalRecord['intervention_model'] = cleanLine(study, i++);
          if (is(study, i, '"Blinding/Masking"') && !is(study, ++i, '"Allocation"'))
                                 finalRecord['blinding_or_masking'] = cleanLine(study, i++);
          if (is(study, i, '"Allocation"') && !is(study, ++i, '"Intervention Type"'))
                                 finalRecord['allocation'] = cleanLine(study, i++);
          if (is(study, i, '"Intervention Type"') && !is(study, ++i, '"Intervention Description"'))
                                  finalRecord['intervention_type'] = cleanLine(study, i++);
          if (is(study, i, '"Intervention Description"') && !is(study, ++i, '"Number of Arms"'))
                                  finalRecord['intervention_description'] = cleanLine(study, i++);
          if (is(study, i, '"Number of Arms"') && !is(study, ++i, '"Arm 1"'))
                                  finalRecord['number_of_arms'] = cleanLine(study, i++);

       if (is(study, i++, "Arm 1")) {
                    arm = [];

                    while (!is(study, i, '"Condition(s)/Problem(s)"')) {
                        temp = {};

                        if (is(study, i, '"Arm Label"') && !is(study, ++i, '"Target Number of Participant"'))
                            temp['arm_label'] = cleanLine(study, i++);

                        if (is(study, i, '"Target Number of Participant"') && !is(study, ++i, '"Arm Type"'))
                            temp['target_number_of_participant'] = cleanLine(study, i++);


                        if (is(study, i, '"Arm Type"') && !is(study, ++i, '"Arm Description"'))
                            temp['arm_type'] = cleanLine(study, i++);


                         if (is(study, i, '"Arm Description"') && !(is(study, ++i, '"Condition(s)/Problem(s)"')
                                                                                                    || is(study, i, '"Arm')) ) {
                                                    temp['arm_description'] = cleanLine(study, i++);

                            // If its not the end of the array of objects move one more line to allow for object header.

                            if(!(is(study, i, '"Condition(s)/Problem(s)"')))
                                i++;
                        }

                        arm.push(temp);
                    }

                    finalRecord['arm'] = arm;
                }
        if (is(study, i, '"Condition(s)/Problem(s)"') && !is(study, ++i, '"Rare Disease"'))
                             finalRecord['conditions_problems'] = cleanLine(study, i++);

                  if (is(study, i, '"Rare Disease"') && !is(study, ++i, '"Inclusion Criteria"'))
                                         finalRecord['rare_disease'] = cleanLine(study, i++);
         if (is(study, i++, '"Inclusion Criteria"')){
                    temp = {};

                    if (is(study, i, '"Gender"') && !is(study, ++i, '"Age"'))
                        temp['gender'] = cleanLine(study, i++);

                    if (is(study, i, '"Age"') && !is(study, ++i, '"Description"'))
                        temp['age'] = cleanLine(study, i++);

                    if (is(study, i, '"Description"') && !is(study, ++i, '"Exclusion Criteria"'))
                        temp['description'] = cleanLine(study, i++);


                    finalRecord['inclusion_criteria'] = temp;
                }

if (is(study, i, '"Exclusion Criteria"') && !is(study, ++i, '"Healthy Volunteers"'))
                                  finalRecord['exclusion_criteria'] = cleanLine(study, i++);

 if (is(study, i, '"Healthy Volunteers"') && !is(study, ++i, '"Type of Primary Outcome"'))
                                  finalRecord['healthy_volunteers'] = cleanLine(study, i++);

 if (is(study, i, '"Type of Primary Outcome"') && !is(study, ++i, '"Primary Outcome(s) 1"'))
                                  finalRecord['type_of_primary_outcome'] = cleanLine(study, i++);

 if (is(study, i++, "Primary Outcome(s) 1")) {
                    primaryOutcome = [];

                    while (!is(study, i, '"Secondary Outcome(s) 1"')) {
                        temp = {};

                        if (is(study, i, '"- Outcome"') && !is(study, ++i, '"- Timepoint"'))
                            temp['outcome'] = cleanLine(study, i++);


                         if (is(study, i, '"- Timepoint"') && !(is(study, ++i, '"Secondary Outcome(s) 1"')
                                                                                                    || is(study, i, '"Primary Outcome')) ) {
                                                    temp['timepoint'] = cleanLine(study, i++);

                            // If its not the end of the array of objects move one more line to allow for object header.

                            if(!(is(study, i, '"Secondary Outcome(s) 1"')))
                                i++;
                        }

                        primaryOutcome.push(temp);
                    }

                    finalRecord['primary_Outcome'] = primaryOutcome;
                }
 if (is(study, i++, "Secondary Outcome(s) 1")) {
                   secondaryOutcome = [];

                    while (!is(study, i, '"Result Registerd"')) {
                        temp = {};

                        if (is(study, i, '"- Outcome"') && !is(study, ++i, '"- Timepoint"'))
                            temp['outcome'] = cleanLine(study, i++);


                         if (is(study, i, '"- Timepoint"') && !(is(study, ++i, '"Result Registerd"')
                                                                                                    || is(study, i, '"Secondary Outcome')) ) {
                                                    temp['timepoint'] = cleanLine(study, i++);

                            // If its not the end of the array of objects move one more line to allow for object header.

                            if(!(is(study, i, '"Result Registerd"')))
                                i++;
                        }

                        secondaryOutcome.push(temp);
                    }

                    finalRecord['secondary_Outcome'] = secondaryOutcome;
                }
if (is(study, i, '"Result Registerd"') && !is(study, ++i, '"Sharing Statement"'))
                                  finalRecord['result_registerd'] = cleanLine(study, i++);
 if (is(study, i, '"Sharing Statement"') && !is(study, ++i, '"Time of Sharing"'))
                                  finalRecord['sharing_statement'] = cleanLine(study, i++);
if (is(study, i, '"Time of Sharing"') && !is(study, ++i, '"Way of Sharing"'))
                                  finalRecord['time_of_sharing'] = cleanLine(study, i++);
 if (is(study, i, '"Way of Sharing"'))
                 finalRecord['way_of_sharing'] = cleanLine(study, i++);

      process.stdout.write(JSON.stringify(finalRecord) + '\n');
}});

function is(study, i, compareTo) {
    if (i>=study.length) return false;

    let line = study[i];

    return (line && line.indexOf(compareTo) !== -1);
}

function cleanLine(study, i) {
    if (i>=study.length) return '';

    let line = study[i];
    line = line.replace(/"/g, '');
    line = line.replace(/text: /g, '');

    return line.trim();
}