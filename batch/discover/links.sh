#!/usr/bin/env bash
set -ex


athena --db hsdlc --execute " select trialid as id1,  i.item as id2 from hsdlc.global_registries  cross join unnest(secondary_id) as i (item) where i.item != ''" \
        --output-format TSV > links.csv

sed -i 's/\t/|/g' links.csv

cat links.csv | java WQUPC > output.csv