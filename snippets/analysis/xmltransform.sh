#!/usr/bin/env bash

xslt_file=${2:-xml_to_csv2.xslt}
xmlstarlet tr ${xslt_file} $1 > $1.csv
