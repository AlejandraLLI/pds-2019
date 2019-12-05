-- events_artworks table 
-- drop the table in the case that it already exists.
drop table if exists semantic.events_artworks;

-- Create the new table "events_artworks" in the semantic schema
create table semantic.events_artworks as(

-- Select and denormalize from table cleaned.artworks
select date_acquired, artwork, title, unnest(artist_array)::int as artist, year_made,
      medium, credit_line, classification, department, cataloged, url, thumbnailurl,
      circumference_cm, depth_cm, diameter_cm, heigth_cm, length_cm, weight_kg, width_cm,
      seat_height_cm, duration_sec
from cleaned.artworks
);

comment on table semantic.events_artworks is 'describe the characteristics of the artworks as events';

-- entity_artists table 
-- drop the table in the case that it already exists.
drop table if exists semantic.entity_artists;

-- Create the new table "entity_artists" in the semantic schema
create table semantic.entity_artists as(
-- Select and join variables from table cleaned.artists and semantic.events_artworks
with first_step as (
	select artists.artist, artists.name, artists.nationality, artists.gender, artists.birth_year,
		artists.death_year, artists.wiki_qid, artists.ulan,
		artworks.artwork, artworks.date_acquired as date_init, 
		count(distinct(artworks.artwork))
 	from ((select * from cleaned.artists) artists
        	left join semantic.events_artworks artworks
        	on artists.artist=artworks.artist)
 	group by artists.artist, artists.name, artists.nationality, artists.gender, artists.birth_year,
		 artists.death_year, artists.wiki_qid, artists.ulan, 
		 artworks.artwork, artworks.date_acquired
)

-- Order and create the final table
select	artist, artwork,
	sum(count) over (partition by artist order by date_init asc rows between unbounded preceding and current row) as status, 
	date_init,	
	lead(date_init)  over (partition by artist order by date_init asc rows between unbounded preceding and current row) as date_end,
	name, nationality, gender, birth_year, death_year, wiki_qid, ulan
from first_step

);

comment on table semantic.entity_artists is 'describe the characteristics of the artists as entities';

-- Create indexes
create index artworks_date_acquired_ix on semantic.events_artworks (date_acquired);
create index artworks_artwork_ix on semantic.events_artworks (artwork);
create index artworks_artist_ix on semantic.event_artworks (artist);
create index artworks_year_made_ix on cleaned.artworks (year_made);
create index artists_artist_ix on semantic.entity_artists (artist);
create index artists_artwork_ix on semantic.entity_artists (artwork);
create index artists_date_init_ix on semantic.entity_artists (date_init);
create index artists_date_end_ix on semantic.entity_artists (date_end);
create index artists_status_ix on semantic.entity_artists (status);


     