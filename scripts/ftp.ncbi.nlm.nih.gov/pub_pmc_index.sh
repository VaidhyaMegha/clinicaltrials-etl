#!/usr/bin/env bash

out_file=${1:-../temp/temp.txt}

lftp -c "open ftp.ncbi.nlm.nih.gov/; find pub/pmc/" >> ${out_file}