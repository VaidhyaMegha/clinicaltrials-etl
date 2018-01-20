#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset, as zip files, as argument
# ./Ontologies/mesh/rdf_extract.sh  "../datasets/datainsights-in/Ontologies/mesh/rdf" "../temp/Ontologies/mesh/rdf"


source $(pwd)/env.sh
source $(pwd)/utility.sh

OUT_DIR=${2:-'temp/Ontologies/mesh/rdf'}

cleanup  ${OUT_DIR}
prepare ${1} "mesh.nt.gz" ${OUT_DIR}

grep -nri "<http://id.nlm.nih.gov/mesh/vocab#" ${OUT_DIR}/mesh.nt  |  grep -oE "vocab#[^>]*" | sort -u >${OUT_DIR}/vocab.csv