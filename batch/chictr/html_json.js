#!/usr/bin/env node

let readline = require('readline');
let rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let study = [];


rl.on('line', function(line){
    let v = line.replace(/"/g, '');
    v = v.replace(/text: /g, '');

    study.push(v);
});

rl.on('close', function () {
    let resp = {};
    let key = '';
    for (let i = 0; i < study.length ; i++) {
        if(study[i].indexOf('：') !== -1 ) key = study[i];
        else resp[key.replace('：','')] = study[i].trim();
    }

    process.stdout.write(JSON.stringify(resp) + '\n');
});