#!/usr/bin/env node

let readline = require('readline');
let rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let study = [];


rl.on('line', function(line){
    study.push(line);
});

rl.on('close', function () {
    let finalRecord = {};
    let sites = [];
    let primaryOutcomes = [];
    let temp = null;
    let curObject = null;
    let curKey = null;

    for (let i = 0; i < study.length ; i++) {
        if(study[i].indexOf("Recruitment Status by Participating Study Site") !== -1) {
            curObject = "Site";
            if(temp != null) sites.push(temp);
            temp = {};
            curKey = null;
        } else if(study[i].indexOf("Primary Outcome(s)") !== -1) {
            curObject = "Primary Outcome";
            if(temp != null) primaryOutcomes.push(temp);
            temp = {};
            curKey = null;
        } else if(study[i].indexOf('"Study Site"') !== -1) {
            curKey = "study_site";
        } else if(study[i].indexOf('"Overall Recruitment Status"') !== -1) {
            curKey = "overall_recruitment_status";
        } else if(study[i].indexOf('"Date of First Enrollment"') !== -1) {
            curKey = "date_of_first_enrollment";
        } else if(study[i].indexOf('"Target Number of Participant"') !== -1) {
            curKey = "target_number_of_participant";
        } else if(study[i].indexOf('"Primary Completion Date"') !== -1) {
            curKey = "primary_completion_date";
        } else if(study[i].indexOf('"Study Completion Date"') !== -1) {
            curKey = "study_completion_date";
        } else if (curObject === "Site" && study[i].indexOf("Name of Study Site") !== -1){
            curKey = "name_of_study_site";
        } else if (curObject === "Site" && study[i].indexOf("Recruitment Status") !== -1){
            curKey = "recruitment_status";
        } else if (curObject === "Site" && study[i].indexOf("Date of First Enrollment") !== -1){
            curKey = "date_of_first_enrollment";
        } else if (curObject === "Site" && curKey !== null && study[i].indexOf("text") !== -1){
            temp[curKey] = cleanLine(study[i]);
            curKey = null; // reset the curKey
        } else if (curObject === "Primary Outcome" && study[i].indexOf("Outcome") !== -1){
            curKey = "outcome";
        } else if (curObject === "Primary Outcome" && study[i].indexOf("Timepoint") !== -1){
            curKey = "timepoint";
        } else if (curObject === "Primary Outcome" && curKey !== null && study[i].indexOf("text") !== -1){
            temp[curKey] = cleanLine(study[i]);
            curKey = null; // reset the curKey
        } else { // catchall
            if ( curKey !== null && study[i].indexOf("text") !== -1){
                finalRecord[curKey] = cleanLine(study[i]);
                curKey = null;
            }
        }

    }


    finalRecord['sites'] = sites;
    finalRecord['primary_outcomes'] = primaryOutcomes;

    process.stdout.write(JSON.stringify(finalRecord) + '\n');
});

function cleanLine(l){
    let line = l;
    line = line.replace(/"/g, '');
    line = line.replace(/text: /g, '');

    return line;
}