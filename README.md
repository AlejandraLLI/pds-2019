# Final Project: Programming for Data Science 2019

This project provides a structured workflow for loading and analyzing the The Museum of Modern Art ([MoMA]) research dataset  [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3524700.svg)](https://doi.org/10.5281/zenodo.3524700) using [PosgtreSQL] and [Python 3.7.3] as part of the final project of Programming for Data Science 2019. 

#### Contact Information

  - Alejandra Lelo de Larrea Ibarra  - - 124433
  - Itzel Zayil Muñoz Fernández de Córdova - - 122803
  - René Rosado González - - 137085

#### Data Source

This project utilizes The Museum of Modern Art ([MoMA]) research dataset 
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3524700.svg)](https://doi.org/10.5281/zenodo.3524700)
> This research dataset contains 138,124 records, representing all of the works that 
> have been accessioned into MoMA’s collection and cataloged in our database.  ([MoMa])

The database is compossed of two tables 
> It includes basic metadata for each work, including title, artist, date made, medium,
> dimensions, and date acquired by the Museum. Some of these records have incomplete 
> information and are noted as “not Curator Approved.”  ([MoMa])


   [PosgtreSQL]: <https://www.postgresql.org/>
   [Python 3.7.3]: <https://www.python.org/downloads/release/python-373/>
   [MoMa]: <https://github.com/MuseumofModernArt/collection>

These tables are available in csv files and json files, and have the following columns:

###### Artists
+ ConstituentID -- artist's ID
+ DisplayName -- artist's name
+ ArtistBio -- artist's biography
+ Nationality -- artist's nationality
+ Gender -- artist's gender
+ BeginDate -- artist's birth year
+ EndDate -- artist's death year
+ Wiki QID -- artist's ID in Wikidata
+ ULAN -- artist's ID in  *"Union List of Artist Names"*

###### Artworks
+ Title -- artwork's title
+ Artist -- artist's name or artists' names that created the artwork
+ ConstituentID -- artist's or artists' ID that created the artwork
+ ArtistBio -- artist's bio
+ Nationality -- artist's nationality
+ BeginDate -- artist's birth year
+ EndDate -- artist's death year
+ Gender -- artist's gender
+ Date -- year when the artwork was created
+ Medium -- materials the artwork is made from
+ Dimensions -- artwork's dimensions
+ CreditLine -- artwork's credit line
+ AccessionNumber -- the first number indicates the order when the artwork was acquired in the respective year, the second number is the year the artwork was acquired, the third number (when it exists) indicates the piece number of the artwork
+ Classification -- type of artwork
+ Department -- artwork's department
+ DateAcquired -- year when MoMA acquired the artwork
+ Cataloged -- whether the artwork is cataloged or not
+ ObjectID -- artwork's ID
+ URL -- artwork's URL in MoMA's web page
+ ThumbnailURL -- artwork's thumb nail url in MoMA's web page
+ Circumference (cm) -- artwork's circumference (if applies)
+ Depth (cm) -- artwork's depth (if applies)
+ Diameter (cm) -- artwork's diameter (if applies)
+ Height (cm) -- artwork's height (if applies)
+ Length (cm) -- artwork's length (if applies)
+ Weight (kg) -- artwork's weight (if applies)
+ Width (cm) -- artwork's width (if applies)
+ Seat Height (cm) -- artwork's seat height (if applies)
+ Duration (sec.) -- artwork's duration (if applies)

In this project we use the csv files.

#### Workflow

The sh directory in the repo, contains **.sh** files that execute the complete workflow:

  - Creating the virtual environment and installing python packages -- *crear_pyenv_moma.sh*
  - Downloading MoMA files -- *descargar_datos_moma.sh*
  - Creating Postgresql user and database -- *crear_usuario_bd_moma.sh*
  - Cleaning the database -- *pipeline.sh*
  - Creating the semantic schema -- *pipeline.sh*
  - Creating features -- *pipeline.sh*
 
To execute de complete workflow, you need to follow this steps:
  - Change to root directory:
```text
cd ~
```
  - Clone this git repository: 
```text
git clone https://github.com/AlejandraLLI/pds-2019.git
```
  - Change to the repo directory:
```text
cd pds-2019
```
  - Give execution permission to pipeline.sh file:
```text
chmod +x ./sh/pipeline.sh
```
  - Execute pipeline.sh file:
```text
./sh/crear_usuario_bd_moma.sh
```
The next steps would be executed by **pipeline.sh** file with the previous command.

After completing these steps, you can enter to Postgresql and confirm all the tables where created using this commands:
```text
psql -h 0.0.0.0 -U moma -d moma -W
```
This command will ask for the password defined in *crear_usuario_bd_moma.sh*

Now you are in Postgresql and you can view the schemas in the database:
```text
\dn
```
This will show cleaned, features, raw and semantic schemas with moma Owner, like shown below:
```text
   List of schemas
   Name   │  Owner   
══════════╪══════════
 cleaned  │ moma
 features │ moma
 public   │ postgres
 raw      │ moma
 semantic │ moma
```

You can also view the tables in each schema, for example:
```text
\dt raw.
```
Output
```text
         List of relations
 Schema │   Name   │ Type  │ Owner 
════════╪══════════╪═══════╪═══════
 raw    │ artists  │ table │ moma
 raw    │ artworks │ table │ moma
(2 rows)
```

You can use a description command to know more about a table:
```text
\d cleaned.artworks;
```
Output:
```text
                       Table "cleaned.artworks"
      Column      │       Type        │ Collation │ Nullable │ Default 
══════════════════╪═══════════════════╪═══════════╪══════════╪═════════
 artwork          │ integer           │           │          │ 
 title            │ character varying │           │          │ 
 artist_array     │ text[]            │           │          │ 
 year_made        │ double precision  │           │          │ 
 medium           │ character varying │           │          │ 
 credit_line      │ character varying │           │          │ 
 accession_number │ character varying │           │          │ 
 classification   │ character varying │           │          │ 
 department       │ character varying │           │          │ 
 date_acquired    │ date              │           │          │ 
 cataloged        │ character(1)      │           │          │ 
 url              │ character varying │           │          │ 
 thumbnailurl     │ character varying │           │          │ 
 circumference_cm │ numeric           │           │          │ 
 depth_cm         │ numeric           │           │          │ 
 diameter_cm      │ numeric           │           │          │ 
 heigth_cm        │ numeric           │           │          │ 
 length_cm        │ numeric           │           │          │ 
 weight_kg        │ numeric           │           │          │ 
 width_cm         │ numeric           │           │          │ 
 seat_height_cm   │ numeric           │           │          │ 
 duration_sec     │ numeric           │           │          │ 
Indexes:
    "cleaned_artworks_artist_array_ix" btree (artist_array)
    "cleaned_artworks_artwork_ix" btree (artwork)
    "cleaned_artworks_date_acquired_ix" btree (date_acquired)
    "cleaned_artworks_year_made_ix" btree (year_made)
```
If you want to view a line in the table:
```text
select * from cleaned.artists limit 1;
```
Output:
```text
 artist │      name      │ nationality │ gender │ birth_year │ death_year │ wiki_qid │ ulan 
════════╪════════════════╪═════════════╪════════╪════════════╪════════════╪══════════╪══════
      1 │ robert arneson │ american    │ male   │       1930 │       1992 │ ¤       │   ¤
(1 row)
```

#### Semantic Schema

###### Entity -- artist
We would like to use the database to answer questions about the artist, so we defined the artist as the entity. We want to focus on the number of artworks each artists has in MoMA through the sample period, and how fast or slow this number increases according to artist's different characteristics (gender, age, nationality, etc). Therefore, the artist's status is defined as the number of artworks he or she has in MoMA collection. The status changes everytime MoMA acquires another artwork of the artist, so the period an artist stays in a specific status goes from 0 days to years.
The entity table has the following columns:
+ artist
+ artwork
+ status -- artist's number of artworks that are in the MoMA collection
+ date_init -- date when MoMA acquires the respective artwork which defines the status
+ date_end -- date when MoMA acquires the next artwork (if applies)
+ name
+ nationality 
+ gender
+ birth_year 
+ death_year
+ wiki_qid
+ ulan

###### Events -- artist's artwork is accessioned into MoMA’s collection 
The event happens when MoMA acquires an artwork, so we respect the structure of artworks table because we want to keep all artworks characteristics. The only difference is that we unnest the artist array, so we have one line for each artist that created the artwork. 
The events table has the following columns:   
+ date_acquired
+ artwork
+ title
+ artist
+ year_made
+ medium 
+ credit_line 
+ classification
+ department
+ cataloged
+ url 
+ thumbnailurl
+ circumference_cm 
+ depth_cm 
+ diameter_cm
+ heigth_cm 
+ length_cm 
+ weight_kg
+ width_cm
+ seat_height_cm
+ duration_sec

#### Features






