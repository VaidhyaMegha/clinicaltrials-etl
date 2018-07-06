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
    // steps outside:
    //  1. cat html pup to pick content div esp. the necessary set of elements like tr and generate json
    //  2. grep the required keys and values resulting in consecutive key-then-value pairs-of-lines
    // steps inside:
    //  1. Initialize result object as {}
    //  2.loop through all lines
    //    if current line is a key then
    //      check previous line
    //      if previous line is also key then
    //          if indentation is same then previous key has no value
    //          else if indentation has increased then
    //              create a new {} and link to it the result object against the previous key
    //    else if current line is a value
    //       if current object {} has the current key
    //          if the value is array add current value to the array
    //          else add current value against the current key into current object
    //
    let result = {};
    let keys = [];
    let lines = [];
    let obj = result;
    let objs = [obj];
    
    for (let i = 0; i < study.length ; i++) {
        let curLine = study[i];
        let prevLine = lines.length > 0 ? lines[lines.length - 1] : '';

        let lsCurLineLength = curLine.match(/^[\s]*/g)[0].length;
        let lsPrevLineLength = prevLine.match(/^[\s]*/g)[0].length;

        if (lsPrevLineLength === 0 || lsCurLineLength === lsPrevLineLength){ //starting key or same level
            if(isKey(prevLine)) obj[cleanKeyLine(prevLine)] = '';
        } else if(lsPrevLineLength < (lsCurLineLength - 3)){
            let prevObj = obj;

            obj = {};

            prevObj[cleanKeyLine(prevLine)] = obj;

            objs.push(obj);
        } else if (lsPrevLineLength > (lsCurLineLength + 3)){
            objs.pop();
            obj = objs[objs.length - 1];
        }

        lines.push(curLine);

        if(isKey(curLine)) {
           keys.push(curLine);
        } else {
            let key = cleanKeyLine(keys.pop());
            let value = cleanValueLine(curLine);

            // console.log(objs);

            if(obj[key]){
                if(Array.isArray(obj[key])){
                    obj[key].push(value);
                } else { // string or map
                    let v = obj[key];
                    obj[key] = [];
                    obj[key].push(v);

                    obj[key].push(value);
                }
            } else {
                obj[key] = value;
            }
        }
    }

    process.stdout.write(JSON.stringify(result) + '\n');
});

function isKey(str){
    return str.indexOf('：') !== -1
}

function cleanKeyLine(line){
    let key = line.replace(/\(/g, '');

    key = key.replace(/\)/g, '');
    key = key.replace(/'/g, '');
    key = key.replace(/：/g, '');
    key = key.replace(/^ */g, '');
    key = key.replace(/ +/g, '_');
    key = key.replace(/\\n/g, '');

    return key.replace(/\\u0026#39;/g, '');
}

function cleanValueLine(line){
   return line.trim();
}