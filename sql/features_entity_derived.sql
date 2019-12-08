
drop table if exists features.entity_derived;

create table if not exists features.entity_derived as (
select * from
(
  select
    as_of_date,
    artist
    from
        labels.entered_artworks_1y
        --consulta2
) as aod
             left join lateral ( -- for loop
               select
                 nationality, gender,
                 extract(year from as_of_date)-birth_year as age
                 from semantic.entities
                 --consulta
                where aod.artist = artist 
             ) as t2
                 on true
);

create index features_entity_derived_artist_ix on features.entity_derived(artist);
create index features_entity_derived_as_of_date_ix on features.entity_derived(as_of_date);
create index features_entity_derived_artist_as_of_date_ix on features.entity_derived(artist, as_of_date);
