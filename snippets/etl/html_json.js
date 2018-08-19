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
        sanitize: true,
        trim: true,
        arrayNotation: ['secondary_outcome', 'primary_outcome'],
        alternateTextNode: false
    };

// xml to json
    var json = parser.toJson(study, options);
    console.log(json);

});