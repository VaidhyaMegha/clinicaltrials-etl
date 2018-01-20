#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset, as zip files, as argument
# ./Ontologies/mesh/rdf_extract.sh  "../datasets/datainsights-in/Ontologies/mesh/rdf" "../temp/Ontologies/mesh/rdf"


source $(pwd)/utility.sh

OUT_DIR=${2:-'temp/Ontologies/mesh/rdf'}

cleanup  ${OUT_DIR}
prepare ${1} "mesh.nt.gz" ${OUT_DIR}