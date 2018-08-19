#!/usr/bin/env bash
set -ex

s3_bucket=${1:-'s3://hsdlc-results/discover/'}
context_dir=${2:-'/usr/local/dataintegration'}
mode=${3:-'cloud'}

pushd ${context_dir}

athena --db hsdlc --execute " select trialid as id1,  i.item as id2 from hsdlc.global_registries  cross join unnest(secondary_id) as i (item) where i.item != ''" \
        --output-format TSV > links.csv

sed -i 's/\t/|/g' links.csv

cat links.csv | java WQUPC > discover.json


if [[ ${mode} == 'cloud' ]]; then
    aws s3 sync  discover.json ${s3_bucket} --delete
fi

popd