#!/usr/bin/env bash
set -ex

rm -f normalized_links.csv

#athena --db hsdlc --execute " select trialid as id1,  i.item as id2 from hsdlc.global_registries  cross join unnest(secondary_id) as i (item) where i.item != ''" \
#        --output-format CSV > links.csv

declare ids=( $( grep -oE '"[^"]*"' links.csv | sort -u) )
declare -A idsMap=( )


for ind in "${!ids[@]}"; do
 idsMap[${ids[${ind}]}]=${ind}
done

echo ${idsMap}

cat links.csv | while read f
do
   idpair=( $( echo ${f} | grep -oE '"[^"]*"'))
   echo "${idsMap[${idpair[0]}]},${idsMap[${idpair[1]}]}" >> normalized_links.csv
done