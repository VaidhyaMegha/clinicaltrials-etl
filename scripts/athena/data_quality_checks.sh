#!/usr/bin/env bash
set -ex

cat data_quality_checks.sql | while read query
do
   athena --db hsdlc --execute  "${query}"\
        --output-format TSV --region 'us-east-1'
done