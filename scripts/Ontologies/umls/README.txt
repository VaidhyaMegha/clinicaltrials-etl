README

These scripts allow you to download files that require UMLS Terminology Services (UTS) authentication by executing a single command. When combined with a scheduling tool, they allow you to automate the download of files.

These scripts download files into your current working directory. If you want the file saved in a different directory, make sure you change your current working directory before running the scripts.

----------------------------------------

For Windows users:

1) curl may not be installed by default. Download and install curl. Contact your system administrator for assistance, if necessary.

2) Unzip terminology_download_script.zip to some location. (For example, c:\terminology_download_script)

3) Open curl-uts-download.bat in a text editor and enter your UTS username and password and the path to curl: (Do not include spaces or quotation marks.)
           SET UTS_USERNAME=
           SET UTS_PASSWORD=
           SET CURL_HOME= (path where curl is installed in Step 1)

4) Using the command line, navigate to the terminology_download_script directory:
        > cd c:\terminology_download_script\

5)  Run curl-uts-download.bat with the appropriate download file URL: (Replace the RxNorm URL example with URL of the file you wish to download.)
        > curl-uts-download.bat https://download.nlm.nih.gov/umls/kss/rxnorm/RxNorm_full_current.zip
        
*To schedule a download, you may run the above command using the Windows task scheduler or another scheduling tool. 

----------------------------------------

Linux/Mac users:

1) For Linux, curl is installed by default. 

2) For Mac, this script requires curl with openssl. See the following commands for updating curl with openssl using homebrew (valid as of 11/24/2017):
		> /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		> brew install --with-openssl curl
		> brew link curl –force

3) Unzip terminology_download_script.zip to some location. (For example, /tmp)

4) Open curl-uts-download.sh in a text editor and enter your UTS username and password: (Do not include spaces.)
           export UTS_USERNAME=
           export UTS_PASSWORD=

5) Using the command line, navigate to the download-with-curl directory:
        > cd /tmp/terminology_download_script

6) Make sure the curl-uts-download.sh file is executable by modifying its permissions:
		> chmod 755 curl-uts-download.sh

7) Run curl-uts-download.sh with the appropriate download file URL: (Replace the RxNorm URL example with URL of the file you wish to download.)
		> sh curl-uts-download.sh https://download.nlm.nih.gov/umls/kss/rxnorm/RxNorm_full_current.zip
        
*To schedule a download, you may run the above command using crontab or another scheduling tool.

----------------------------------------

URLs for frequently downloaded files:

UMLS (Run curl-uts-download.sh for each file) -
https://download.nlm.nih.gov/umls/kss/2017AB/umls-2017AB-full.zip

U.S. Edition of SNOMED CT -
https://download.nlm.nih.gov/mlb/utsauth/USExt/SnomedCT_USEditionRF2_PRODUCTION_20170901T120000Z.zip

RxNorm Full Monthly Release -
https://download.nlm.nih.gov/umls/kss/rxnorm/RxNorm_full_mmddyyyy.zip
OR
https://download.nlm.nih.gov/umls/kss/rxnorm/RxNorm_full_current.zip

RxNorm Weekly Update - 
https://download.nlm.nih.gov/umls/kss/rxnorm/RxNorm_weekly_mmddyyyy.zip
OR
https://download.nlm.nih.gov/umls/kss/rxnorm/RxNorm_weekly_current.zip



For the full list of download file URLs, visit the downloads page:
https://nih.nih.gov/research/umls/licensedcontent/downloads.html


Last Updated: 11/27/2017
