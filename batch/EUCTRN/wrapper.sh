#!/bin/bash
set -x

NOW=$(date +%y-%m-%d-%H:%M:%S)
LOGFILE='EUCTRN-LOG-'$NOW
context_dir=${4:-'/usr/local/dataintegration'}
s3_bucket_log=${8:-'s3://hsdlc-results/rapid-prototype/'}

pushd ${context_dir}

bash ./html_json.sh $1 $2 $3 $4 $5 $6 $7> $context_dir/$LOGFILE.log 2>&1

aws s3 cp $context_dir/$LOGFILE.log ${s3_bucket_log}
popd


