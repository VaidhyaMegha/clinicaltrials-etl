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
        if (is(study, i, '"View original TRDS"') )
            i=i+2;

        if (is(study, i, '"Trial Status"') && !is(study, ++i, '"Application Summary"'))
        { finalRecord['TrialStatus'] = cleanLine(study, i++);}


        if (is(study, i, '"Application Summary"'))
        i++;

        if (is(study, i, '"Scientific Title of Trial"') && !is(study, ++i, '"Public Title of Trial"'))
        finalRecord['ScientificTitleOftrial'] = cleanLine(study, i++);

        if (is(study, i, '"Public Title of Trial"') && !is(study, ++i, '"Disease or Health Condition(s) Studied"'))
        finalRecord['PublicTitleOftrial'] = cleanLine(study, i++);

        if (is(study, i, '"Disease or Health Condition(s) Studied"') && !is(study, ++i, '"Scientific Acronym"'))
        finalRecord['DiseaseOfHealthConditionStudied'] = cleanLine(study, i++);

        if (is(study, i, '"Scientific Acronym"') && !is(study, ++i, '"Public Acronym"'))
        finalRecord['ScientificAcronym'] = cleanLine(study, i++);

        if (is(study, i, '"Public Acronym"') && !is(study, ++i, '"Brief title"'))
        finalRecord['PublicAcronym'] = cleanLine(study, i++);

        if (is(study, i, '"Brief title"') && !is(study, ++i, '"Universal Trial Number"'))
        finalRecord['BriefTitle'] = cleanLine(study, i++);

        if (is(study, i, '"Universal Trial Number"') && !is(study, ++i, '"Any other number(s) assigned to the trial and issuing authority"'))
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

        if (is(study, i, '"Purpose"') && !is(study, ++i, '"Study Phase"'))
        finalRecord['Purpose'] = cleanLine(study, i++);

        if (is(study, i, '"Study Phase"') && !is(study, ++i, '"Intervention(s) planned"'))
            finalRecord['Purpose'] = cleanLine(study, i++);

        if (is(study, i, '"Intervention(s) planned"'))
        {
            source = [];
            while (!is(study, ++i, '"Inclusion criteria"')) {
                source.push(cleanLine(study, i));
            }
            finalRecord['InterventionsPlanned'] = source;
        }
        if (is(study, i, '"Inclusion criteria"') )
        { source = [];
            while (!is(study, ++i, '"Exclusion criteria"')) {
                source.push(cleanLine(study, i));
            }
            finalRecord['InclusionCriteria'] =source;}

        if (is(study, i, '"Exclusion criteria"') )
        {  source = [];
            while (!is(study, ++i, '"Primary outcome(s)"')) {
                source.push(cleanLine(study, i));;
            }

            finalRecord['ExclusionCriteria']=source ;
        }


        if (is(study, i, '"Primary outcome(s)"') )
        { source = [];
            while (!is(study, ++i, '"Secondary outcome(s)"')) {
                source.push(cleanLine(study, i));
            }

            finalRecord['PrimaryOutcome'] =source;
        }

        if (is(study, i, '"Secondary outcome(s)"') )
        { source = [];
            while (!is(study, ++i, '"Target number/sample size"')) {
                source.push(cleanLine(study, i));
            }

                finalRecord['SecondaryOutcome'] =source;
        }

         if (is(study, i, '"Target number/sample size"') && !is(study, ++i, '"Countries of recruitment"'))
        finalRecord['TargetNumber'] = cleanLine(study, i++);

        if (is(study, i, '"Countries of recruitment"') && !is(study, ++i, '"Anticipated start date"'))
        finalRecord['CountriesOfRecruitment'] = cleanLine(study, i++);


        if (is(study, i, '"Anticipated start date"') && !is(study, ++i, '"Anticipated end date"'))
        finalRecord['AnticipatedStartDate'] = cleanLine(study, i++);

        if (is(study, i, '"Anticipated end date"') && !is(study, ++i, '"Date of first enrollment"'))
        finalRecord['AnticipatedEndDate'] = cleanLine(study, i++);

        if (is(study, i, '"Date of first enrollment"') && !is(study, ++i, '"Date of study completion"'))
            finalRecord['Dateoffirstenrollment'] = cleanLine(study, i++);

        if (is(study, i, '"Date of study completion"') && !is(study, ++i, '"Recruitment status"'))
            finalRecord['Dateofstudycompletion'] = cleanLine(study, i++);





        if (is(study, i, '"Recruitment status"') && !is(study, ++i, '"State of ethics review approval"'))
        finalRecord['RecruitmentStatus'] = cleanLine(study, i++);


        if (is(study, i, '"State of ethics review approval"') && !is(study, ++i, '"Funding source"'))
        finalRecord['StateOfEthicsApproval'] = cleanLine(study, i++);

        if (is(study, i, '"Funding source"') && !is(study, ++i, '"Regulatory approvals"'))
        finalRecord['FundingSource'] = cleanLine(study, i++);

        if (is(study, i, '"Regulatory approvals"') && !is(study, ++i, '"State of Ethics Review Approval"'))
            finalRecord['Regulatoryapprovals'] = cleanLine(study, i++);

        i++;

        if (is(study, i, '"Status"') && !is(study, ++i, '"Date of Approval"'))
            finalRecord['Status'] = cleanLine(study, i++);

        if (is(study, i, '"Date of Approval"') && !is(study, ++i, '"Approval number"'))
            finalRecord['DateofApproval'] = cleanLine(study, i++);

        if (is(study, i, '"Approval number"') && !is(study, ++i, '"Details of Ethics Review Committee"'))
            finalRecord['Approvalnumber'] = cleanLine(study, i++);

        if (is(study, i, '"Details of Ethics Review Committee"') )
            i++;

        if (is(study, i, '"Name:"') && !is(study, ++i, '"Institutional Address:"'))
            finalRecord['Name'] = cleanLine(study, i++);

        if (is(study, i, '"Institutional Address:"') && !is(study, ++i, '"Telephone:"'))
            finalRecord['InstitutionalAddress'] = cleanLine(study, i++);

        if (is(study, i, '"Telephone:"') && !is(study, ++i, '"Email:"'))
            finalRecord['Telephone'] = cleanLine(study, i++);

        if (is(study, i, '"Email:"') && !is(study, ++i, '"Contact & Sponsor Information"'))
            finalRecord['Email'] = cleanLine(study, i++);
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
        while (!is(study, ++i, '"Trial Completion details"')) {
            source.push(cleanLine(study, i));
            }
        finalRecord['SecondarySponsors'] = source;
        }

i=i+2;


        if (is(study, i, '"IPD sharing plan description"') && !is(study, ++i, '"Study protocol available"'))
            finalRecord['IPDsharingplandescription'] = cleanLine(study, i++);

        if (is(study, i, '"Study protocol available"') && !is(study, ++i, '"Protocol version and date"'))
            finalRecord['Studyprotocolavailable'] = cleanLine(study, i++);

        if (is(study, i, '"Protocol version and date"') && !is(study, ++i, '"Protocol URL"'))
            finalRecord['Protocolversionanddate'] = cleanLine(study, i++);

        if (is(study, i, '"Protocol URL"') && !is(study, ++i, '"Results summary available"'))
            finalRecord['ProtocolURL'] = cleanLine(study, i++);

        if (is(study, i, '"Results summary available"') && !is(study, ++i, '"Date of posting results"'))
            finalRecord['Resultssummaryavailable'] = cleanLine(study, i++);

        if (is(study, i, '"Date of posting results"') && !is(study, ++i, '"Date of study completion"'))
            finalRecord['Dateofpostingresults'] = cleanLine(study, i++);

        if (is(study, i, '"Date of study completion"') && !is(study, ++i, '"Final sample size"'))
            finalRecord['Dateofstudycompletion'] = cleanLine(study, i++);
        if (is(study, i, '"Final sample size"') && !is(study, ++i, '"Date of first publication"'))
            finalRecord['Finalsamplesize'] = cleanLine(study, i++);
        if (is(study, i, '"Date of first publication"') && !is(study, ++i, '"Link to results"'))
            finalRecord['Dateoffirstpublication'] = cleanLine(study, i++);

        if (is(study, i, '"Link to results"') && !is(study, ++i, '"Brief summary of results"'))
            finalRecord['Linktoresults'] = cleanLine(study, i++);
        if (is(study, i, '"Brief summary of results"') && !is(study, ++i, '"Trial Options"'))
            finalRecord['Briefsummaryofresults'] = cleanLine(study, i++);




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
