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
    let primaryOutcomes = [];
    let secondaryOutcomes = [];
    let contactPerson = [];
    let sourceMonetary = [];
    let Sponsor = [];
    let Arm = [];
    let temp = null;
    let curObject = null;
    let curKey = null;

    for (let i = 0; i < study.length; i++) {
        let line = study[i];
        
        if (is(line, '"CRIS Registration Number"')) {
            curKey = "cris_registration_number";
        } else if (is(line, '"Unique Protocol ID"') ) {
            curKey = "unique_protocol id";
        } else if (is(line, '"Public/Brief Title"') ) {
            curKey = "public_or_brief_title";
        } else if (is(line, '"Scientific Title"') ) {
            curKey = "scientific_title";
        } else if (is(line, '"Acronym"') ) {
            curKey = "acronym";
        } else if (is(line, '"MFDS Regulated Study"') ) {
            curKey = "mfds_regulated_study";
        } else if (is(line, '"IND/IDE Protocol"') ) {
            curKey = "ind_ide_protocol";
        } else if (is(line, '"Registered at Other Registry"') ) {
            curKey = "registered_at_other_registry";
        } else if (is(line, '"Healthcare Benefit Approval"') ) {
            curKey = "healthcare_benefit_approval_status";
        } else if (is(line, '"Board Approval Status"') ) {
            curKey = "board_approval_status";
        } else if (is(line, '"Board Approval Number"') ) {
            curKey = "board_approval_number";
        } else if (is(line, '"Approval Date"') ) {
            curKey = "approval_date";
        } else if (is(line, '"Data Monitoring Committee"') ) {
            curKey = "data_monitoring_committee";
        } else if (is(line, "Contact Person for ") ) {
            curObject = "Contact Person";
            if (temp != null) contactPerson.push(temp);
            temp = {};
            curKey = null;
        } else if (curObject === "Contact Person" && is(line, "- Name") ) {
            curKey = "name";
        } else if (curObject === "Contact Person" && is(line, "- Title") ) {
            curKey = "title";
        } else if (curObject === "Contact Person" && is(line, "- Telephone") ) {
            curKey = "telephone";
        } else if (curObject === "Contact Person" && is(line, "- Affiliation") ) {
            curKey = "affiliation";
        } else if (curObject === "Contact Person" && is(line, "- Address") ) {
            curKey = "address";
        } else if (curObject === "Contact Person" && curKey !== null && is(line, "text") ) {
            temp[curKey] = cleanLine(line);
            curKey = null; // reset the curKey
        } else if (is(line, '"Study Site"') ) {
            curKey = "study_site";
        } else if (is(line, '"Overall Recruitment Status"') ) {
            curKey = "overall_recruitment_status";
        } else if (is(line, '"Date of First Enrollment"') ) {
            curKey = "date_of_first_enrollment";
        } else if (is(line, '"Target Number of Participant"') ) {
            curKey = "target_number_of_participant";
        } else if (is(line, '"Primary Completion Date"') ) {
            curKey = "primary_completion_date";
        } else if (is(line, '"Study Completion Date"') ) {
            curKey = "study_completion_date";
        } else if (is(line, "Recruitment Status by Participating Study Site") ) {
            curObject = "Site";
            if (temp != null) sites.push(temp);
            temp = {};
            curKey = null;
        } else if (curObject === "Site" && is(line, "Name of Study Site") ) {
            curKey = "name_of_study_site";
        } else if (curObject === "Site" && is(line, "Recruitment Status") ) {
            curKey = "recruitment_status";
        } else if (curObject === "Site" && is(line, "Date of First Enrollment") ) {
            curKey = "date_of_first_enrollment";
        } else if (curObject === "Site" && curKey !== null && is(line, "text") ) {
            temp[curKey] = cleanLine(line);
            curKey = null; // reset the curKey
        } else if (is(line, "Source of Monetary/Material Support") ) {
            curObject = "source_of_monetary_or_material_support";
            if (temp != null) sourceMonetary.push(temp);
            temp = {};
            curKey = null;
        } else if (curObject === "source_of_monetary_or_material_support" && is(line, "- Organization Name") ) {
            curKey = "organization_name";
        } else if (curObject === "source_of_monetary_or_material_support" && is(line, "- Organization Type") ) {
            curKey = "organization_type";
        } else if (curObject === "source_of_monetary_or_material_support" && is(line, "- Project ID") ) {
            curKey = "project_id";
        } else if (curObject === "source_of_monetary_or_material_support" && curKey !== null && is(line, "text") ) {
            temp[curKey] = cleanLine(line);
            curKey = null; // reset the curKey
        } else if (is(line, "Sponsor Organization") ) {
            curObject = "Sponsor";
            if (temp != null) Sponsor.push(temp);
            temp = {};
            curKey = null;
        } else if (curObject === "Sponsor" && is(line, "- Organization Name") ) {
            curKey = "sponsor_organization_name";
        } else if (curObject === "Sponsor" && is(line, "- Organization Type") ) {
            curKey = "sponsor_organization_type";
        } else if (curObject === "Sponsor" && curKey !== null && is(line, "text") ) {
            temp[curKey] = cleanLine(line);
            curKey = null; // reset the curKey
        } else if (is(line, '"Lay Summary"') ) {
            curKey = "lay_summary";
        } else if (is(line, '"Study Type"') ) {
            curKey = "study_type";
        } else if (is(line, '"Study Purpose"') ) {
            curKey = "study_purpose";
        } else if (is(line, '"Phase"') ) {
            curKey = "phase";
        } else if (is(line, '"Intervention Model"') ) {
            curKey = "intervention_model";
        } else if (is(line, '"Blinding/Masking"') ) {
            curKey = "blinding_or_masking";
        } else if (is(line, '"Allocation"') ) {
            curKey = "allocation";
        } else if (is(line, '"Intervention Type"') ) {
            curKey = "intervention_type";
        } else if (is(line, '"Intervention Description"') ) {
            curKey = "intervention_description";
        } else if (is(line, '"Number of Arms"') ) {
            curKey = "number_of_arms";
        } else if (is(line, "Arm Label") ) {
            curKey = "arm_label";
        } else if (is(line, "Target Number of Participant") ) {
            curKey = "target_number_of_participant";
        } else if (is(line, "Arm Type") ) {
            curKey = "arm_type";
        } else if (is(line, "Arm Description") ) {
            curKey = "arm_description";
        } else if (is(line, '"Condition(s)/Problem(s)"')) {
            curKey = "conditions_problems";
        } else if (is(line, '"Rare Disease"') ) {
            curKey = "rare_disease";
        } else if (is(line, '"Gender"') ) {
            curKey = "gender";
        } else if (is(line, '"Age"') ) {
            curKey = "age";
        } else if (is(line, '"Description"') ) {
            curKey = "description";
        } else if (is(line, '"Exclusion Criteria"') ) {
            curKey = "exclusion_criteria";
        } else if (is(line, '"Healthy Volunteers"') ) {
            curKey = "healthy_volunteers";
        } else if (is(line, '"Type of Primary Outcome"') ) {
            curKey = "type_of_primary_outcome";
        } else if (is(line, "Primary Outcome(s)")) {
            curObject = "Primary Outcome";
            if (temp != null) primaryOutcomes.push(temp);
            temp = {};
            curKey = null;
        } else if (curObject === "Primary Outcome" && is(line, "- Outcome") ) {
            curKey = "outcome";
        } else if (curObject === "Primary Outcome" && is(line, "- Timepoint") ) {
            curKey = "timepoint";
        } else if (curObject === "Primary Outcome" && curKey !== null && is(line, "text") ) {
            temp[curKey] = cleanLine(line);
            curKey = null; // reset the curKey
        } else if (is(line, "Secondary Outcome(s) ")) {
            curObject = "Secondary Outcome";
            if (temp != null) secondaryOutcomes.push(temp);
            temp = {};
            curKey = null;
        } else if (curObject === "Secondary Outcome" && is(line, "- Outcome") ) {
            curKey = "outcome";
        } else if (curObject === "Secondary Outcome" && is(line, "- Timepoint") ) {
            curKey = "timepoint";
        } else if (curObject === "Secondary Outcome" && curKey !== null && is(line, "text") ) {
            temp[curKey] = cleanLine(line);
            curKey = null; // reset the curKey
        } else if (is(line, '"Result Registerd"') ) {
            curKey = "result_registerd";
        } else if (is(line, '"Sharing Statement"') ) {
            curKey = "sharing_statement";
        } else { // catchall
            if (curKey !== null && is(line, "text") ) {
                finalRecord[curKey] = cleanLine(line);
                curKey = null;
            }
        }
    }

    finalRecord['sites'] = sites;
    finalRecord['subject Eligibility and study design'] = primaryOutcomes;
    finalRecord['primary_outcomes'] = secondaryOutcomes;
    finalRecord['Contact Person'] = contactPerson;
    finalRecord['site'] = sourceMonetary;
    finalRecord['source_of_monetary_or_material_support'] = Sponsor;
    
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