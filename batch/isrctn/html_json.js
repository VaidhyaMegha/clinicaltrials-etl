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
        if (is(study, i, '"Condition category"') && !is(study, ++i, '"Date applied"'))
        finalRecord['conditionCategory'] = cleanLine(study, i++);

        if (is(study, i, '"Date applied"') && !is(study, ++i, '"Date assigned"'))
        finalRecord['dateApplied'] = cleanLine(study, i++);

        if (is(study, i, '"Date assigned"') && !is(study, ++i, '"Last edited"'))
        finalRecord['dateAssigned'] = cleanLine(study, i++);

        if (is(study, i, '"Last edited"') && !is(study, ++i, '"Prospective/Retrospective"'))
        finalRecord['LastEdited'] = cleanLine(study, i++);


        if (is(study, i, '"Prospective/Retrospective"') && !is(study, ++i, '"Overall trial status"'))
        finalRecord['Prospective_Retrospective'] = cleanLine(study, i++);

        if (is(study, i, '"Overall trial status"') && !is(study, ++i, '"Recruitment status"'))
        finalRecord['OverAllTrialStatus'] = cleanLine(study, i++);

        if (is(study, i++, '"Recruitment status"'))
            finalRecord['RecruitmentStatus'] = cleanLine(study, i++);
        i =0;
        if (is(study, i, '"Plain English Summary"') && !is(study, ++i, '"Trial website"'))
            finalRecord['PlainEnglishWebsite'] = cleanLine(study, i++);

        if (is(study, i, '"Trial website"') && !is(study, ++i, '"Type"'))
            finalRecord['TrialWebsite'] = cleanLine(study, i++);

        if (is(study, i, '"Type"') && !is(study, ++i, '"Primary contact"'))
            finalRecord['Type'] = cleanLine(study, i++);

        if (is(study, i, '"Primary contact"') && !is(study, ++i, '"Contact details"'))
            finalRecord['PrimaryContact'] = cleanLine(study, i++);

        if (is(study, i, '"ORCID ID"') && !is(study, ++i, '"Contact details"'))
            finalRecord['ORCID_ID'] = cleanLine(study, i++);


        if (is(study, i, "Contact details")) {
        source = [];
        while (!is(study, ++i, '"EudraCT number"')) {
            source.push(cleanLine(study, i));
            }
        finalRecord['ContactDetails'] = source;
        }

        if (is(study, i, "EudraCT number")) {
        source = [];temp = {};tempEU = [];tempCTgov=[];tempPSnum=[];
        while (!is(study, ++i, '"ClinicalTrials.gov number"')) {
            tempEU.push(cleanLine(study, i));
            }
        temp['EudraCTnumber'] = tempEU;
        while (!is(study, ++i, '"Protocol/serial number"')) {
            tempCTgov.push(cleanLine(study, i));
            }
        temp['CTgovNumber'] = tempCTgov;
        while (!is(study, ++i, '"Scientific title"')) {
            tempCTgov.push(cleanLine(study, i));
            }
        temp['Protocol_serial_number'] = tempPSnum;
        source.push(temp);
        finalRecord['SecondaryIds'] = source;
        }

        if (is(study, i, '"Scientific title"') && !is(study, ++i, '"Acronym"'))
            finalRecord['ScientificTitle'] = cleanLine(study, i++);

        if (is(study, i, '"Acronym"') && !is(study, ++i, '"Study hypothesis"'))
            finalRecord['Acronym'] = cleanLine(study, i++);

        if (is(study, i, '"Study hypothesis"') && !is(study, ++i, '"Ethics approval"'))
            finalRecord['StudyHypothesis'] = cleanLine(study, i++);

        if (is(study, i, '"Ethics approval"') && !is(study, ++i, '"Study design"'))
            finalRecord['EthicsApproval'] = cleanLine(study, i++);

        if (is(study, i, '"Study design"') && !is(study, ++i, '"Primary study design"'))
           finalRecord['StudyDesign'] = cleanLine(study, i++);

         if (is(study, i, '"Primary study design"') && !is(study, ++i, '"Secondary study design"'))
                    finalRecord['PrimaryStudyDesign'] = cleanLine(study, i++);

        if (is(study, i, '"Secondary study design"') && !is(study, ++i, '"Trial setting"'))
                   finalRecord['SecondaryStudyDesign'] = cleanLine(study, i++);

        if (is(study, i, '"Trial setting"') && !is(study, ++i, '"Trial type"'))
             finalRecord['TrialSetting'] = cleanLine(study, i++);

        if (is(study, i, '"Trial type"') && !is(study, ++i, '"Patient information sheet"'))
             finalRecord['TrialType'] = cleanLine(study, i++);

        if (is(study, i, '"Patient information sheet"'))
            while (!is(study, ++i, '"Condition"')) {
              finalRecord['PatientInformationSheet'] = cleanLine(study, i++);
              if (is(study, i, '"Condition"')) break;
              }

        if (is(study, i, '"Condition"') && !is(study, ++i, '"Intervention"'))
             finalRecord['Intervention'] = cleanLine(study, i++);

        if (is(study, i, "Intervention")) {
                source = [];
        while (!is(study, ++i, '"Intervention type"')) {
            source.push(cleanLine(study, i));
            }
        finalRecord['Intervention'] = source;
        }

        if (is(study, i, '"Intervention type"') && !is(study, ++i, '"Phase"'))
                     finalRecord['InterventionType'] = cleanLine(study, i++);

         if (is(study, i, '"Phase"') && !is(study, ++i, '"Drug names"'))
                             finalRecord['Phase'] = cleanLine(study, i++);

          if (is(study, i, '"Drug names"') && !is(study, ++i, '"Primary outcome measure"'))
                                      finalRecord['Phase'] = cleanLine(study, i++);

        if (is(study, i, "Primary outcome measure")) {
        source = [];
        while (!is(study, ++i, '"Secondary outcome measures"')) {
        source.push(cleanLine(study, i));
        }
        finalRecord['PrimaryOutcomeMeasure'] = source;
        }


        if (is(study, i, "Secondary outcome measures")) {
              source = [];
        while (!is(study, ++i, '"Overall trial start date"')) {
          source.push(cleanLine(study, i));
          }
        finalRecord['SecondaryOutcomeMeasure'] = source;
        }

        if (is(study, i, '"Overall trial start date"') && !is(study, ++i, '"Overall trial end date"'))
              finalRecord['OverallTrialstartDate'] = cleanLine(study, i++);

        if (is(study, i, '"Overall trial end date"') && !is(study, ++i, '"Reason abandoned (if study stopped)"'))
              finalRecord['OverallTrialEndDate'] = cleanLine(study, i++);

        if (is(study, i, '"Reason abandoned (if study stopped)"') && !is(study, ++i, '"Participant inclusion criteria"'))
              finalRecord['ReasonAbandoned '] = cleanLine(study, i++);

        if (is(study, i, '"Participant inclusion criteria"') && !is(study, ++i, '"Participant type"'))
              finalRecord['ParticipantInclusionCriteria '] = cleanLine(study, i++);

        if (is(study, i, '"Participant type"') && !is(study, ++i, '"Age group"'))
              finalRecord['ParticipantType '] = cleanLine(study, i++);

        if (is(study, i, '"Age group"') && !is(study, ++i, '"Gender"'))
              finalRecord['AgeGroup '] = cleanLine(study, i++);

        if (is(study, i, '"Gender"') && !is(study, ++i, '"Target number of participants"'))
              finalRecord['Gender '] = cleanLine(study, i++);

        if (is(study, i, '"Target number of participants"') && !is(study, ++i, '"Participant exclusion criteria"'))
              finalRecord['TargetNumberOfParticipants '] = cleanLine(study, i++);

        if (is(study, i, "Participant exclusion criteria")) {
              source = [];
        while (!is(study, ++i, '"Recruitment start date"')) {
          source.push(cleanLine(study, i));
          }
        finalRecord['ParticipantExclusionCriteria'] = source;
        }

        if (is(study, i, '"Recruitment start date"') && !is(study, ++i, '"Recruitment end date"'))
              finalRecord['RecruitmentStartDate '] = cleanLine(study, i++);

        if (is(study, i, '"Recruitment end date"') && !is(study, ++i, '"Countries of recruitment"'))
              finalRecord['RecruitmentEndDate '] = cleanLine(study, i++);

        if (is(study, i, "Countries of recruitment")) {
              source = [];
        while (!is(study, ++i, '"Trial participating centre"')) {
          source.push(cleanLine(study, i));
          }
        finalRecord['CountriesOfRecruitment'] = source;
        }

        if (is(study, i, "Trial participating centre")) {
              source = [];
        while (!is(study, ++i, '"Organisation"')) {
          source.push(cleanLine(study, i));
          }
        finalRecord['TrialParcipatingCentre'] = source;
        }

        if (is(study, i, '"Organisation"') && !is(study, ++i, '"Sponsor details"'))
              finalRecord['Organisation '] = cleanLine(study, i++);

        if (is(study, i, "Sponsor details")) {
              source = [];
        while (!is(study, ++i, '"Sponsor type"')) {
          source.push(cleanLine(study, i));
          }
        finalRecord['SponsorDetails'] = source;
        }

        if (is(study, i, '"Sponsor type"') && !is(study, ++i, '"Website"'))
              finalRecord['SponsorType '] = cleanLine(study, i++);

        if (is(study, i, '"Website"') && !is(study, ++i, '"Funder type"'))
              finalRecord['Website'] = cleanLine(study, i++);

        if (is(study, i, '"Funder type"') && !is(study, ++i, '"Funder name"'))
              finalRecord['FunderType '] = cleanLine(study, i++);

        if (is(study, i, '"Funder name"') && !is(study, ++i, '"Alternative name(s)"'))
              finalRecord['FunderName'] = cleanLine(study, i++);


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