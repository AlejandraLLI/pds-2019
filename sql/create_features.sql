
drop table if exists features.entity_derived;

create table if not exists features.entity_derived as (
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
                 nationality, gender,
                 extract(year from as_of_date)-birth_year as age
                 from semantic.entities
                where aod.artist = artist 
             ) as t2
                 on true
);

create index features_entity_derived_artist_ix on features.entity_derived(artist);
create index features_entity_derived_as_of_date_ix on features.entity_derived(as_of_date);
create index features_entity_derived_artist_as_of_date_ix on features.entity_derived(artist, as_of_date);


-- wee create cohorts_artworks table so we can create indexes on it so the query to create features.aggregated runs much faster
drop table if exists cohorts_artworks;

create table if not exists cohorts_artworks as (

-- Create a cohort and select alive artists in the period
with as_of_dates as (
  -- Generate the as_of_date every 5 years. 
  select
    generate_series(min(date_acquired), max(date_acquired), '5 years') as as_of_date
  from semantic.events_artworks_in
),

entities_artworks as (
  select entities.*,artworks.artwork, artworks.date_acquired, artworks.year_made ,artworks.medium , 
artworks.classification, artworks.department ,artworks.cataloged , 
artworks.circumference_cm, artworks.depth_cm, artworks.diameter_cm , artworks.heigth_cm , artworks.length_cm, 
artworks.weight_kg , artworks.width_cm, 
artworks.seat_height_cm, artworks.duration_sec 
  from semantic.entities entities
  left join semantic.events_artworks_in artworks
  on entities.artist=artworks.artist

),
-- For each period in the as_of_date, select artists that entered an artwork  
-- with their corresponding characteristics. 
artists_cohort as (
  select
    -- Select variables from table entities in the semantic schema for the specific as_of_date
    date_acquired, artist, birth_year, artwork, year_made, medium, classification, department, cataloged,
    circumference_cm, depth_cm, diameter_cm , heigth_cm , length_cm, weight_kg , width_cm, 
    seat_height_cm, duration_sec ,
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
      select *, age(date_acquired, as_of_date)
      from entities_artworks
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
  ),

-- create artwork_age variable, we will use it to create a feature 
alived_cohort2 as (
  select *, extract(year from as_of_date)-year_made as artwork_age
  from alived_cohort
)

-- For each as_of_date, filter those observations(artists) that "entered a new artwork" and were alived
select *
from  alived_cohort2
where "entered" is true and alived = 'true'
);

create index cohorts_artworks_artist_ix on cohorts_artworks(artist);



drop table if exists features.aggregated;

create table if not exists features.aggregated as (

select * from
(
  select
    as_of_date,
    artist
    from
        labels.entered_artworks_1y
        --consulta_lab
) as aod

    --create features number of artworks in the last 1, 2, 3, 4 and 5 years, number of accumulated artworks, 
    --min, max and avg of artwork dimensions, mean artwork age
             left join lateral ( -- for loop
               select
                 count(distinct artwork) filter(where daterange((aod.as_of_date - interval '1 year')::date, aod.as_of_date::date) @> date_acquired) as "total_artworks_1y",
                 count(distinct artwork) filter(where daterange((aod.as_of_date - interval '2 years')::date, aod.as_of_date::date) @> date_acquired) as "total_artworks_2y",
                 count(distinct artwork) filter(where daterange((aod.as_of_date - interval '3 years')::date, aod.as_of_date::date) @> date_acquired) as "total_artworks_3y",
                 count(distinct artwork) filter(where daterange((aod.as_of_date - interval '4 years')::date, aod.as_of_date::date) @> date_acquired) as "total_artworks_4y",
                 count(distinct artwork) filter(where daterange((aod.as_of_date - interval '5 years')::date, aod.as_of_date::date) @> date_acquired) as "total_artworks_5y",
                 count(distinct artwork) filter(where aod.as_of_date > date_acquired) as "total_artworks_acum",
                 min(circumference_cm) filter(where aod.as_of_date > date_acquired) as "min_circumference_cm",
                 avg(circumference_cm) filter(where aod.as_of_date > date_acquired) as "mean_circumference_cm",
                 max(circumference_cm) filter(where aod.as_of_date > date_acquired) as "max_circumference_cm",
                 min(depth_cm) filter(where aod.as_of_date > date_acquired) as "min_depth_cm",
                 avg(depth_cm) filter(where aod.as_of_date > date_acquired) as "mean_depth_cm",
                 max(depth_cm) filter(where aod.as_of_date > date_acquired) as "max_depth_cm",
                 min(diameter_cm) filter(where aod.as_of_date > date_acquired) as "min_diameter_cm",
                 avg(diameter_cm) filter(where aod.as_of_date > date_acquired) as "mean_diameter_cm",
                 max(diameter_cm) filter(where aod.as_of_date > date_acquired) as "max_diameter_cm",
                 min(heigth_cm) filter(where aod.as_of_date > date_acquired) as "min_heigth_cm",
                 avg(heigth_cm) filter(where aod.as_of_date > date_acquired) as "mean_heigth_cm",
                 max(heigth_cm) filter(where aod.as_of_date > date_acquired) as "max_heigth_cm",
                 min(length_cm) filter(where aod.as_of_date > date_acquired) as "min_length_cm",
                 avg(length_cm) filter(where aod.as_of_date > date_acquired) as "mean_length_cm",
                 max(length_cm) filter(where aod.as_of_date > date_acquired) as "max_length_cm",
                 min(weight_kg) filter(where aod.as_of_date > date_acquired) as "min_weight_kg",
                 avg(weight_kg) filter(where aod.as_of_date > date_acquired) as "mean_weight_kg",
                 max(weight_kg) filter(where aod.as_of_date > date_acquired) as "max_weight_kg",
                 min(width_cm) filter(where aod.as_of_date > date_acquired) as "min_width_cm",
                 avg(width_cm) filter(where aod.as_of_date > date_acquired) as "mean_width_cm",
                 max(width_cm) filter(where aod.as_of_date > date_acquired) as "max_width_cm",
                 min(seat_height_cm) filter(where aod.as_of_date > date_acquired) as "min_seat_height_cm",
                 avg(seat_height_cm) filter(where aod.as_of_date > date_acquired) as "mean_seat_height_cm",
                 max(seat_height_cm) filter(where aod.as_of_date > date_acquired) as "max_seat_height_cm",
                 min(duration_sec) filter(where aod.as_of_date > date_acquired) as "min_duration_sec",
                 avg(duration_sec) filter(where aod.as_of_date > date_acquired) as "mean_duration_sec",
                 max(duration_sec) filter(where aod.as_of_date > date_acquired) as "max_duration_sec",
                 avg(artwork_age) filter(where aod.as_of_date > date_acquired) as "mean_artwork_age"


                 from cohorts_artworks
                where aod.artist = artist  
             ) as t2
                 on true

);



create index features_aggregated_as_of_date_ix on features.aggregated(as_of_date);
create index features_aggregated_artist_ix on features.aggregated(artist);
create index features_aggregated_artist_as_of_date_ix on features.aggregated(artist, as_of_date);

