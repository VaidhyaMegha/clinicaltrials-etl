#!/bin/bash
export AWS_DEFAULT_REGION=us-east-1
s3path="s3://hsdlc-results/temp/utdm/"
s3fileextention=".csv"
while IFS='' read -r line || [[ -n "$line" ]]; do
  aws athena start-query-execution \
    --query-string "$line" \
    --query-execution-context Database=global \
    --result-configuration OutputLocation=s3://datainsights-results/temp/utdm/ \
    --output text > temp.txt
done < "$1"

while IFS='' read -r line || [[ -n "$line" ]]; do
queryresultid="$line"
done < temp.txt

queryresultfile="$queryresultid$s3fileextention"
s3fullpath="$s3path$queryresultfile"

sleep 700

aws s3 cp $s3fullpath $(pwd)

sed -i 's/"",""/""|""/g' $(pwd)/$queryresultfile
sed -i 's/","/"|"/g' $(pwd)/$queryresultfile
sed -i 's/,,/||/g' $(pwd)/$queryresultfile
sed -i 's/""|""/"",""/g' $(pwd)/$queryresultfile

aws s3 cp $(pwd)/$queryresultfile s3://hsdlc-results/hsdlc/utdm.csv
