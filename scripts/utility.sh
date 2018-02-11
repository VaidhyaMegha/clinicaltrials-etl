#!/usr/bin/env bash

function prepare() {

    # Find and unzip zip files into temp directory
    find ${1} -iname ${2} | while read f
    do
         if [[ ${f} == *"zip"* ]]; then
            unzip ${f} -d ${3}/
         elif [[ ${f} == *"gz"* ]]; then
            g=${2//\.gz/}
            gunzip -c ${f} > ${3}/${g}
         fi
    done

}

function cleanup() {
    rm -rf ${1}
    mkdir -p ${1}
}
