#!/usr/bin/env bash

find . -type f -name *.dcm | xargs -I {} ~/tools/dcm4che-2.0.29/bin/dcm2xml {} -o {}.xml
find . -type f -name *.xml | xargs -I {} xml2json --strip_text {} -o {}.json
