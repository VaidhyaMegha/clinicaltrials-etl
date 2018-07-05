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
    let prevValue = '';
    for (let i = 0; i < study.length ; i++) {
        if(study[i].indexOf('：') !== -1 ) {
            key = study[i].replace('：','');
            if(prevValue.indexOf('：') !== -1 )
                resp[prevValue.replace('：','')] = ''
        } else {
            if(resp[key]){
                if(typeof(resp[key]) === 'string'){
                    let v = resp[key];
                    resp[key] = [];
                    resp[key].push(v);
                }

                resp[key].push(study[i].trim());
            } else {
                resp[key] = study[i].trim();
            }
        }

        prevValue = study[i];
    }

    process.stdout.write(JSON.stringify(resp) + '\n');
});