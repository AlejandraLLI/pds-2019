-- events_artworks_in table 
-- drop the table in the case that it already exists.
drop table if exists semantic.events_artworks_in;

-- Create the new table "events_artworks_in" in the semantic schema
create table semantic.events_artworks_in as(

-- Select and denormalize from table cleaned.artworks
select artwork, date_acquired, title, unnest(artist_array)::int as artist, year_made,
      medium, credit_line, classification, department, cataloged, url, thumbnailurl,
      circumference_cm, depth_cm, diameter_cm, heigth_cm, length_cm, weight_kg, width_cm,
      seat_height_cm, duration_sec
from cleaned.artworks
);

comment on table semantic.events_artworks_in is 'describe the static characteristics of the artworks as events';

-- Create indexes
create index events_artworks_in_date_acquired_ix on semantic.events_artworks_in (date_acquired);
create index events_artworks_in_artwork_ix on semantic.events_artworks_in (artwork);
create index events_artworks_in_artist_ix on semantic.events_artworks_in (artist);
create index events_artworks_in_year_made_ix on semantic.events_artworks_in (year_made);




-- events_artists_deaths table 
-- drop the table in the case that it already exists.
drop table if exists semantic.events_artists_deaths;

-- Create the new table "events_artists_deaths" in the semantic schema
create table semantic.events_artists_deaths as(

-- Select from table cleaned.artists
select artist, death_year
from cleaned.artists
);

comment on table semantic.events_artists_deaths is 'describes the event: an artist dies';

-- Create indexes
create index events_artists_deaths_artist_ix on semantic.events_artists_deaths (artist);
create index events_artists_deaths_death_year_ix on semantic.events_artists_deaths (death_year);




-- entities table 
-- drop the table in the case that it already exists.
drop table if exists semantic.entities;

-- Create the new table "entities" in the semantic schema
create table semantic.entities as(
-- Select and join variables from table cleaned.artists and semantic.events_artworks_in
select artist, name, nationality, gender, birth_year, wiki_qid, ulan
from cleaned.artists
);

comment on table semantic.entities is 'describe the characteristics of the artists as entities';

-- Create indexes
create index entities_artist_ix on semantic.entities (artist);
create index entities_artwork_ix on semantic.entities (artwork);
create index entities_date_acquired_ix on semantic.entities (date_acquired);
create index entities_nationality_ix on semantic.entities (nationality);
create index entities_gender_ix on semantic.entities (gender);



     
