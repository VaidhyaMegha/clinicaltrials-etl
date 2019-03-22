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

         while (!is(study, i, '"SLCTR Registration Number"')) {
                         i++
         }


        // check for the current line and move to next line. Check if next line is a 'key' if not it must be a value.
        if (is(study, i, '"SLCTR Registration Number"') && !is(study, ++i, '"Date of Registration"'))
        finalRecord['slctr_registration_number'] = cleanLine(study, i++);

        if (is(study, i, '"Date of Registration"') && !is(study, ++i, '"The date of last modification"'))
        finalRecord['DateOfRegistration'] = cleanLine(study, i++);

        if (is(study, i, '"The date of last modification"') && !is(study, ++i, '"Trial Status"'))
        finalRecord['date_of_last_modification'] = cleanLine(study, i++);

        if (is(study, i, '"Trial Status"') && !is(study, ++i, '"Application Summary"'))
        { finalRecord['TrialStatus'] = cleanLine(study, i++);}
        else if (is(study, i, '"Trial Status"'))
        { finalRecord['TrialStatus']=null; i++; }

        if (is(study, i, '"Application Summary"'))
        i++

        if (is(study, i, '"Scientific Title of Trial"') && !is(study, ++i, '"Public Title of Trial"'))
        finalRecord['ScientificTitleOftrial'] = cleanLine(study, i++);

        if (is(study, i, '"Public Title of Trial"') && !is(study, ++i, '"Disease of Health Condition(s) Studied"'))
        finalRecord['PublicTitleOftrial'] = cleanLine(study, i++);

        if (is(study, i, '"Disease of Health Condition(s) Studied"') && !is(study, ++i, '"Scientific Acronym"'))
        finalRecord['DiseaseOfHealthConditionStudied'] = cleanLine(study, i++);

        if (is(study, i, '"Scientific Acronym"') && !is(study, ++i, '"Public Acronym"'))
        finalRecord['ScientificAcronym'] = cleanLine(study, i++);

        if (is(study, i, '"Public Acronym"') && !is(study, ++i, '"Brief title"'))
        finalRecord['PublicAcronym'] = cleanLine(study, i++);

        if (is(study, i, '"Brief title"') && !is(study, ++i, '"Universal Trail Number"'))
        finalRecord['BriefTitle'] = cleanLine(study, i++);

        if (is(study, i, '"Universal Trail Number"') && !is(study, ++i, '"Any other number(s) assigned to the trial and issuing authority"'))
        finalRecord['UniversalTrialNumber'] = cleanLine(study, i++);

        if (is(study, i, '"Any other number(s) assigned to the trial and issuing authority"') && !is(study, ++i, '"Trial Details"'))
        finalRecord['SecondaryId'] = cleanLine(study, i++);

        if (is(study, i, '"Trial Details"'))
        i++

        if (is(study, i, "What is the research question being addressed?")) {
            source = [];
            while (!is(study, ++i, '"Type of study"')) {
                source.push(cleanLine(study, i));
                }
            finalRecord['ResearchQuestion'] = source;
        }

        if (is(study, i, '"Type of study"') && !is(study, ++i, '"Study design"'))
        finalRecord['TypeOfStudy'] = cleanLine(study, i++);

        if (is(study, i, '"Study design"') && !is(study, ++i, '"Allocation"'))
        finalRecord['StudyDesign'] = cleanLine(study, i++);

        if (is(study, i, '"Allocation"') && !is(study, ++i, '"Masking"'))
        finalRecord['Allocation'] = cleanLine(study, i++);

        if (is(study, i, '"Masking"') && !is(study, ++i, '"Control"'))
        finalRecord['Masking'] = cleanLine(study, i++);

        if (is(study, i, '"Control"') && !is(study, ++i, '"Assignment"'))
        finalRecord['Control'] = cleanLine(study, i++);

        if (is(study, i, '"Assignment"') && !is(study, ++i, '"Purpose"'))
        finalRecord['Assignment'] = cleanLine(study, i++);

        if (is(study, i, '"Purpose"') && !is(study, ++i, '"Intervention(s) planned"'))
        finalRecord['Purpose'] = cleanLine(study, i++);

        if (is(study, i, '"Intervention(s) planned"') && !is(study, ++i, '"Inclusion criteria"'))
        finalRecord['InterventionsPlanned'] = cleanLine(study, i++);

        if (is(study, i, '"Inclusion criteria"') && !is(study, ++i, '"Exclusion criteria"'))
        finalRecord['InclusionCriteria'] = cleanLine(study, i++);

        if (is(study, i, '"Exclusion criteria"') && !is(study, ++i, '"Primary outcome(s)"'))
        finalRecord['ExclusionCriteria'] = cleanLine(study, i++);


        if (is(study, i, '"Primary outcome(s)"') && !is(study, ++i, '"Primary outcome(s) - Time of assessment(s)"'))
        finalRecord['PrimaryOutcome'] = cleanLine(study, i++);


        if (is(study, i, '"Primary outcome(s) - Time of assessment(s)"') && !is(study, ++i, '"Secondary outcome"'))
        finalRecord['PrimaryOutcomeTime'] = cleanLine(study, i++);


        if (is(study, i, '"Secondary outcome"') && !is(study, ++i, '"Secondary outcome(s) - Time of assessment(s)"'))
        finalRecord['SecondaryOutcome'] = cleanLine(study, i++);

        if (is(study, i, '"Secondary outcome(s) - Time of assessment(s)"') && !is(study, ++i, '"Target number/sample size"'))
        finalRecord['SecondaryOutcomeTime'] = cleanLine(study, i++);

        if (is(study, i, '"Target number/sample size"') && !is(study, ++i, '"Countries of recruitment"'))
        finalRecord['TargetNumber'] = cleanLine(study, i++);

        if (is(study, i, '"Countries of recruitment"') && !is(study, ++i, '"Anticipated start date"'))
        finalRecord['CountriesOfRecruitment'] = cleanLine(study, i++);


        if (is(study, i, '"Anticipated start date"') && !is(study, ++i, '"Anticipated end date"'))
        finalRecord['AnticipatedStartDate'] = cleanLine(study, i++);

        if (is(study, i, '"Anticipated end date"') && !is(study, ++i, '"Recruitment status"'))
        finalRecord['AnticipatedEndDate'] = cleanLine(study, i++);

        if (is(study, i, '"Recruitment status"') && !is(study, ++i, '"State of ethics review approval"'))
        finalRecord['RecruitmentStatus'] = cleanLine(study, i++);


        if (is(study, i, '"State of ethics review approval"') && !is(study, ++i, '"Funding source"'))
        finalRecord['StateOfEthicsApproval'] = cleanLine(study, i++);

        if (is(study, i, '"Funding source"') && !is(study, ++i, '"Contact \u0026amp; Sponsor Information"'))
        finalRecord['FundingSource'] = cleanLine(study, i++);

        i++;
        if (is(study, i, "Contact person for Scientific Queries/Principal Investigator")) {
        source = [];
        while (!is(study, ++i, '"Contact Person for Public Queries"')) {

            source.push(cleanLine(study, i));
            }
        finalRecord['ContactForScientificQueries'] = source;
        }


        if (is(study, i, "Contact Person for Public Queries")) {
        source = [];
        while (!is(study, ++i, '"Primary study sponsor/organization"')) {
            source.push(cleanLine(study, i));
            }
        finalRecord['ContactForPublicQueries'] = source;
        }

        if (is(study, i, "Primary study sponsor/organization")) {
        source = [];
        while (!is(study, ++i, '"Secondary study sponsor (If any)"')) {
            source.push(cleanLine(study, i));
            }
        finalRecord['PrimarySponsors'] = source;
        }

        if (is(study, i, "Secondary study sponsor (If any)")) {
        source = [];
        while (!is(study, ++i, '"Trial Options"')) {
            source.push(cleanLine(study, i));
            }
        finalRecord['SecondarySponsors'] = source;
        }


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
