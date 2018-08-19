cat ~/Downloads/2006.xml | node html_json.js  | jq -c '.trials.trial[]' > 2006.json
