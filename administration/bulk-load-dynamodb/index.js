const fs = require('fs');
const parse = require('csv-parse/lib/sync');
const AWS = require('aws-sdk');

AWS.config.update({region: 'us-east-1'});
const docClient = new AWS.DynamoDB.DocumentClient();

const args = process.argv
    .slice(2)
    .map(arg => arg.split('='))
    .reduce((args, [value, key]) => {
        args[value] = key;
        return args;
    }, {});


const contents = fs.readFileSync(args.fileName, 'utf-8');
// If you made an export of a DynamoDB table you need to remove (S) etc from header
const data = parse(contents, {columns: true});

data.forEach((item) => {
    if(!item.maybeempty) delete item.maybeempty; //need to remove empty items
    Object.keys(item).forEach((key) => (item[key] == null || item[key] === '') && delete item[key]);
    // docClient.put({TableName: '<Table>', Item: item}, (err, res) => {
    docClient.put({TableName: args.tableName, Item: item}, (err, res) => {
        if(err) console.log(err)
    })
});
