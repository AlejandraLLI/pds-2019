drop table if exists features.aggregated;

create table if not exists features.aggregated as (

select * from
(
  select
    as_of_date,
    artist
    from
        labels.entered_artworks_1y
) as aod
             left join lateral ( -- for loop
               select
                 count(distinct artwork) filter(where daterange((aod.as_of_date - interval '1 year')::date, aod.as_of_date::date) @> date_acquired) as "total_artworks_1y",
                 count(distinct artwork) filter(where daterange((aod.as_of_date - interval '2 years')::date, aod.as_of_date::date) @> date_acquired) as "total_artworks_2y",
                 count(distinct artwork) filter(where daterange((aod.as_of_date - interval '3 years')::date, aod.as_of_date::date) @> date_acquired) as "total_artworks_3y",
                 count(distinct artwork) filter(where daterange((aod.as_of_date - interval '4 years')::date, aod.as_of_date::date) @> date_acquired) as "total_artworks_4y",
                 count(distinct artwork) filter(where daterange((aod.as_of_date - interval '5 years')::date, aod.as_of_date::date) @> date_acquired) as "total_artworks_5y",
                 count(distinct artwork) filter(where aod.as_of_date > date_acquired) as "total_artworks_acum"--,
                 --min(circumference_cm) filter(where aod.as_of_date > date_acquired) as "min_circumference_cm",
                 --avg(circumference_cm) filter(where aod.as_of_date > date_acquired) as "mean_circumference_cm",
                 --max(circumference_cm) filter(where aod.as_of_date > date_acquired) as "max_circumference_cm"

                 from cohorts.alive_artists
                where aod.artist = artist  
             ) as t2
                 on true


);

create index features_aggregated_as_of_date_ix on features.aggregated(as_of_date);
create index features_aggregated_artist_ix on features.aggregated(artist);
create index features_aggregated_artist_as_of_date_ix on features.aggregated(artist, as_of_date);

