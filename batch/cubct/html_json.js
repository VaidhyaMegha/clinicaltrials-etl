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

let i = 2;
{

// check for the current line and move to next line. Check if next line is a 'key' if not it must be a value.
if (is(study, i, '"Acronym of Public Title:"') && !is(study, ++i, '"Scientific title:"'))
finalRecord['Acronym_of_Public_Title'] = cleanLine(study, i++);

if (is(study, i, '"Scientific title:"') && !is(study, ++i, '"Acronym of Scientific Title:"'))
finalRecord['Scientific_Title'] = cleanLine(study, i++);

if (is(study, i, '"Acronym of Scientific Title:"') && !is(study, ++i, '"Secondary indentifying numbers:"'))
finalRecord['Acronym_Of_Scientific_Title'] = cleanLine(study, i++);

if (is(study, i++, "Secondary indentifying numbers:")) {
SecondaryIds = [];

while (!is(study, i, '"Issuing authority of the secondary identifying numbers:"')) {
        SecondaryIds.push(cleanLine(study, i++));
        if (is(study, i, "Primary sponsor:")) break;
    }
    finalRecord['SecondaryIDs'] = SecondaryIds;
}

if (is(study, i, '"Issuing authority of the secondary identifying numbers:"') && !is(study, ++i, '"Primary sponsor:"'))
    finalRecord['IssuingAuthotiryOfSecondaryIds'] = cleanLine(study, i++);

if (is(study, i++, "Primary sponsor:")) {
    PrimarySponsors = [];

    while (!is(study, i, '"Secondary sponsor:"')) {
        PrimarySponsors.push(cleanLine(study, i++));
         if (is(study, i, "Source(s) of moOutcomesAndTimepointsnetary or material support:")) break;
    }
    finalRecord['PrimarySponsors'] = PrimarySponsors;
}

if (is(study, i++, "Secondary sponsor:")) {
SecondarySponsors = [];

    while (!is(study, i, '"Source(s) of monetary or material support:"')) {
        SecondarySponsors.push(cleanLine(study, i++));
    }
    finalRecord['SecondarySponsors'] = SecondarySponsors;
}


if (is(study, i, '"Source(s) of monetary or material support:"') && !is(study, ++i, '"Authorization for beginning:"'))
    finalRecord['Source_Of_Monetary_Material_support'] = cleanLine(study, i++);
i = i+2

if (is(study, i, '"Regulatory instance to authorize the initiation of the study:"') && !is(study, ++i, '"Authorization date :"'))
    finalRecord['Regulatory_instance_to_authorize_the_initiation_of_the_study'] = cleanLine(study, i++);

if (is(study, i, '"Authorization date :"') && !is(study, ++i, '"Reference number:"'))
    finalRecord['AuthorizationDate'] = cleanLine(study, i++);

if (is(study, i, '"Reference number:"') && !is(study, ++i, '"Principal investigator"'))
    finalRecord['ReferenceNumber'] = cleanLine(study, i++);

if (is(study, i++, "Principal investigator")) {
    source = [];
    temp = {};
    tempEmail = [];
    while (!is(study, i++, '"Clinical sites to participate"')) {
        if (is(study, i, '"First name:"') && !is(study, ++i, '"Last name:"'))
        temp['First_Name'] = cleanLine(study, i++);

        if (is(study, i, '"Last name:"') && !is(study, ++i, '"Medical Specialty :"'))
        temp['Last_Name'] = cleanLine(study, i++);

        if (is(study, i, '"Medical Specialty :"') && !is(study, ++i, '"Affiliation:"'))
        temp['Medical_Specialty'] = cleanLine(study, i++);

        if (is(study, i, '"Affiliation:"') && !is(study, ++i, '"Postal address:"'))
        temp['Affiliation'] = cleanLine(study, i++);

        if (is(study, i, '"Postal address:"') && !is(study, ++i, '"City:"'))
        temp['PostalAddress'] = cleanLine(study, i++);

        if (is(study, i, '"City:"') && !is(study, ++i, '"Country:"'))
        temp['City'] = cleanLine(study, i++);

        if (is(study, i, '"Country:"') && !is(study, ++i, '"Zip Code:"'))
        temp['Country'] = cleanLine(study, i++);

        if (is(study, i, '"Zip Code:"') && !is(study, ++i, '"Telephone:"'))
        temp['Zipcode'] = cleanLine(study, i++);

        if (is(study, i, '"Telephone:"') && !is(study, ++i, '"Email Address:"'))
        temp['Telephone'] = cleanLine(study, i++);

        if (is(study, i, '"Email address:"')  && !is(study, ++i, '"Clinical sites to participate"')){
            while (!is(study, i, '"Clinical sites to participate"')) {
                tempEmail.push(cleanLine(study, i++));
            }
        }
    temp["EmailAddresses"] =  tempEmail;
    source.push(temp);
        }
    finalRecord['Principalinvestigator'] = source;
    i--;
    }

if (is(study, i++, "Clinical sites to participate")) {
source1 = [];
    while (!is(study, i++, '"Recruitment status"')) {
        temp = {};
         if (is(study, i, '"Countries of recruitment:"') && !is(study, ++i, '"Clinical sites:"'))
            temp['CountriesOfRecruitment'] = cleanLine(study, i++);

         if (is(study, i, '"Clinical sites:"') && !is(study, ++i, '"Research ethics committees:"'))
             temp['Clinical_Sites'] = cleanLine(study, i++);

         if (is(study, i, '"Research ethics committees:"') && !is(study, ++i, '"Recruitment status"'))
             temp['Researchethicscommittees'] = cleanLine(study, i++);

    source1.push(temp);
    }
    finalRecord['Clinicalsitestoparticipate'] = source1;
    i--
    }
if (is(study, i, '"Recruitment status"'))
    i = i+2

if (is(study, i, '"Recruitment status:"') && !is(study, ++i, '"Date of first enrollment:"'))
finalRecord['RecruitmentStatus'] = cleanLine(study, i++);

if (is(study, i, '"Date of first enrollment:"') && !is(study, ++i, '"Health condition and Intervention"'))
finalRecord['DateoffirstEnrollment'] = cleanLine(study, i++);


if (is(study, i++, "Health condition and Intervention")) {
    source1 = [];


    while (!is(study, i++, '"Outcomes and Timepoint"')) {
            temp = {}; tempInt = [];tempIntCode = [];tempIntKw=[];tempHealthCondCode=[];
        if (is(study, i, '"Health condition(s) or Problem(s) studied:"') && !is(study, ++i, '"Health condition(s) code:"'))
            temp['HealthCondition'] = cleanLine(study, i++);

        if (is(study, i, '"Health condition(s) code:"') && !is(study, ++i, '"Intervention(s):"')){
                      while (!is(study, i, '"Intervention(s):"')) {
                            tempHealthCondCode.push(cleanLine(study, i++));
                            if (is(study, i, "Outcomes and Timepoint")) break;
                        }
            temp['HealthConditionCode'] = tempHealthCondCode
        }
        if (is(study, i, 'Intervention(s):"')  && !is(study, ++i, '"Intervention code:"')){
            while (!is(study, i, '"Intervention code:"')) {
                tempInt.push(cleanLine(study, i++));
                if (is(study, i, "Outcomes and Timepoint")) break;
            }
        }
        temp["Interventions"] =  tempInt;

        if (is(study, i, 'Intervention code:"')  && !is(study, ++i, '"Intervention keyword:"')){
            while (!is(study, i, '"Intervention keyword:"')) {
            tempIntCode.push(cleanLine(study, i++));
           // if (is(study, i, "Outcomes and Timepoint")) break;
        }
        }
          temp["InterventionCode"] =  tempIntCode;

        if (is(study, i, 'Intervention keyword:"')  && !is(study, ++i, '"Outcomes and Timepoint"')){
        tempIntKw = [];
        while (!is(study, i, '"Outcomes and Timepoint"')) {
        tempIntKw.push(cleanLine(study, i++));
         }
      }
        temp["InterventionKeyWord"] =  tempIntKw;
        source1.push(temp);
    }
      finalRecord['HealthconditionIntervention'] = source1;

      i--
}

if (is(study, i++, "Outcomes and Timepoint")) {
    source1 = [];
    while (!is(study, i++, '"Selection criterias"')) {
           temp = {};tempPO = [];tempSO = [];
        if (is(study, i, 'Primary outcome(s):"')  && !is(study, ++i, '"Key secondary outcomes:"')){
        while (!is(study, i, '"Key secondary outcomes:"')) {
            tempPO.push(cleanLine(study, i++));
        }
        }
        temp["PrimaryOutcome"] =  tempPO;
        if (is(study, i, 'Key secondary outcomes:"')  && !is(study, ++i, '"Selection criterias"')){

        while (!is(study, i, '"Selection criterias"')) {
        tempSO.push(cleanLine(study, i++));
        }
        }
        temp["SEcondaryOutcome"] =  tempSO;
        source1.push(temp);
    }
    finalRecord['OutcomesAndTimepoints'] = source1;
    i--
}

if (is(study, i++, "Selection criterias")) {
    source1 = [];
    while (!is(study, i++, '"Study design"')) {
        temp = {};tempIn = [];tempEx = [];
        if (is(study, i, '"Gender:"') && !is(study, ++i, '"Minimum age:"'))
        temp['Gender'] = cleanLine(study, i++);

        if (is(study, i, '"Minimum age:"') && !is(study, ++i, '"Maximum age:"'))
        temp['MinimumAge'] = cleanLine(study, i++);

        if (is(study, i, '"Maximum age:"') && !is(study, ++i, '"Inclusion criteria:"'))
        temp['MaximumAge'] = cleanLine(study, i++);

        if (is(study, i, '"Inclusion criteria:"')  && !is(study, ++i, '"Exclusion criteria:"')){

        while (!is(study, i, '"Exclusion criteria:"')) {
        tempIn.push(cleanLine(study, i++));
        }
        }
        temp["InclusionCriteria"] =  tempIn;

        if (is(study, i, '"Exclusion criteria:"')  && !is(study, ++i, '"Type of population:"')){

        while (!is(study, i, '"Type of population:"')) {
        tempEx.push(cleanLine(study, i++));
        }
        }
        temp["ExclusionCriteria"] =  tempEx;

        if (is(study, i, '"Type of population:"') && !is(study, ++i, '"Type of participant:"'))
        temp['"TypeOfPopulation"'] = cleanLine(study, i++);
        source1.push(temp);

        if (is(study, i, '"Type of participant:"') && !is(study, ++i, '"Study design"'))
        temp['"Typeofparticipant:"'] = cleanLine(study, i++);
        source1.push(temp);
    }
    finalRecord['SelectionCriterias'] = source1;
}

i = i+1

if (is(study, i, '"Type study:"') && !is(study, ++i, '"Purpose:"'))
finalRecord['TypeStudy'] = cleanLine(study, i++);

if (is(study, i, '"Purpose:"') && !is(study, ++i, '"Other purpose:"'))
finalRecord['Purpose'] = cleanLine(study, i++);

if (is(study, i, '"Other purpose:"') && !is(study, ++i, '"Allocation:"'))
finalRecord['OtherPurpose'] = cleanLine(study, i++);

if (is(study, i, '"Allocation:"') && !is(study, ++i, '"Masking:"'))
finalRecord['Allocation'] = cleanLine(study, i++);

if (is(study, i, '"Masking:"') && !is(study, ++i, '"Control group:"'))
finalRecord['Masking'] = cleanLine(study, i++);

if (is(study, i, '"Control group:"') && !is(study, ++i, '"Study design:"'))
finalRecord['ControlGroup'] = cleanLine(study, i++);

if (is(study, i, '"Study design:"') && !is(study, ++i, '"Phase:"'))
finalRecord['StudyDesign'] = cleanLine(study, i++);

if (is(study, i, '"Phase:"') && !is(study, ++i, '"Target sample size:"'))
finalRecord['Phase'] = cleanLine(study, i++);

if (is(study, i, 'Target sample size:') && !is(study, ++i, '"Contact for public queries:"'))
finalRecord['TargetSampleSize'] = cleanLine(study, i++);


if (is(study, i, "Contact for public queries")) {
    source = [];
    temp = {};
    PubtempEmail = [];
    while (!is(study, i++, '"Contact for scientific queries"')) {
        if (is(study, i, '"First name:"') && !is(study, ++i, '"Last name:"'))
        temp['Pub_First_Name'] = cleanLine(study, i++);

        if (is(study, i, '"Last name:"') && !is(study, ++i, '"Specialty :"'))
        temp['Pub_Last_Name'] = cleanLine(study, i++);

        if (is(study, i, '"Medical Specialty :"') && !is(study, ++i, '"Affiliation:"'))
        temp['Pub_Medical_Specialty'] = cleanLine(study, i++);

        if (is(study, i, '"Affiliation:"') && !is(study, ++i, '"Postal address:"'))
        temp['Pub_Affiliation'] = cleanLine(study, i++);

        if (is(study, i, '"Postal address:"') && !is(study, ++i, '"City:"'))
        temp['Pub_PostalAddress'] = cleanLine(study, i++);

        if (is(study, i, '"City:"') && !is(study, ++i, '"Country:"'))
        temp['Pub_City'] = cleanLine(study, i++);

        if (is(study, i, '"Country:"') && !is(study, ++i, '"Zip Code:"'))
        temp['Pub_Country'] = cleanLine(study, i++);

        if (is(study, i, '"Zip Code:"') && !is(study, ++i, '"Telephone:"'))
        temp['Pub_Zipcode'] = cleanLine(study, i++);

        if (is(study, i, '"Telephone:"') && !is(study, ++i, '"Email Address:"'))
        temp['Pub_Telephone'] = cleanLine(study, i++);

        if (is(study, i, '"Email Address:"')  && !is(study, ++i, '"Contact for scientific queries"')){

        while (!is(study, i, '"Contact for scientific queries"')) {
        PubtempEmail.push(cleanLine(study, i++));
        }
        }
        temp["Pub_EmailAddresses"] =  PubtempEmail;
    }

        source.push(temp);
    finalRecord['ContactForPublicQUeries'] = source;
    i--;
}

if (is(study, i, "Contact for scientific queries")) {
    source = [];
    temp = {};
    ScitempEmail = [];
    while (!is(study, i++, '"Registration and Update"')) {
        if (is(study, i, '"First name:"') && !is(study, ++i, '"Last name:"'))
        temp['Sci_First_Name'] = cleanLine(study, i++);

        if (is(study, i, '"Last name:"') && !is(study, ++i, '"Specialty :"'))
        temp['Sci_Last_Name'] = cleanLine(study, i++);

        if (is(study, i, '"Medical Specialty :"') && !is(study, ++i, '"Affiliation:"'))
        temp['Sci_Medical_Specialty'] = cleanLine(study, i++);

        if (is(study, i, '"Affiliation:"') && !is(study, ++i, '"Postal address:"'))
        temp['Sci_Affiliation'] = cleanLine(study, i++);

        if (is(study, i, '"Postal address:"') && !is(study, ++i, '"City:"'))
        temp['Sci_PostalAddress'] = cleanLine(study, i++);

        if (is(study, i, '"City:"') && !is(study, ++i, '"Country:"'))
        temp['Sci_City'] = cleanLine(study, i++);

        if (is(study, i, '"Country:"') && !is(study, ++i, '"Zip Code:"'))
        temp['Sci_Country'] = cleanLine(study, i++);

        if (is(study, i, '"Zip Code:"') && !is(study, ++i, '"Telephone:"'))
        temp['Sci_Zipcode'] = cleanLine(study, i++);

        if (is(study, i, '"Telephone:"') && !is(study, ++i, '"Email Address:"'))
        temp['Sci_Telephone'] = cleanLine(study, i++);

        if (is(study, i, '"Email Address:"')  && !is(study, ++i, '"Registration and Update"')){
        while (!is(study, i, '"Registration and Update"')) {
        ScitempEmail.push(cleanLine(study, i++));
        }
        }
    temp["Sci_EmailAddresses"] =  ScitempEmail;
    }

    source.push(temp);
    finalRecord['ContactForScientificQueries'] = source;
}

i = i+1
if (is(study, i, '"Primary registry:"') && !is(study, ++i, '"Unique ID number:"'))
    finalRecord['PrimaryRegistry'] = cleanLine(study, i++);

if (is(study, i, '"Unique ID number:"') && !is(study, ++i, '"Date of Registration in Primary Registry:"'))
    finalRecord['UniqueIDNumber'] = cleanLine(study, i++);

if (is(study, i, '"Date of Registration in Primary Registry:"') && !is(study, ++i, '"Record Verification Date:"'))
    finalRecord['DateOfRegistrationinPrimaryRegisrty'] = cleanLine(study, i++);

if (is(study, i, '"Record Verification Date:"') && !is(study, ++i, '"Next update date:"'))
    finalRecord['RecordVerificationDate'] = cleanLine(study, i++);


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