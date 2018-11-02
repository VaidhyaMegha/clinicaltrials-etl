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
while (!is(study, i, '"DRKS-ID:"')) {
              i++;
       }
// check for the current line and move to next line. Check if next line is a 'key' if not it must be a value.
if (is(study, i, '"DRKS-ID:"') && !is(study, ++i, '"Trial Description"'))
finalRecord['DRKS_ID'] = cleanLine(study, i++);

if (is(study, i, '"Trial Description"'))
i++;

if (is(study, i, '"Title"') && !is(study, ++i, '"Trial Acronym"'))
finalRecord['Title'] = cleanLine(study, i++);

if (is(study, i, '"Trial Acronym"') && !is(study, ++i, '"URL of the Trial"'))
finalRecord['TrialAcronym'] = cleanLine(study, i++);


if (is(study, i, '"URL of the Trial"') && !is(study, ++i, '"Brief Summary in Lay Language"'))
finalRecord['URLOfTrial'] = cleanLine(study, i++);

if (is(study, i, '"Brief Summary in Lay Language"') && !is(study, ++i, '"Brief Summary in Scientific Language"'))
finalRecord['BriefSummaryInLayLanguage'] = cleanLine(study, i++);

if (is(study, i, '"Brief Summary in Scientific Language"') && !is(study, ++i, '"MFDS Regulated Study"'))
finalRecord['BriefSummaryInScientificLanguage'] = cleanLine(study, i++);

if (is(study, i, '"Organizational Data"'))
i++;

if (is(study, i, '"DRKS-ID:"') && !is(study, ++i, '"Date of Registration in DRKS:"'))
finalRecord['ORG_DRKS_ID'] = cleanLine(study, i++);

if (is(study, i, '"Date of Registration in DRKS:"') && !is(study, ++i, '"Date of Registration in Partner Registry or other Primary Registry:"'))
finalRecord['DateOfRegistration'] = cleanLine(study, i++);

if (is(study, i, '"Date of Registration in Partner Registry or other Primary Registry:"') && !is(study, ++i, '"Investigator Sponsored/Initiated Trial (IST/IIT):"'))
finalRecord['DateOfRegistrationInPartnerOrPrimaryRegistry'] = cleanLine(study, i++);

if (is(study, i, '"Investigator Sponsored/Initiated Trial (IST/IIT):"') && !is(study, ++i, '"Ethics Approval/Approval of the Ethics Committee:"'))
finalRecord['InvestigatorSponsored_InitiatedTrial'] = cleanLine(study, i++);

if (is(study, i, '"Ethics Approval/Approval of the Ethics Committee:"') && !is(study, ++i, '"(leading) Ethics Committee No.:"'))
finalRecord['EthicsApproval_ApprovalOfTheEthicsCommittee:'] = cleanLine(study, i++);

if (is(study, i, '"(leading) Ethics Committee No.:"') && !is(study, ++i, '"Secondary IDs"'))
finalRecord['EthicsCommitteeNo'] = cleanLine(study, i++);

if (is(study, i++, "Secondary IDs")) {
SecondaryIds = [];
temp={};
while (!is(study, i, '"Health Condition or Problem studied"')) {
        if (cleanLine(study, i) == '"[---]*"')   break;
        temp[cleanLine(study, i)] = cleanLine(study, ++i);
             if (is(study, i, '"Health Condition or Problem studied"'))  {
             break;
             }  else {i++;}
      }
    finalRecord['SecondaryIds'] = temp;
}
if (is(study, i++, "Health Condition or Problem studied")) {
HealthConditionProblemStudied = [];temp={};
if (cleanLine(study, i) == "[---]*" )
       {
        finalRecord['HealthConditionProblemStudied'] = temp;
        i++;
       }
else
{
while (!is(study, i, '"Interventions/Observational Groups"')) {
       temp[cleanLine(study, i)] = cleanLine(study, ++i);
              i++;
       }
    finalRecord['HealthConditionProblemStudied'] = temp;
}
}
if (is(study, i++, "Interventions/Observational Groups")) {
Interventions_Observational = [];temp={};
if (cleanLine(study, i) == "[---]*" )
       {
        finalRecord['Interventions_Observational'] = temp;
        i++;
       }
else
{
while (!is(study, i, '"Characteristics"')) {
        temp[cleanLine(study, i)] = cleanLine(study, ++i);
             if (is(study, i, '"Characteristics"'))  {
             break;
             }  else {i++;}
         }
    finalRecord['Interventions_Observational'] = temp;
}
}
if (is(study, i++, "Characteristics")) {
Interventions_Observational = [];temp={};
while (!is(study, i, '"Primary Outcome"')) {
        temp[cleanLine(study, i)] = cleanLine(study, ++i);
                     i++;
         }
    finalRecord['Characteristics'] = temp;
}

if (is(study, i++, "Primary Outcome")) {
PrimaryOutcome = [];
while (!is(study, i, '"Secondary Outcome"')) {
        PrimaryOutcome.push(cleanLine(study, i++));
}
    finalRecord['PrimaryOutcome'] = PrimaryOutcome;
}

if (is(study, i++, "Secondary Outcome")) {
SecondaryOutcome = [];
while (!is(study, i, '"Countries of Recruitment"')) {
        SecondaryOutcome.push(cleanLine(study, i++));
}
    finalRecord['SecondaryOutcome'] = SecondaryOutcome;
}

if (is(study, i++, "Countries of Recruitment")) {
CountriesOfRecruitment = [];temp={};
if (cleanLine(study, i) == "[---]*" )
       {
        finalRecord['Interventions_Observational'] = temp;
        i++;
       }
else
{
while (!is(study, i, '"Locations of Recruitment"')) {
        temp[cleanLine(study, i)] = cleanLine(study, ++i);
                     i++;
         }
    finalRecord['CountriesOfRecruitment'] = temp;
}
}

if (is(study, i++, "Locations of Recruitment")) {
LocationsOfRecruitment = [];
while (!is(study, i, '"Recruitment"')) {
        LocationsOfRecruitment.push(cleanLine(study, i++));
         }
    finalRecord['LocationsOfRecruitment'] = LocationsOfRecruitment;
}


if (is(study, i++, "Recruitment")) {
Interventions_Observational = [];temp={};
while (!is(study, i, '"Inclusion Criteria"')) {
        temp[cleanLine(study, i)] = cleanLine(study, ++i);
                     i++;
         }
    finalRecord['Recruitment'] = temp;
}

if (is(study, i++, "Inclusion Criteria")) {
InclusionCritteria = [];temp={};
while (!is(study, i, '"Additional Inclusion Criteria"')) {
        temp[cleanLine(study, i)] = cleanLine(study, ++i);
                     i++;
         }
    finalRecord['InclusionCriteria'] = temp;
}


if (is(study, i++, "Additional Inclusion Criteria")) {
AdditionalInclusionCriteria = [];
while (!is(study, i, '"Exclusion Criteria"')) {
        AdditionalInclusionCriteria.push(cleanLine(study, i++));
         }
    finalRecord['AdditionalInclusionCriteria'] = AdditionalInclusionCriteria;
}


if (is(study, i++, "Exclusion Criteria")) {
ExclusionCriteria = [];
while (!is(study, i, '"Addresses"')) {
        ExclusionCriteria.push(cleanLine(study, i++));
         }
    finalRecord['ExclusionCriteria'] = ExclusionCriteria;
}

if (is(study, i++, "Addresses")) {
PrimarySponsorAdd = [];temp ={};ScientficQueryAddressAdd=[];PublicQueryAddressAdd=[];CollaboratorAddressAdd=[];
while (is(study, i, '"Primary Sponsor"')){
 tempsc ={};tempsec=[];
while (!is(study, i, '"Telephone:"')) {
         tempsec.push(cleanLine(study, ++i));
         }
        tempsc["Address"] = tempsec;
        if (is(study, i, '"Telephone:"') && !is(study, ++i, 'Fax:"'))
                tempsc['Telephone'] = cleanLine(study, i++);
        if (is(study, i, '"Fax:"') && !is(study, ++i, 'E-mail:"'))
                        tempsc['Fax'] = cleanLine(study, i++);
        if (is(study, i, '"E-mail:"') && !is(study, ++i, 'URL:"'))
                        tempsc['Email'] = cleanLine(study, i++);
        if (is(study, i, '"URL:"') && !is(study, ++i, 'Contact for Scientific Queries"'))
                        tempsc['Url'] = cleanLine(study, i++);
        PrimarySponsorAdd.push(tempsc);
}
     finalRecord['PrimarySponsorAdd'] = PrimarySponsorAdd;


while (is(study, i, '"Collaborator, Other Address"')){
 tempcoll ={};tempcolla=[];
while (!is(study, i, '"Telephone:"')) {
         tempcolla.push(cleanLine(study, ++i));
         }
        tempcoll["Address"] = tempcolla;
        if (is(study, i, '"Telephone:"') && !is(study, ++i, 'Fax:"'))
                tempcoll['Telephone'] = cleanLine(study, i++);
        if (is(study, i, '"Fax:"') && !is(study, ++i, 'E-mail:"'))
                        tempcoll['Fax'] = cleanLine(study, i++);
        if (is(study, i, '"E-mail:"') && !is(study, ++i, 'URL:"'))
                        tempcoll['Email'] = cleanLine(study, i++);
        if (is(study, i, '"URL:"') && !is(study, ++i, 'Contact for Public Queries"'))
                        tempcoll['Url'] = cleanLine(study, i++);
        CollaboratorAddressAdd.push(tempcoll);
}
finalRecord['CollaboratorAddressAdd'] = CollaboratorAddressAdd;

while (is(study, i, '"Contact for Scientific Queries"')){
 tempsc ={};tempsec=[];
while (!is(study, i, '"Telephone:"')) {
         tempsec.push(cleanLine(study, ++i));
         }
        tempsc["Address"] = tempsec;
        if (is(study, i, '"Telephone:"') && !is(study, ++i, 'Fax:"'))
                tempsc['Telephone'] = cleanLine(study, i++);
        if (is(study, i, '"Fax:"') && !is(study, ++i, 'E-mail:"'))
                        tempsc['Fax'] = cleanLine(study, i++);
        if (is(study, i, '"E-mail:"') && !is(study, ++i, 'URL:"'))
                        tempsc['Email'] = cleanLine(study, i++);
        if (is(study, i, '"URL:"') && !is(study, ++i, 'Contact for Public Queries"'))
                        tempsc['Url'] = cleanLine(study, i++);
        ScientficQueryAddressAdd.push(tempsc);
}
finalRecord['ScientficQueryAddressAdd'] = ScientficQueryAddressAdd;


while (is(study, i, '"Contact for Public Queries"')){
 temppb ={};temppub=[];
while (!is(study, i, '"Telephone:"')) {
         temppub.push(cleanLine(study, ++i));
         }
        temppb["Address"] = temppub;
        if (is(study, i, '"Telephone:"') && !is(study, ++i, 'Fax:"'))
                temppb['Telephone'] = cleanLine(study, i++);
        if (is(study, i, '"Fax:"') && !is(study, ++i, 'E-mail:"'))
                temppb['Fax'] = cleanLine(study, i++);
        if (is(study, i, '"E-mail:"') && !is(study, ++i, 'URL:"'))
                temppb['Email'] = cleanLine(study, i++);
        if (is(study, i, '"URL:"') && !is(study, ++i, 'Contact for Public Queries"'))
                temppb['Url'] = cleanLine(study, i++);
        PublicQueryAddressAdd.push(temppb);
}
     finalRecord['PublicQueryAddressAdd'] = PublicQueryAddressAdd;
}

if (is(study, i++, "Sources of Monetary or Material Support")) {
SourceOfMonetaryMaterialSupp = [];temp ={};ScientficQueryAddressAdd=[];PublicQueryAddressAdd=[];

while (!is(study, i, '"Status"')){
 if ((is(study, i, '"[---]*"')) && (cleanLine(study, ++i) === 'Status') ) break;
 tempsc ={};tempsec=[];
while (!is(study, i, '"Telephone:"')) {
         tempsec.push(cleanLine(study, i++));
         }
        tempsc["Address"] = tempsec;
        if (is(study, i, '"Telephone:"') && !is(study, ++i, 'Fax:"'))
                tempsc['Telephone'] = cleanLine(study, i++);
        if (is(study, i, '"Fax:"') && !is(study, ++i, 'E-mail:"'))
                        tempsc['Fax'] = cleanLine(study, i++);
        if (is(study, i, '"E-mail:"') && !is(study, ++i, 'URL:"'))
                        tempsc['Email'] = cleanLine(study, i++);
        if (is(study, i, '"URL:"') && !is(study, ++i, '"Status"'))
                        tempsc['Url'] = cleanLine(study, i++);

        SourceOfMonetaryMaterialSupp.push(tempsc);

}
     finalRecord['SourceOfMonetaryMaterialSupp'] = SourceOfMonetaryMaterialSupp;

}

if (is(study, i++, "Status"))
{
temp={};
if (is(study, i, '"Recruitment Status:"') && !is(study, ++i, 'Study Closing (LPLV):"'))
          finalRecord['RecruitmentStatus'] = cleanLine(study, i++);
if (is(study, i, '"Study Closing (LPLV):"'))
         finalRecord['StudyClosing'] = cleanLine(study, i++);
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