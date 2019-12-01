-- artists table 
-- drop the table in the case that it already exists.
drop table if exists cleaned.artists;

-- Create the new table "artists" in the cleaned schema
create table cleaned.artists as(

-- Select and edit variables from table raw.Artists
select
	-- Select variable ConstituentID, make it an integer and rename it as atist. 
	"ConstituentID"::int as artist,
	-- Select variable DisplayName, make it varchar and rename it as name. 
	lower("DisplayName")::varchar as name,
	-- Select variable Nationality, make it varchar and rename it as nationality. 
	lower("Nationality")::varchar as nationality,
	-- Select variable Gender, make it a varchar and rename it as gender. 
	lower("Gender")::varchar as gender,
	-- Select variable BeginDate, make it a date and rename it as birth_year. 
	case when "BeginDate"::int = 0
		then 
			NULL
	else
		extract(year from to_date("BeginDate", 'YYYY'))
	end as  birth_year,
	-- Select variable EndDate, make it a date and rename it as death_year. 
	case when "EndDate"::int = 0
		then 
			NULL
	else
		extract(year from to_date("EndDate", 'YYYY'))
	end as death_year,
	-- Select variable "Wiki QID", make it a varchar and rename it as wiki_qid. 
	lower("Wiki QID")::varchar as wiki_qid,
	-- Select variable ULAN, make it a varchar and rename it as ulan_id. 
	"ULAN"::int as ulan

from raw.Artists
);

comment on table raw.artists is 'describe las características de los artistas';

-- Create indexes
create index cleaned_artists_artist_ix on cleaned.artists (artist);
create index cleaned_artists_bith_year_ix on cleaned.artists (birth_year);
create index cleaned_artists_death_year_ix on cleaned.artists (death_year);

-- artworks table 
-- drop the table in the case that it already exists.
drop table if exists cleaned.artworks;

-- Create the new table "artworks" in the cleaned schema
create table cleaned.artworks as(

-- Select and edit variables from table raw.Artworks
select
	-- Select variable ObjectID, make it an integer and rename it as artwork. 
	"ObjectID"::int as artwork,

	-- Select variable Title, make it varchar and rename it as title. 
	lower("Title")::varchar as title,

	-- Select variable ConstituentID, make it an array and rename it as artist_array. 
	string_to_array("ConstituentID",', ') as artist_array,

	-- Select variable Date, extract year, make it a date and rename it as year_made. 
	case when substring("Date" from '\d{4}')::int = NULL
		then 
			NULL
	else
		extract(year from to_date(substring("Date" from '[12]\d{3}'),'YYYY'))
	end as  year_made,

	-- Select variable Medium, make it varchar and rename it as medium.
	lower("Medium")::varchar as medium,

	-- Select variable CreditLine, make it varchar and rename it as credit_line.
	lower("CreditLine")::varchar as credit_line,

	-- Select variable AccessionNumber, make it varchar and rename it as accession_number.
	"AccessionNumber"::varchar as accession_number,

	-- Select variable Classification, make it varchar and rename it as classification.
	lower("Classification")::varchar as classification,

	-- Select variable Department, make it varchar and rename it as deparment.
	lower("Department")::varchar as department,

	-- Select variable DateAcquired, make it a date and rename it as date_acquired. 
	to_date("DateAcquired",'YYYY-MM-DD') as date_acquired,

	-- Select variable Cataloged, make it a character and rename it as cataloged.
	lower("Cataloged")::char as cataloged,

	-- Select variable URL, make it varchar and rename it as url.
	"URL"::varchar as url,
	
	-- Select variable ThumbnailURL, make it varchar and rename it as thumbnailurl.
	"ThumbnailURL"::varchar as thumbnailurl,
	-- Select variable Circumference (cm), make it decimal and rename it as circumference_cm.
	"Circumference (cm)"::decimal as circumference_cm,
	-- Select variable Depth (cm), make it decimal and rename it as depth_cm.
	"Depth (cm)"::decimal as depth_cm,
	-- Select variable Circumference (cm), make it decimal and rename it as circumference_cm.
	"Diameter (cm)"::decimal as diameter_cm,
	-- Select variable Diameter (cm), make it decimal and rename it as height_cm.
	"Height (cm)"::decimal as heigth_cm,
	-- Select variable Length (cm), make it decimal and rename it as length_cm.
	"Length (cm)"::decimal as length_cm,
	-- Select variable Weight (cm), make it decimal and rename it as weight_cm.
	"Weight (kg)"::decimal as weight_kg,
	-- Select variable Width (cm), make it decimal and rename it as width_cm.
	"Width (cm)"::decimal as width_cm,
	-- Select variable Circumference (cm), make it decimal and rename it as circumference_cm.
	"Seat Height (cm)"::decimal as seat_height_cm,
	-- Select variable Duration (sec.), make it decimal and rename it as duation_sec.
	"Duration (sec.)"::decimal as duration_sec

from raw.Artworks
);

comment on table raw.artworks is 'describe las características de las obras de arte';

-- Create indexes
create index cleaned_artworks_artwork_ix on cleaned.artworks (artwork);
create index cleaned_artworks_artist_array_ix on cleaned.artworks (artist_array);
create index cleaned_artworks_year_made_ix on cleaned.artworks (year_made);
create index cleaned_artworks_date_acquired_ix on cleaned.artworks (date_acquired);
