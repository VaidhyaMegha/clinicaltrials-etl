#!/usr/bin/env node

let readline = require('readline');
var parser = require('xml2json');

let rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let study = '';


rl.on('line', function(line){
    study = study + line;
});

rl.on('close', function () {
    var options = {
        object: false,
        reversible: false,
        coerce: false,
        sanitize: false,
        trim: true,
        arrayNotation: ['contacts','countries','health_condition_code','health_condition_keyword','intervention_keyword','primary_outcome','secondary_outcome', 'primary_sponsor','secondary_sponsor', 'secondary_ids','source_support','trial'],
        alternateTextNode: false
    };

// xml to json
    var json = parser.toJson(study, options);
    console.log(json);

});