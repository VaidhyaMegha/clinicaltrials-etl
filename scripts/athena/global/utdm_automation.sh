#!/bin/bash
s3path="s3://datainsights-results/temp/utdm/"
s3fileextention=".csv"
while IFS='' read -r line || [[ -n "$line" ]]; do
  aws athena start-query-execution \
    --query-string "$line" \
    --query-execution-context Database=global \
    --result-configuration OutputLocation=s3://datainsights-results/temp/utdm/ \
    --output text > temp.txt
done < "$1"
sleep 65
while IFS='' read -r line || [[ -n "$line" ]]; do
queryresultid="$line"
done < temp.txt
queryresultfile="$queryresultid$s3fileextention"
s3fullpath="$s3path$queryresultfile"
echo $s3fullpath
count=$(aws s3 ls $s3fullpath | wc -l)
echo $count
if [ $count -gt 0 ]
then
   $(aws s3 cp $s3fullpath $(pwd))
fi

$(sed -i 's/"",""/""|""/g' $(pwd)/$queryresultfile)
$(sed -i 's/","/"|"/g' $(pwd)/$queryresultfile)
$(sed -i 's/,,/||/g' $(pwd)/$queryresultfile)
$(sed -i 's/""|""/"",""/g' $(pwd)/$queryresultfile)

$(aws s3 cp $(pwd)/$queryresultfile s3://datainsights-results/temp/global/athena/ctd_utdm/temp.csv)
