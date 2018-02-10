#!/usr/bin/env bash

source $(pwd)/env.sh

cd ${DATA_HOME}

# nrhm-mis.nic.in Processing
${SCRIPTS_HOME}nrhm-mis.nic.in/convert2csv.sh  "datainsights-in/nrhm-mis.nic.in"
${SCRIPTS_HOME}nrhm-mis.nic.in/convert2json.sh  "datainsights-results/nrhm-mis.nic.in"
${SCRIPTS_HOME}nrhm-mis.nic.in/catalog.sh "datainsights-results/nrhm-mis.nic.in"


# data.gov.in
${SCRIPTS_HOME}data.gov.in/apis.sh "datainsights-in/data.gov.in/" "datainsights-results/data.gov.in/api/"
${SCRIPTS_HOME}data.gov.in/catalog.sh "datainsights-results/data.gov.in/api"

# ClinicalTrials

${SCRIPTS_HOME}clinicaltrials/aact/extract.sh  "datainsights-in/clinicaltrials/aact" "datainsights-results/clinicaltrials/aact"

# Mesh RDF
${SCRIPTS_HOME}Ontologies/mesh/rdf_extract.sh  "datainsights-in/Ontologies/mesh/rdf" "datainsights-results/Ontologies/mesh/rdf"

aws --profile=personal s3 sync ${s3_bucket_local} s3://datainsights-results/
