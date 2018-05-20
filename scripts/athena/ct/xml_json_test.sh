 #!/usr/bin/env bash

rm ${1}/processed.log

find ${1} -type f -name "*.json" | while read f
do
    echo ${f} >> ${1}/processed.log
    jq ".id_info.nct_id" ${f}  >> ${1}/processed.log 2>&1
done

# find /home/sandeep/temp/AllPublicXMLs/ | grep "json$" | tee /dev/tty |  xargs -I {} cat {} | jq ".id_info.nct_id" > ~/temp/processed.log