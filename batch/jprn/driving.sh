#!/bin/bash
set -x

NOW=$(date +%y-%m-%d-%H:%M:%S)
LOGFILE='LOG-'$NOW
context_dir=${3:-'/usr/local/dataintegration'}
s3_bucket_log=${4:-'s3://hsdlc-results/rapid-prototype/'}

bash ./html_json.sh 'htmls' 'yes' > $context_dir/$LOGFILE.log 2>&1

aws s3 cp $context_dir/$LOGFILE.log ${s3_bucket_log}



