
copy ( select 
         regexp_replace(cast(id as text), E'[\n\r\t ]+', ' ', 'g' ) as id,
         regexp_replace(cast(identifiers as text), E'[\n\r\t ]+', ' ', 'g' ) as identifiers,
         regexp_replace(cast(registration_date as text), E'[\n\r\t ]+', ' ', 'g' ) as registration_date,
         regexp_replace(cast(public_title as text), E'[\n\r\t ]+', ' ', 'g' ) as public_title,
         regexp_replace(cast(brief_summary as text), E'[\n\r\t ]+', ' ', 'g' ) as brief_summary,
         regexp_replace(cast(scientific_title as text), E'[\n\r\t ]+', ' ', 'g' ) as scientific_title,
         regexp_replace(cast(description as text), E'[\n\r\t ]+', ' ', 'g' ) as description,
         regexp_replace(cast(recruitment_status as text), E'[\n\r\t ]+', ' ', 'g' ) as recruitment_status,
         regexp_replace(cast(eligibility_criteria as text), E'[\n\r\t ]+', ' ', 'g' ) as eligibility_criteria,
         regexp_replace(cast(target_sample_size as text), E'[\n\r\t ]+', ' ', 'g' ) as target_sample_size,
         regexp_replace(cast(first_enrollment_date as text), E'[\n\r\t ]+', ' ', 'g' ) as first_enrollment_date,
         regexp_replace(cast(study_type as text), E'[\n\r\t ]+', ' ', 'g' ) as study_type,
         regexp_replace(cast(study_design as text), E'[\n\r\t ]+', ' ', 'g' ) as study_design,
         regexp_replace(cast(study_phase as text), E'[\n\r\t ]+', ' ', 'g' ) as study_phase,
         regexp_replace(cast(primary_outcomes as text), E'[\n\r\t ]+', ' ', 'g' ) as primary_outcomes,
         regexp_replace(cast(secondary_outcomes as text), E'[\n\r\t ]+', ' ', 'g' ) as secondary_outcomes,
         regexp_replace(cast(created_at as text), E'[\n\r\t ]+', ' ', 'g' ) as created_at,
         regexp_replace(cast(updated_at as text), E'[\n\r\t ]+', ' ', 'g' ) as updated_at,
         regexp_replace(cast(has_published_results as text), E'[\n\r\t ]+', ' ', 'g' ) as has_published_results,
         regexp_replace(cast(gender as text), E'[\n\r\t ]+', ' ', 'g' ) as gender,
         regexp_replace(cast(source_id as text), E'[\n\r\t ]+', ' ', 'g' ) as source_id,
         regexp_replace(cast(status as text), E'[\n\r\t ]+', ' ', 'g' ) as status,
         regexp_replace(cast(completion_date as text), E'[\n\r\t ]+', ' ', 'g' ) as completion_date,
         regexp_replace(cast(results_exemption_date as text), E'[\n\r\t ]+', ' ', 'g' ) as results_exemption_date,
         regexp_replace(cast(age_range as text), E'[\n\r\t ]+', ' ', 'g' ) as age_range
       from ot.trials)
to '/tmp/trials2.csv' WITH (FORMAT CSV, HEADER, ESCAPE E'\\', DELIMITER E'\t', FORCE_QUOTE *, QUOTE E'\"');


athena:opentrials> select count(1) as cnt, map_keys(cast(json_parse(ltrim(rtrim(replace(identifiers, '\', ''),'"'), '"' ) )
                                                         as map(varchar, varchar)))
                   from trials
                   group by map_keys(cast(json_parse(ltrim(rtrim(replace(identifiers, '\', ''),'"'), '"' ))
                                          as map(varchar, varchar)))
                   order by cnt desc ;
cnt | _col1
--------+---------------------------
231303 | [nct]
26858 | [euctr]
23472 | [jprn]
14570 | [isrctn]
12025 | [actrn]
10874 | [irct]
8547 | [chictr]
5797 | [pubmed]
5619 | [ntr]
4594 | [drks]
2808 | [euctr, nct]
2154 | [gsk, nct]
2117 | [gsk]
1446 | [kct]
1400 | [per]
987 | [rbr]
772 | [pactr]
762 | [isrctn, nct]
613 | [tctr]
342 | [euctr, isrctn]
258 | [euctr, who]
211 | [rpcec]
155 | [euctr, isrctn, nct]
140 | [euctr, nct, who]
107 | [jprn, nct]
100 | [euctr, gsk, nct]
56 | [actrn, nct]
8 | [euctr, isrctn, who]
7 | [drks, nct]
6 | [euctr, ntr]
6 | [euctr, isrctn, nct, who]
4 | [euctr, gsk]
4 | [kct, nct]
2 | [chictr, nct]
2 | [drks, euctr]
2 | [actrn, isrctn, nct]
1 | [actrn, euctr, nct]
1 | [euctr, isrctn, ntr]
1 | [euctr, jprn, nct, who]
1 | [nct, ntr]
1 | [actrn, euctr]
1 | [isrctn, ntr]
1 | [euctr, jprn, nct]
1 | [gsk, isrctn, nct]
1 | [euctr, gsk, isrctn, nct]
1 | [drks, euctr, nct]
1 | [nct, pactr]
1 | [euctr, jprn]
(48 rows)

athena:opentrials> select count(1) as cnt, map_keys(cast(json_parse(replace(replace(replace(identifiers, '\', ''), '"{', '{'), '}"', '}'))
                                                         as map(varchar, varchar)))
                   from trials
                   group by map_keys(cast(json_parse(replace(replace(replace(identifiers, '\', ''), '"{', '{'), '}"', '}'))
                                          as map(varchar, varchar)))
                   order by cnt desc ;
cnt | _col1
--------+---------------------------
231303 | [nct]
26858 | [euctr]
23472 | [jprn]
14570 | [isrctn]
12025 | [actrn]
10874 | [irct]
8547 | [chictr]
5797 | [pubmed]
5619 | [ntr]
4594 | [drks]
2808 | [euctr, nct]
2154 | [gsk, nct]
2117 | [gsk]
1446 | [kct]
1400 | [per]
987 | [rbr]
772 | [pactr]
762 | [isrctn, nct]
613 | [tctr]
342 | [euctr, isrctn]
258 | [euctr, who]
211 | [rpcec]
155 | [euctr, isrctn, nct]
140 | [euctr, nct, who]
107 | [jprn, nct]
100 | [euctr, gsk, nct]
56 | [actrn, nct]
8 | [euctr, isrctn, who]
7 | [drks, nct]
6 | [euctr, ntr]
6 | [euctr, isrctn, nct, who]
4 | [kct, nct]
4 | [euctr, gsk]
2 | [chictr, nct]
2 | [actrn, isrctn, nct]
2 | [drks, euctr]
1 | [actrn, euctr]
1 | [euctr, gsk, isrctn, nct]
1 | [gsk, isrctn, nct]
1 | [nct, pactr]
1 | [nct, ntr]
1 | [isrctn, ntr]
1 | [euctr, jprn, nct, who]
1 | [actrn, euctr, nct]
1 | [drks, euctr, nct]
1 | [euctr, isrctn, ntr]
1 | [euctr, jprn, nct]
1 | [euctr, jprn]
(48 rows)


-- prototyping

-- https://stackoverflow.com/questions/17463299/export-database-into-csv-file

CREATE OR REPLACE FUNCTION db_to_csv(path TEXT) RETURNS void AS $$
declare
  tables RECORD;
  statement TEXT;
begin
  FOR tables IN
  SELECT (table_schema || '.' || table_name) AS schema_table
  FROM information_schema.tables t INNER JOIN information_schema.schemata s
      ON s.schema_name = t.table_schema
  WHERE t.table_schema NOT IN ('pg_catalog', 'information_schema')
        AND t.table_type NOT IN ('VIEW')
  ORDER BY schema_table
  LOOP
    statement := 'COPY ' || tables.schema_table || ' TO ''' || path || '/' ||
                 tables.schema_table || '.csv' ||''' DELIMITER E''\t'' CSV HEADER';
    EXECUTE statement;
  END LOOP;
  return;
end;
$$ LANGUAGE plpgsql;

copy trials to '/tmp/trials2.csv' WITH (FORMAT CSV, HEADER, ESCAPE E'\\', DELIMITER E'\t', FORCE_QUOTE *, QUOTE E'\"');


select identifiers from opentrials.trials limit 30;
SELECT cast (identifiers.isrctn as varchar) as isrctn  FROM "opentrials"."trials" limit 10;


  select key, count(1) from (select map_keys(cast(json_parse(replace(identifiers, E'\\','')) as map(string, string) ) as keys from "opentrials". "trials" ) p
                            cross JOIN UNNEST (keys) AS t (key)
                           GROUP BY key;


select  (cast(json_parse(identifiers) as map(varchar, varchar) )["isrctn"] as value from "opentrials". "trials" limit 10

select source_id, count(1) as cnt from "opentrials". "trials" group by source_id order by cnt desc limit 100;