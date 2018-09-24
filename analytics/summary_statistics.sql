-- count by registry
select registry, count(1) as count
from global_registries
group by registry
order by count desc;

-- count of trials by year
select count(1) as count, substr(date_of_registration, length(date_of_registration) - 4)
from global_registries
where date_of_registration != ''
group by substr(date_of_registration, length(date_of_registration) - 4)
order by count desc;

-- count by registry by year
select registry, substr(date_of_registration, length(date_of_registration) - 4) as reg_year, count(1) as count
from global_registries
where date_of_registration != ''
group by registry , substr(date_of_registration, length(date_of_registration) - 4);

-- count of trials by study type
select study_type, count(1) as count
from global_registries
where study_type != ''
group by study_type
order by count desc;
-- Notes
--- split study_type by space and cross join with the resulting array then group by word to find counts

-- count of trials by country per year

select count(1), split_part(dateofregistration, ' ', 3),latitude, longitude, country
  from slctr_studies,
  (select * from countries where country = 'SL')
  group by split_part(dateofregistration, ' ', 3),latitude, longitude, country
  order by split_part(dateofregistration, ' ' , 3) desc;

select count(1), split_part(dateofregistrationinprimaryregisrty, '-', 1),latitude, longitude, country
  from cubct_studies,
  (select * from countries where name = 'Cuba')
  group by regexp_extract(dateofregistrationinprimaryregisrty, '\d\d\d\d'),latitude, longitude, country
  order by split_part(dateofregistrationinprimaryregisrty, '-', 1) desc;

-- count of trials by registry per year along with latitude, longitude
select *, latitude, longitude from (
select count(1), registry, regexp_extract(date_of_registration, '\d\d\d\d')
from global_registries
group by registry, regexp_extract(date_of_registration, '\d\d\d\d')
order by regexp_extract(date_of_registration, '\d\d\d\d')
) p, registry_country rc where p.registry = rc.registry;


athena --db hsdlc --execute " select p.*, latitude, longitude from ( select count(1) as count, registry, regexp_extract(date_of_registration, '\d\d\d\d') from global_registries group by registry, regexp_extract(date_of_registration, '\d\d\d\d') order by regexp_extract(date_of_registration, '\d\d\d\d') ) p, registry_country rc where p.registry = rc.registry;" \
        --output-format TSV --region 'us-east-1' > registry_counts_by_year.tsv