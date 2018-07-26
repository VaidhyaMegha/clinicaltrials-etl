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
        if (is(study[i], '"CRIS Registration Number"') && !is(study[++i], '"Unique Protocol ID"'))
            finalRecord['cris_registration_number'] = cleanLine(study[i++]);

        if (is(study[i], '"Unique Protocol ID"') && !is(study[++i], '"Public/Brief Title"'))
            finalRecord['unique_protocol_id'] = cleanLine(study[i++]);

        if (is(study[i], '"Public/Brief Title"') && !is(study[++i], '"Scientific Title"'))
            finalRecord['public_or_brief_title'] = cleanLine(study[i++]);

        if (is(study[i], '"Scientific Title"') && !is(study[++i], '"Acronym"'))
            finalRecord['scientific_title'] = cleanLine(study[i++]);

        if (is(study[i], '"Acronym"') && !is(study[++i], '"MFDS Regulated Study"'))
            finalRecord['acronym'] = cleanLine(study[i++]);

        if (is(study[i], '"MFDS Regulated Study"') && !is(study[++i], '"IND/IDE Protocol"'))
            finalRecord['mfds_regulated_study'] = cleanLine(study[i++]);

        if (is(study[i], '"IND/IDE Protocol"') && !is(study[++i], '"Registered at Other Registry"'))
            finalRecord['ind_ide_protocol'] = cleanLine(study[i++]);

        if (is(study[i], '"Registered at Other Registry"') && !is(study[++i], '"Healthcare Benefit Approval Status"'))
            finalRecord['registered_at_other_registry'] = cleanLine(study[i++]);

        if (is(study[i], '"Healthcare Benefit Approval Status"') && !is(study[++i], '"Board Approval Status"'))
            finalRecord['healthcare_benefit_approval_status'] = cleanLine(study[i++]);

        if (is(study[i], '"Board Approval Status"') && !is(study[++i], '"Board Approval Number"'))
            finalRecord['board_approval_status'] = cleanLine(study[i++]);

        if (is(study[i], '"Board Approval Number"') && !is(study[++i], '"Approval Date"'))
            finalRecord['board_approval_number'] = cleanLine(study[i++]);

        if (is(study[i], '"Approval Date"') && !is(study[++i], '"Institutional Review Board"'))
            finalRecord['approval_date'] = cleanLine(study[i++]);

        // check for the current line and move to next line. If its the start of an object get inside
        if (is(study[i++], '"Institutional Review Board"')){
            temp = {};

            // check for the current line and move to next line. Check if next line is a 'key' if not it must be a value.
            if (is(study[i], '"- Name"') && !is(study[++i], '"- Address"'))
                temp['name'] = cleanLine(study[i++]);

            if (is(study[i], '"- Address"') && !is(study[++i], '"- Telephone"'))
                temp['address'] = cleanLine(study[i++]);

            if (is(study[i], '"- Telephone"') && !is(study[++i], '"Data Monitoring Committee"'))
                temp['telephone'] = cleanLine(study[i++]);

            finalRecord['institutional_review_board'] = temp;
        }

        if (is(study[i], '"Data Monitoring Committee"') && !is(study[++i], '"Contact Person for Principal Investigator / Scientific Queries"'))
            finalRecord['data_monitoring_committee'] = cleanLine(study[i++]);

        if (is(study[i++], '"Contact Person for Principal Investigator / Scientific Queries"')){
            temp = {};

            if (is(study[i], '"- Name"') && !is(study[++i], '"- Title"'))
                temp['name'] = cleanLine(study[i++]);

            if (is(study[i], '"- Title"') && !is(study[++i], '"- Telephone"'))
                temp['title'] = cleanLine(study[i++]);

            if (is(study[i], '"- Telephone"') && !is(study[++i], '"- Affiliation"'))
                temp['telephone'] = cleanLine(study[i++]);

            if (is(study[i], '"- Affiliation"') && !is(study[++i], '"- Address"'))
                temp['affiliation'] = cleanLine(study[i++]);

            if (is(study[i], '"- Address"') && !is(study[++i], '"Contact Person for Public Queries"'))
                temp['address'] = cleanLine(study[i++]);

            finalRecord['contact_for_scientific_queries'] = temp;
        }

        if (is(study[i++], '"Contact Person for Public Queries"')){
            temp = {};

            if (is(study[i], '"- Name"') && !is(study[++i], '"- Title"'))
                temp['name'] = cleanLine(study[i++]);

            if (is(study[i], '"- Title"') && !is(study[++i], '"- Telephone"'))
                temp['title'] = cleanLine(study[i++]);

            if (is(study[i], '"- Telephone"') && !is(study[++i], '"- Affiliation"'))
                temp['telephone'] = cleanLine(study[i++]);

            if (is(study[i], '"- Affiliation"') && !is(study[++i], '"- Address"'))
                temp['affiliation'] = cleanLine(study[i++]);

            if (is(study[i], '"- Address"') && !is(study[++i], '"Contact Person for Updating Information"'))
                temp['address'] = cleanLine(study[i++]);

            finalRecord['contact_for_public_queries'] = temp;
        }

        if (is(study[i++], '"Contact Person for Updating Information"')){
            temp = {};

            if (is(study[i], '"- Name"') && !is(study[++i], '"- Title"'))
                temp['name'] = cleanLine(study[i++]);

            if (is(study[i], '"- Title"') && !is(study[++i], '"- Telephone"'))
                temp['title'] = cleanLine(study[i++]);

            if (is(study[i], '"- Telephone"') && !is(study[++i], '"- Affiliation"'))
                temp['telephone'] = cleanLine(study[i++]);

            if (is(study[i], '"- Affiliation"') && !is(study[++i], '"- Address"'))
                temp['affiliation'] = cleanLine(study[i++]);

            if (is(study[i], '"- Address"') && !is(study[++i], '"Study Site"'))
                temp['address'] = cleanLine(study[i++]);

            finalRecord['contact_for_updating_information'] = temp;
        }


        if (is(study[i], '"Study Site"') && !is(study[++i], '"Overall Recruitment Status"'))
            finalRecord['study_site'] = cleanLine(study[i++]);

        if (is(study[i], '"Overall Recruitment Status"') && !is(study[++i], '"Date of First Enrollment"'))
            finalRecord['overall_recruitment_status'] = cleanLine(study[i++]);

        if (is(study[i], '"Date of First Enrollment"') && !is(study[++i], '"Target Number of Participant"'))
            finalRecord['date_of_first_enrollment'] = cleanLine(study[i++]);

        if (is(study[i], '"Target Number of Participant"') && !is(study[++i], '"Primary Completion Date"'))
            finalRecord['target_number_of_participants'] = cleanLine(study[i++]);

        if (is(study[i], '"Primary Completion Date"') && !is(study[++i], '"Study Completion Date"'))
            finalRecord['primary_completion_date'] = cleanLine(study[i++]);

        if (is(study[i], '"Study Completion Date"') && !is(study[++i], '"Recruitment Status by Participating Study Site 1"'))
            finalRecord['study_completion_date'] = cleanLine(study[i++]);


        // check for the current line and move to next line. If its the start of an array of objects get inside

        if (is(study[i++], "Recruitment Status by Participating Study Site 1")) {
            sites = [];

            while (!is(study[i], '"Source of Monetary/Material Support1"')) {
                temp = {};

                if (is(study[i], '"- Name of Study Site"') && !is(study[++i], '"- Recruitment Status"'))
                    temp['name_of_study_site'] = cleanLine(study[i++]);

                if (is(study[i], '"- Recruitment Status"') && !is(study[++i], '"- Date of First Enrollment"'))
                    temp['recruitment_status'] = cleanLine(study[i++]);

                // check for the current line and move to next line. If its not the end of the current object or end of the array of objects it must be value

                if (is(study[i], '"- Date of First Enrollment"') && !(is(study[++i], '"Source of Monetary/Material Support1"')
                                                                    || is(study[i], '"Recruitment Status by Participating Study Site')) ) {
                    temp['date_of_first_enrollment'] = cleanLine(study[i++]);

                    // If its not the end of the array of objects move one more line to allow for object header.

                    if(!(is(study[i], '"Source of Monetary/Material Support1"')))
                        i++;
                }

                sites.push(temp);
            }

            finalRecord['sites'] = sites;
        }

        //     if (is(line, '"Study Site"')) {
        //         curKey = "study_site";
        //     }
        //     if (is(line, '"Overall Recruitment Status"')) {
        //         curKey = "overall_recruitment_status";
        //     }
        //     if (is(line, '"Date of First Enrollment"')) {
        //         curKey = "date_of_first_enrollment";
        //     }
        //     if (is(line, '"Target Number of Participant"')) {
        //         curKey = "target_number_of_participant";
        //     }
        //     if (is(line, '"Primary Completion Date"')) {
        //         curKey = "primary_completion_date";
        //     }
        //     if (is(line, '"Study Completion Date"')) {
        //         curKey = "study_completion_date";
        //     }
        //     if (is(line, "Recruitment Status by Participating Study Site")) {
        //         curObject = "Site";
        //         if (temp != null) sites.push(temp);
        //         temp = {};
        //         curKey = null;
        //     }
        //     if (curObject === "Site" && is(line, "Name of Study Site")) {
        //         curKey = "name_of_study_site";
        //     }
        //     if (curObject === "Site" && is(line, "Recruitment Status")) {
        //         curKey = "recruitment_status";
        //     }
        //     if (curObject === "Site" && is(line, "Date of First Enrollment")) {
        //         curKey = "date_of_first_enrollment";
        //     }
        //     if (curObject === "Site" && curKey !== null && is(line, "text")) {
        //         temp[curKey] = cleanLine(line);
        //         curKey = null; // reset the curKey
        //     }
        //     if (is(line, "Source of Monetary/Material Support")) {
        //         curObject = "source_of_monetary_or_material_support";
        //         if (temp != null) sourceMonetary.push(temp);
        //         temp = {};
        //         curKey = null;
        //     }
        //     if (curObject === "source_of_monetary_or_material_support" && is(line, "- Organization Name")) {
        //         curKey = "organization_name";
        //     }
        //     if (curObject === "source_of_monetary_or_material_support" && is(line, "- Organization Type")) {
        //         curKey = "organization_type";
        //     }
        //     if (curObject === "source_of_monetary_or_material_support" && is(line, "- Project ID")) {
        //         curKey = "project_id";
        //     }
        //     if (curObject === "source_of_monetary_or_material_support" && curKey !== null && is(line, "text")) {
        //         temp[curKey] = cleanLine(line);
        //         curKey = null; // reset the curKey
        //     }
        //     if (is(line, "Sponsor Organization")) {
        //         curObject = "Sponsor";
        //         if (temp != null) Sponsor.push(temp);
        //         temp = {};
        //         curKey = null;
        //     }
        //     if (curObject === "Sponsor" && is(line, "- Organization Name")) {
        //         curKey = "sponsor_organization_name";
        //     }
        //     if (curObject === "Sponsor" && is(line, "- Organization Type")) {
        //         curKey = "sponsor_organization_type";
        //     }
        //     if (curObject === "Sponsor" && curKey !== null && is(line, "text")) {
        //         temp[curKey] = cleanLine(line);
        //         curKey = null; // reset the curKey
        //     }
        //     if (is(line, '"Lay Summary"')) {
        //         curKey = "lay_summary";
        //     }
        //     if (is(line, '"Study Type"')) {
        //         curKey = "study_type";
        //     }
        //     if (is(line, '"Study Purpose"')) {
        //         curKey = "study_purpose";
        //     }
        //     if (is(line, '"Phase"')) {
        //         curKey = "phase";
        //     }
        //     if (is(line, '"Intervention Model"')) {
        //         curKey = "intervention_model";
        //     }
        //     if (is(line, '"Blinding/Masking"')) {
        //         curKey = "blinding_or_masking";
        //     }
        //     if (is(line, '"Allocation"')) {
        //         curKey = "allocation";
        //     }
        //     if (is(line, '"Intervention Type"')) {
        //         curKey = "intervention_type";
        //     }
        //     if (is(line, '"Intervention Description"')) {
        //         curKey = "intervention_description";
        //     }
        //     if (is(line, '"Number of Arms"')) {
        //         curKey = "number_of_arms";
        //     }
        //     if (is(line, "Arm Label")) {
        //         curKey = "arm_label";
        //     }
        //     if (is(line, "Target Number of Participant")) {
        //         curKey = "target_number_of_participant";
        //     }
        //     if (is(line, "Arm Type")) {
        //         curKey = "arm_type";
        //     }
        //     if (is(line, "Arm Description")) {
        //         curKey = "arm_description";
        //     }
        //     if (is(line, '"Condition(s)/Problem(s)"')) {
        //         curKey = "conditions_problems";
        //     }
        //     if (is(line, '"Rare Disease"')) {
        //         curKey = "rare_disease";
        //     }
        //     if (is(line, '"Gender"')) {
        //         curKey = "gender";
        //     }
        //     if (is(line, '"Age"')) {
        //         curKey = "age";
        //     }
        //     if (is(line, '"Description"')) {
        //         curKey = "description";
        //     }
        //     if (is(line, '"Exclusion Criteria"')) {
        //         curKey = "exclusion_criteria";
        //     }
        //     if (is(line, '"Healthy Volunteers"')) {
        //         curKey = "healthy_volunteers";
        //     }
        //     if (is(line, '"Type of Primary Outcome"')) {
        //         curKey = "type_of_primary_outcome";
        //     }
        //     if (is(line, "Primary Outcome(s)")) {
        //         curObject = "Primary Outcome";
        //         if (temp != null) primaryOutcomes.push(temp);
        //         temp = {};
        //         curKey = null;
        //     }
        //     if (curObject === "Primary Outcome" && is(line, "- Outcome")) {
        //         curKey = "outcome";
        //     }
        //     if (curObject === "Primary Outcome" && is(line, "- Timepoint")) {
        //         curKey = "timepoint";
        //     }
        //     if (curObject === "Primary Outcome" && curKey !== null && is(line, "text")) {
        //         temp[curKey] = cleanLine(line);
        //         curKey = null; // reset the curKey
        //     }
        //     if (is(line, "Secondary Outcome(s) ")) {
        //         curObject = "Secondary Outcome";
        //         if (temp != null) secondaryOutcomes.push(temp);
        //         temp = {};
        //         curKey = null;
        //     }
        //     if (curObject === "Secondary Outcome" && is(line, "- Outcome")) {
        //         curKey = "outcome";
        //     }
        //     if (curObject === "Secondary Outcome" && is(line, "- Timepoint")) {
        //         curKey = "timepoint";
        //     }
        //     if (curObject === "Secondary Outcome" && curKey !== null && is(line, "text")) {
        //         temp[curKey] = cleanLine(line);
        //         curKey = null; // reset the curKey
        //     }
        //     if (is(line, '"Result Registerd"')) {
        //         curKey = "result_registerd";
        //     }
        //     if (is(line, '"Sharing Statement"')) {
        //         curKey = "sharing_statement";
        //     }
        // }
        //
        // finalRecord['sites'] = sites;
        // finalRecord['subject Eligibility and study design'] = primaryOutcomes;
        // finalRecord['primary_outcomes'] = secondaryOutcomes;
        // finalRecord['Contact Person'] = contactPerson;
        // finalRecord['site'] = sourceMonetary;
        // finalRecord['source_of_monetary_or_material_support'] = Sponsor;
    }
    process.stdout.write(JSON.stringify(finalRecord) + '\n');
});

function is(line, compareTo) {
    return (line.indexOf(compareTo) !== -1);
}

function cleanLine(l) {
    let line = l;
    line = line.replace(/"/g, '');
    line = line.replace(/text: /g, '');

    return line.trim();
}