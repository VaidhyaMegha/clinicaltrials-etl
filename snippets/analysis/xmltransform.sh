#!/usr/bin/env bash
xmlstarlet tr xml_to_csv2.xslt $1 > $1.csv
