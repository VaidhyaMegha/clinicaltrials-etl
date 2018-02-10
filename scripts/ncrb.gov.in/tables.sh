#!/usr/bin/env bash
set -ex

# To Execute this script provide folder containing dataset as argument
# ./ncrb.gov.in/tables.sh datainsights-in/crime/


source $(pwd)/env.sh
source $(pwd)/utility.sh

OUT_DIR=${1:-'temp/ncrb.gov.in'}

cleanup  ${DATA_HOME}/${OUT_DIR}


pushd ${DATA_HOME}/${OUT_DIR}

wget -r -l 3 http://ncrb.gov.in/StatPublications/CII/PrevPublications.htm || true
wget -r -l 1 http://ncrb.gov.in/StatPublications/CII/CII2016/Tables.html || true

popd