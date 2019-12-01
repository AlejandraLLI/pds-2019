-- artists table 
-- Create the new table "artists" in the cleaned schema
create table cleaned.artists as(

-- Select and edit variables from table raw.Artists
select
	-- Select variable ConstituentID, make it an integer and rename it as constituent. 
	"ConstituentID"::int as constituent_id,
	-- Select variable DisplayName, make it varchar and rename it as display_name. 
	"DisplayName"::varchar as diplay_name,
	-- Select variable Nationality, make it varchar and rename it as nationality. 
	"Nationality"::varchar as nationality,
	-- Select variable Gender, make it a date and rename it as gender. 
	"Gender"::varchar as gender,
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
	"Wiki QID"::varchar as wiki_qid,
	-- Select variable ULAN, make it a varchar and rename it as ulan_id. 
	"ULAN"::varchar as ulan_id

from raw.Artists
);

-- artworks table 
-- Create the new table "artworks" in the cleaned schema
create table cleaned.artworks as(

-- Select and edit variables from table raw.Artworks
select
	-- Select variable ObjectID, make it an integer and rename it as id. 
	"ObjectID"::int as id,

	-- Select variable Title, make it varchar and rename it as title. 
	"Title"::varchar as title,

	-- Select variable ConstituentID, make it an array and rename it as constituent_dict. 
	string_to_array("ConstituentID",', ') as constituent_dict,

	-- Select variable Date, make it a date and rename it as year_made. 
	case when substring("Date" from '[12]\d{3}')::int = NULL
		then 
			NULL
	else
		extract(year from to_date(substring("Date" from '[12]\d{3}'),'YYYY'))
	end as  year_made,

	-- Select variable Medium, make it varchar and rename it as medium.
	"Medium"::varchar as medium,

	-- Select variable CreditLine, make it varchar and rename it as creditline.
	"CreditLine"::varchar as credit_line,

	-- Select variable AccessionNumber, make it varchar and rename it as accession_number.
	"AccessionNumber"::varchar as accession_number,

	-- Select variable Classification, make it varchar and rename it as classification.
	"Classification"::varchar as classification,

	-- Select variable Department, make it varchar and rename it as deparment.
	"Department"::varchar as department

	-- Select variable DateAcquired, make it a date and rename it as date_acquired. 
	to_date("DateAcquired",'YYYY-MM-DD') as date_acquired

	-- Select variable Cataloged, make it varchar and rename it as cataloged.
	"Cataloged"::varchar as cataloged,

	-- Select variable URL, make it varchar and rename it as url.
	"URL"::varchar as url,
	
	-- Select variable ThumbnailURL, make it varchar and rename it as url.
	"ThumbnailURL"::varchar as thumbnailurl,
	"Circumference (cm)"::decimal as circumference_cm,
	"Depth (cm)"::decimal as depth_cm,
	"Diameter (cm)"::decimal as diameter_cm,
	"Height (cm)"::decimal as heigth_cm,
	"Length (cm)"::decimal as length_cm,
	"Weight (kg)"::decimal as weight_kg,
	"Width (cm)"::decimal as width_cm,
	"Seat Height (cm)"::decimal as seat_height_cm,
	"Duration (sec.)"::decimal as duration_sec

from raw.Artworks
);

