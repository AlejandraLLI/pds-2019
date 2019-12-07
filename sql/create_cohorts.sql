-- alive_artists table 
-- drop the table in the case that it already exists.
drop table if exists cohorts.alive_artists;

-- Create the new table "alive_atists" in the cohorts schema
create table if not exists cohorts.alive_artists as (
-- Create a cohort and select alive artists in the period
with as_of_dates as (
  -- Generate the as_of_date every 5 years. 
  select
    generate_series(min(date_acquired), max(date_acquired), '5 years') as as_of_date
    from
        semantic.events_artworks_in
),
-- For each period in the as_of_date, select artists that entered an artwork  
-- with their corresponding characteristics. 
artists_cohort as (
  select
    -- Select variables from table entities in the semantic schema for the specific as_of_date
    date_acquired, artist, name, gender, nationality, birth_year, artwork, wiki_qid, ulan,
    -- Select variable as_of_date as a date
    aod.as_of_date::date,
    -- Create variable "entered" as boolean for artworks that entered in the last 10 years. 
    daterange(
      (aod.as_of_date - interval '10 year')::date, aod.as_of_date::date) @> date_acquired as "entered"       
    -- Select the corresponding as_of_date
    from (
      select
        as_of_date
      from as_of_dates
    ) as aod
    -- Join observations row by row with entities table from semantic schema
    left join lateral (
      select *, age(date_acquired,as_of_date)
      from semantic.entities
    ) as t2 on true
  ),

-- For each observation in the cohort, add data from the event "death artist" and create 
-- the boolean "alived"  
alived_cohort as (
  -- Select all variables fom table "artist_cohort" and rename it as artists
  select artists.*,
  -- Ceate variable "alived" as boolean for artists that are alived at each as_of_date
  case
    when extract(year from date_acquired) < deaths.death_year then true
    when deaths.death_year is null then true
    else false
  end as alived
  from artists_cohort artists
  -- Join table artist_cohort with table events_artists_deaths
  left join semantic.events_artists_deaths deaths
    on artists.artist=deaths.artist
  )

-- For each as_of_date, filter those observations(artists) that "entered a new artwork" and were alived
select *
from  alived_cohort
where "entered" is true and alived = 'true'
);