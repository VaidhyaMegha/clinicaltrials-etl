cat htmls/ctr_view.cgi\?recptno\=R000033456  | pup 'table tr td[colspan="2"] b  font json{}' | jq '[.[].text]' > keys.json 
cat htmls/ctr_view.cgi\?recptno\=R000033456  | pup 'table tr td[width="20%"] b font  json{}' | jq '[.[].text]' > all_keys.json
cat htmls/ctr_view.cgi\?recptno\=R000033456  | pup 'table tr td[colspan="1"]  json{}' | jq '[.[].text]' > values.json
