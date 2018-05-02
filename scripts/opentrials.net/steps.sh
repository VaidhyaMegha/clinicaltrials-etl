#!/usr/bin/env bash

rm -rf ~/datasets/datainsights-results/opentrials.net/*
mv /tmp/public.* ~/datasets/datainsights-results/opentrials.net/
cd ~/datasets/datainsights-results/opentrials.net/
find . -type f -name "*.csv" | xargs -I {} gzip {}
find . -type f -name "*.gz" | cut -d'/' -f2 | cut -d'.' -f2 | xargs -I {} mkdir {}
find . -type f -name "*.gz" | cut -d'/' -f2 | cut -d'.' -f2 | xargs -I {} mv ./public.{}.csv.gz {}/{}.csv.gz
