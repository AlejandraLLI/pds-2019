-- features_moma table 
-- drop the table in the case that it already exists.
drop table if exists features.features_moma;

-- Create the new table "features_moma" in the features schema
create table features.features_moma as(

-- Join tables semantic.entity_artists and semantic.events_artworks and create
-- new features. 
select 
-- Select variables from table semantic.entity_artists
entity.artist, entity.artwork, entity.status, entity.date_init, entity.date_end, entity.name, 
entity.nationality, entity.gender, entity.birth_year, entity.death_year, entity.wiki_qid, entity.ulan, 
-- Select variables from table semantic.events_artwoks
events.title, events.year_made, events.medium, events.credit_line, events.classification, events.department,
events.cataloged, events.url, events.thumbnailurl, events.circumference_cm, events.depth_cm, events.diameter_cm,
events.heigth_cm, events.length_cm, events.weight_kg, events.width_cm, events.seat_height_cm, events.duration_sec,
-- Create variable duration_status as date in days
entity.date_end-entity.date_init as duration_status,
-- Create variable entered_years_after_death as integer
case when entity.death_year = NULL then NULL 
else extract(year from events.date_acquired) - death_year
end::int as entered_years_after_death,
-- Create variable number_authors as integer
count(entity.artwork) over (partition by entity.artwork)::int as number_authors

from (
	semantic.entity_artists entity 
	left join semantic.events_artworks events
	on entity.artist=events.artist 
	and entity.artwork=events.artwork 
	and entity.date_init=events.date_acquired
	)
);

comment on table features.features_moma is 'describe las características de los datos moma';

-- Create indexes
create index features_features_moma_artist_ix on features.features_moma (artist);
create index features_features_moma_artwork_ix on features.features_moma (artwork);
create index features_features_moma_status_ix on features.features_moma (status);
create index features_features_moma_date_init_ix on features.features_moma (date_init);
create index features_features_moma_date_end_ix on features.features_moma (date_end);
create index features_features_moma_nationality_ix on features.features_moma (nationality);
create index features_features_moma_birth_year_ix on features.features_moma (birth_year);
create index features_features_moma_death_year_ix on features.features_moma (death_year);
create index features_features_moma_year_made_ix on features.features_moma (year_made);
create index features_features_moma_classification_ix on features.features_moma (classification);
create index features_features_moma_department_ix on features.features_moma (department);
