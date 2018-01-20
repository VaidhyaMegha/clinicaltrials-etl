#!/usr/bin/env bash

# HMIS Processing
./HMIS/convert2csv.sh  datasets/datainsights-in/HMIS
./HMIS/convert2json.sh  temp/HMIS

# data.gov.in
./data.gov.in/apis.sh datasets/datainsights-in/data.gov.in/
./data.gov.in/catalog.sh datasets/datainsights-results/data.gov.in/api/download

# ClinicalTrials
./clinicaltrials/aact/extract.sh  "../datasets/datainsights-in/clinicaltrials/aact" "../datasets/datainsights-results/clinicaltrials/aact"

# Mesh RDF
./Ontologies/mesh/rdf_extract.sh  "../datasets/datainsights-in/Ontologies/mesh/rdf" "../datasets/datainsights-results/Ontologies/mesh/rdf"

aws --profile=personal s3 sync ${s3_bucket_local} s3://datainsights-results/
