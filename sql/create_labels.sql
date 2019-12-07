drop table if exists labels.entered_artworks_1y;
create table if not exists labels.entered_artworks_1y as (

with outcomes as (
  select
    as_of_date,
    artist,
    date_acquired as event_date,
    entered as outcome
    from
        cohorts.alive_artists
)

select
  as_of_date, 
  artist, 
-- array_agg(event_date::date order by event_date asc) as event_dates, 
--  array_agg(outcome order by event_date asc) as outcomes, 
  bool_or(outcome)::integer as label
  from outcomes
 --where daterange(as_of_date, (as_of_date::date + interval '1 year')::date) @>  event_date
 group by as_of_date, artist
);

create index  labels_entered_artworks_1y_artist_ix on labels.entered_artworks_1y(artist);
create index  labels_entered_artworks_1y_as_of_date_ix on labels.entered_artworks_1y(as_of_date);
create index  labels_entered_artworks_1y_artist_as_of_date_ix on labels.entered_artworks_1y(artist, as_of_date);
