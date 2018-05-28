---compressed JSON table
athena:global> select count(1) from ct_studies_new;
   _col0
---------
  368884
(1 rows)

Query 1c39cd38-be95-45ca-8110-b0bf15b33631, SUCCEEDED
https://us-east-1.console.aws.amazon.com/athena/home?force&region=us-east-1#query/history/1c39cd38-be95-45ca-8110-b0bf15b33631
Time: 0:08:21, CPU Time: 501490ms total, Data Scanned: 3.12GB, Cost: $0.02


---uncompressed JSON table
athena:global> SELECT count(distinct id_info.nct_id) FROM "global"."ct_studies_new" ;
   _col0
---------
  274049
(1 rows)

Query 42a09aeb-8b41-4278-bed2-800212414a93, SUCCEEDED
https://us-east-1.console.aws.amazon.com/athena/home?force&region=us-east-1#query/history/42a09aeb-8b41-4278-bed2-800212414a93
Time: 0:06:13, CPU Time: 373063ms total, Data Scanned: 10.66GB, Cost: $0.06

athena:global> SELECT count(distinct id_info.nct_id) FROM "global"."ct_studies_new" ;
   _col0
---------
  274049
(1 rows)

Query c843a2ff-6c11-49f6-9d7b-662b34af5f0d, SUCCEEDED
https://us-east-1.console.aws.amazon.com/athena/home?force&region=us-east-1#query/history/c843a2ff-6c11-49f6-9d7b-662b34af5f0d
Time: 0:06:12, CPU Time: 371987ms total, Data Scanned: 10.66GB, Cost: $0.06
