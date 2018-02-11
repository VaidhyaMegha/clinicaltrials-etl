#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset as argument
# ./clinicaltrials.gov/aact/catalog.sh datainsights-results/clinicaltrials.gov/aact datainsights-results/clinicaltrials.gov/analysis


source $(pwd)/env.sh
source $(pwd)/utility.sh

OUT_DIR=${2:-'temp/clinicaltrials.gov'}

cleanup  ${DATA_HOME}/${OUT_DIR}

echo "S3FilePath|FileGUID|Source|Sector|Organization|ClinicalTrialID|TypeOfStudy|Sponsor|Title" \
    > ${DATA_HOME}/${OUT_DIR}/studies.csv

function catalog_study() {
    entry="datainsights-results/clinicaltrials.gov/analysis/studies.csv"
    index_name=`python -c "from sys import argv;print(hash(argv[1]))" ${entry}`

    entry="${entry}|${index_name}|clinicaltrials.gov|Health|aact"

    nct_id=`python -c "from sys import argv;print(argv[1].split('|')[0])" "${1}"`
    study_type=`python -c "from sys import argv;print(argv[1].split('|')[18])" "${1}"`
    brief_title=`python -c "from sys import argv;print(argv[1].split('|')[21])" "${1}"`
    source=`python -c "from sys import argv;print(argv[1].split('|')[28])" "${1}"`

    entry="${entry}|${nct_id}|${study_type}|${source}|${brief_title}"

    echo ${entry} >> ${2}
}

## now loop through the above array
zcat ${DATA_HOME}/${1}/studies.txt.gz | tail -n +2 | while read f
do
    catalog_study "${f}" "${DATA_HOME}/${OUT_DIR}/studies.csv"
done
