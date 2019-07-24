#!/usr/bin/env bash

# Log in to the server.  This only needs to be done once.
wget --save-cookies cookies.txt \
     --keep-session-cookies \
     --post-data 'user=foo&password=bar' \
     --delete-after \
     https://auth.mygov.in/user/login?destination=oauth2/authorize

# Now grab the page or pages we care about.
wget --load-cookies cookies.txt \
     http://server.com/interesting/article.php

# find /home/sandeep/temp/AllPublicXMLs/ | grep "json$" | tee /dev/tty |  xargs -I {} cat {} | jq ".id_info.nct_id" > ~/temp/processed.log
    
