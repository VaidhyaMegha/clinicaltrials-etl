#!/usr/bin/env bash
set -ex

s3_bucket=${1:-'s3://hsdlc-results/discover/'}
context_dir=${2:-'/usr/local/dataintegration'}
mode=${3:-'cloud'}

pushd ${context_dir}

athena --db hsdlc --execute " select trialid as id1,  i.item as id2 from hsdlc.global_registries  cross join unnest(secondary_id) as i (item) where i.item != '' and (i.item like 'NCT%' or i.item like 'CTRI%' or i.item like 'IRCT%' or i.item like 'UMIN%' or i.item like 'NTR%' or i.item like 'ACTRN%' or i.item like 'ISRCTN%' or i.item like 'ChiCTR%' or i.item like 'SLCTR%' or i.item like 'RPCEC%' or i.item like 'TCTR%' or i.item like 'PER-%' or i.item like 'RBR-%' or i.item like '\d\d\d\d-\d\d\d\d\d\d-\d\d') and trialid != ''" \
        --output-format TSV --region 'us-east-1' > links.csv

sed -i 's/\t/|/g' links.csv

cat links.csv | java WQUPC > discover.json


if [[ ${mode} == 'cloud' ]]; then
    aws s3 cp  discover.json ${s3_bucket}discover.json
fi

popd
