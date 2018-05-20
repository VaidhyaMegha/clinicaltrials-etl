A --> (CTRI n CT n OT)
B --> CTRI -  (Ctri n CT)
C --> CT - (Ctri n CT)
    including D or 2 --> (Ctri n CT) - (CTRI n CT n OT)
E --> (Ct n OT) - (CTRI n CT n OT)


athena --execute "select * from global.global_registries limit 4" --output-format TSV_HEADER --schema global > ~/temp/output.tsv


select  count(1) from ctri_studies ctris  full outer join ct_studies cts   on  substr(secondary_ids, strpos(secondary_ids, 'NCT'), 11) = cts.nct_id where ctri_number != '' or nct_id != ''


select count(*) from trials , ct_studies cts   where   substr(identifiers, strpos(identifiers, 'NCT'), 11) = cts.nct_id


 select count(1) from (select  * from ctri_studies ctris  full outer join ct_studies cts   on  substr(secondary_ids, strpos(secondary_ids, 'NCT'), 11) = cts.nct_id where ctri_number != '' or nct_id != '') b  full outer join  trials on  substr(identifiers, strpos(identifiers, 'NCT'), 11) = b.nct_id


athena:global> select md5(to_utf8('Amazon'));
 _col0
-------------------------------------------------
 b3 b3 a6 ac 74 ec bd 56 bc db ef a4 79 9f b9 df
(1 rows)

Query 2e78eb55-44f8-4ba4-8021-0ca882656e9c, SUCCEEDED
https://us-east-1.console.aws.amazon.com/athena/home?force&region=us-east-1#query/history/2e78eb55-44f8-4ba4-8021-0ca882656e9c
Time: 0:00:00, CPU Time: 90ms total, Data Scanned: 0.00B, Cost: $0.00

athena:global> select to_base64url(md5(to_utf8('Amazon'))) || '-' || to_base64url(md5(to_utf8('Prime')));
 _col0
---------------------------------------------------
 s7OmrHTsvVa82--keZ-53w==-vnk46ah2GKmKe2tH4SqkSw==
(1 rows)

Query cade9205-f5a5-4536-a10d-c8f1428f35e3, SUCCEEDED
https://us-east-1.console.aws.amazon.com/athena/home?force&region=us-east-1#query/history/cade9205-f5a5-4536-a10d-c8f1428f35e3
Time: 0:00:00, CPU Time: 71ms total, Data Scanned: 0.00B, Cost: $0.00




athena:global> select count(1) from ctri_studies where ctri_number != '';
   _col0
---------
   13222
(1 rows)

Query 00ae955c-52ec-449b-bce8-0a6037bc5a28, SUCCEEDED
https://us-east-1.console.aws.amazon.com/athena/home?force&region=us-east-1#query/history/00ae955c-52ec-449b-bce8-0a6037bc5a28
Time: 0:00:01, CPU Time: 1220ms total, Data Scanned: 24.24MB, Cost: $0.00

athena:global> select count(1) from ct_studies;
   _col0
---------
  269684
(1 rows)

Query d1ba6b42-ac8c-4e1e-b659-2e1086aa9520, SUCCEEDED
https://us-east-1.console.aws.amazon.com/athena/home?force&region=us-east-1#query/history/d1ba6b42-ac8c-4e1e-b659-2e1086aa9520
Time: 0:00:01, CPU Time: 964ms total, Data Scanned: 179.09MB, Cost: $0.00

athena:global> select count(1) from trials;
   _col0
---------
  358140
(1 rows)

Query d8974a84-2cdf-4d8e-a696-fbfb2d06b118, SUCCEEDED
https://us-east-1.console.aws.amazon.com/athena/home?force&region=us-east-1#query/history/d8974a84-2cdf-4d8e-a696-fbfb2d06b118
Time: 0:00:12, CPU Time: 11918ms total, Data Scanned: 380.87MB, Cost: $0.00

athena:global>  select count(1) from (select  * from ctri_studies ctris  full outer join ct_studies cts   on  substr(secondary_ids, strpos(secondary_ids, 'NCT'), 11) = cts.nct_id where ctri_number != '' or nct_id != '') b  full outer join  trials on  substr(identifiers, strpos(identifiers, 'NCT'), 11) = b.nct_id;
   _col0
---------
  403139
(1 rows)

Query 9c273713-80ef-4a67-a6d3-86b740d2067f, SUCCEEDED
https://us-east-1.console.aws.amazon.com/athena/home?force&region=us-east-1#query/history/9c273713-80ef-4a67-a6d3-86b740d2067f
Time: 0:00:14, CPU Time: 14456ms total, Data Scanned: 584.20MB, Cost: $0.00

athena:global> select count(*) from trials , ct_studies cts   where   substr(identifiers, strpos(identifiers, 'NCT'), 11) = cts.nct_id
   _col0
---------
  237287
(1 rows)

Query a7223e55-a44a-46e9-a3a1-11e58e4d1a1f, SUCCEEDED
https://us-east-1.console.aws.amazon.com/athena/home?force&region=us-east-1#query/history/a7223e55-a44a-46e9-a3a1-11e58e4d1a1f
Time: 0:00:14, CPU Time: 14792ms total, Data Scanned: 559.96MB, Cost: $0.00

athena:global> select  count(1) from ctri_studies ctris  join ct_studies cts   on  substr(secondary_ids, strpos(secondary_ids, 'NCT'), 11) = cts.nct_id where ctri_number != '' or nct_id != ''
   _col0
---------
     938
(1 rows)

Query 82842a01-f915-4390-945f-0df77ed8d837, SUCCEEDED
https://us-east-1.console.aws.amazon.com/athena/home?force&region=us-east-1#query/history/82842a01-f915-4390-945f-0df77ed8d837
Time: 0:00:01, CPU Time: 1775ms total, Data Scanned: 203.33MB, Cost: $0.00



--- approx.---

--- 358140 + 13222 + (269684 - 237287) - (938) --> 402829
--- 358140 + 13222 + (269684 - 237287) - (approx. 938) --> 403139