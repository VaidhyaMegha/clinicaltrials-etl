cat htmls/18305.html | pup 'div.ProjetInfo_ms tr json{}' |  grep 'text' | grep -P '^[[:ascii:]]+：?"?$' | ./html_json.js  | jq 
cat htmls/18305.html | pup 'tr.en json{}' | ./html_json