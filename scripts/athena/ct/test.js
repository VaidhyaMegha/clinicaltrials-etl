#!/usr/bin/env node
var fs = require('fs');
var util = require('util');
var xml4js = require('xml4js');

// Most of xml2js options should still work
var options = {
    'explicitRoot':false,
    'stripPrefix':true

};
var parser = new xml4js.Parser(options);


var data = fs.readFileSync("NCT03481725.xml", {'encoding' : 'UTF-8'});
 data = data.toString().replace("\ufeff", "");

// Default is to not download schemas automatically, so we should add it manually
fs.readFile('public.xsd', {'encoding' : 'UTF-8'}, function (err, schema) {
    schema = schema.toString().replace("\ufeff", "");


    parser.addSchema('http://www.example.com/Schema', schema, function (err, importsAndIncludes) {
        if (err) console.log(err);
        // importsAndIncludes contains schemas to be added as well to satisfy all imports and includes found in schema.xsd

        parser.parseString(data, function (err, result) {

            console.log(data);
            console.log(util.inspect(result, false, null));
        });
    });


});