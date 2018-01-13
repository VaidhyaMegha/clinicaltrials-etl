#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset, as zip files, as argument
# ./scripts/apis.sh datasets/datainsights-in/data.gov.in/


# Cleanup
source="data.gov.in"
s3_bucket_local="datasets/datainsights-results/"

output_folder=${s3_bucket_local}${source}"/api/download/"
log_folder=${s3_bucket_local}${source}"/api/log/"

rm -rf ${output_folder}
rm -rf ${log_folder}

mkdir -p ${output_folder}
mkdir -p ${log_folder}

api_key="579b464db66ec23bdd0000013909768f85ab43d265ee826acf566584"
prefix_url="https://api.data.gov.in/resource"
suffix_url="&api-key="${api_key}

input=$1
formats=( "json" "csv" "xml" )


## now loop through the above array
for i in ${!formats[*]}; do
    find ${input} | grep html | xargs -I {} cat {} | grep -oE "/[^/]*/api" | while read f
    do
        f=${f//\/api/}
        wget -q ${prefix_url}${f}"?format="${formats[${i}]}${suffix_url} \
             -O ${output_folder}/${f}.${formats[${i}]} -o ${log_folder}/${f}.${formats[${i}]}.log || true
    done
done

aws --profile=personal s3 sync ${s3_bucket_local} s3://datainsights-in/

### now loop through the above array
#for i in ${!formats[*]}; do
#    find ${input} | grep html | xargs -I {} cat {} | grep -oE "/[^/]*/api" \
#        | xargs -I {} wget ${prefix_url}{}"?format="${formats[${i}]}${suffix_url} >> {}.${formats[${i}]}
#done