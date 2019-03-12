#!/bin/bash
set -ex

NOW=$(date +%y-%m-%d-%H:%M:%S)
LOGFILE='DRKS-LOG-'$NOW
context_dir=${5:-'/usr/local/dataintegration'}
s3_bucket_log=${7:-'s3://hsdlc-results/rapid-prototype/'}

pushd ${context_dir}

bash ./html_json.sh $1 $2 > $context_dir/$LOGFILE.log 2>&1

aws s3 cp $context_dir/$LOGFILE.log ${s3_bucket_log}
popd


