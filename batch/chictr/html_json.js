#!/usr/bin/env node

var study = '';

var args = process.argv.slice(2)
var arg = args[0]

if (arg === '--version') {
        console.log(pkg.version)
        process.exit(0)
}

process.stdin.on('data', function (data) {
        study += data;
});

process.stdin.resume();

process.stdin.on('end', function () {
    var json = JSON.parse(study);
    var resp = {};

    for (var i = 0; i < json.length ; i++) {
            if(json[i].class && json[i].class === 'en') {
                if (json[i].children && json[i].children.length > 1 && json[i].children[1].children){
                    resp[json[i].children[0].children[0].text] = json[i].children[1].children[0].text;
                }
            } else if (!json[i].class) {
                if (json[i].children && json[i].children.length > 1 && json[i].children[0].children[1]){
                   resp[json[i].children[0].children[1].text] = json[i].children[1].text
                }

                if (json[i].children && json[i].children.length > 2 && json[i].children[2].children[1]){
                    resp[json[i].children[2].children[1].text] = json[i].children[3].text
                }
            }
    }
        process.stdout.write(JSON.stringify(resp) + '\n')
});