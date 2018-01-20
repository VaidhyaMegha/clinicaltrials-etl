#!/usr/bin/env bash

source $(pwd)/env.sh

cd ${DATA_HOME}

# HMIS Processing
${SCRIPTS_HOME}HMIS/convert2csv.sh  "datainsights-in/HMIS"
${SCRIPTS_HOME}HMIS/convert2json.sh  "datainsights-results/HMIS"

# data.gov.in
${SCRIPTS_HOME}data.gov.in/apis.sh "datainsights-in/data.gov.in/" "datainsights-results/data.gov.in/api/"
${SCRIPTS_HOME}data.gov.in/catalog.sh "datainsights-results/data.gov.in/api"

# ClinicalTrials

${SCRIPTS_HOME}clinicaltrials/aact/extract.sh  "datainsights-in/clinicaltrials/aact" "datainsights-results/clinicaltrials/aact"

# Mesh RDF
${SCRIPTS_HOME}Ontologies/mesh/rdf_extract.sh  "datainsights-in/Ontologies/mesh/rdf" "datainsights-results/Ontologies/mesh/rdf"

aws --profile=personal s3 sync ${s3_bucket_local} s3://datainsights-results/
