#!/usr/bin/env node

var page = require('webpage').create();
console.log('The default user agent is ' + page.settings.userAgent);
// page.settings.userAgent = 'SpecialAgent';
// page.open('http://www.httpuseragent.org', function (status) {
//     if (status !== 'success') {
//         console.log('Unable to access network');
//     } else {
//         var ua = page.evaluate(function () {
//             return document.getElementById('qua').textContent;
//         });
//         console.log(ua);
//     }
//     phantom.exit();
// });


page.settings.userAgent = 'SpecialAgent';
page.open('https://pactr.samrc.ac.za/Search.aspx', function (status) {
    if (status !== 'success') {
        console.log('Unable to access network');
    } else {
        console.log("came here");

        document.getElementById("MainContent_lnkSearchType").click();

        console.log("came here");
        document.getElementById("txtRegistrationFromValue").value = '01 Jan 2010';
        document.getElementById("txtRegistrationToValue").value = '18 Aug 2018';

        document.getElementById("MainContent_ctrlSearch_btnSearch").click();

        document.getElementById("btnDownloadTrials").click();

    }
});

