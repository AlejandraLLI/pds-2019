drop table if exists cohorts.alive_artists;
create table if not exists cohorts.alive_artists as (
with as_of_dates as (
  select
    generate_series(min(date_acquired), max(date_acquired), '5 years') as as_of_date
    from
        semantic.events_artworks_in
),

  alive_artists as (
    select
      date_acquired,
      artist,
      name,
      gender,
      nationality,
      birth_year,
      artwork,
      wiki_qid,
      ulan,
      aod.as_of_date::date,
      daterange(
        (aod.as_of_date - interval '10 year')::date,
        aod.as_of_date::date)
        @> date_acquired as "entered"
      from  (
        select
          as_of_date
          from
              as_of_dates
      ) as aod
              left join lateral (
                select *, age(date_acquired,as_of_date)
                  from semantic.entities
              ) as t2 on true
  )

select *
from  alive_artists
where "entered" is true 
);
