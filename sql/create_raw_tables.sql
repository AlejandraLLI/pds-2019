create schema if not exists raw;

drop table if exists raw.Artists;

CREATE TABLE raw.Artists(
  "ConstituentID" TEXT,
  "DisplayName" TEXT,
  "ArtistBio" TEXT,
  "Nationality" TEXT,
  "Gender" TEXT,
  "BeginDate" TEXT,
  "EndDate" TEXT,
  "Wiki QID" TEXT,
  "ULAN" TEXT
);


comment on table raw.Artists is 'describes artist characteristics';


drop table if exists raw.Artworks;

CREATE TABLE raw.Artworks(
  "Title" TEXT,
  "Artist" TEXT,
  "ConstituentID" TEXT,
  "ArtistBio" TEXT,
  "Nationality" TEXT,
  "BeginDate" TEXT,
  "EndDate" TEXT,
  "Gender" TEXT,
  "Date" TEXT,
  "Medium" TEXT,
  "Dimensions" TEXT,
  "CreditLine" TEXT,
  "AccessionNumber" TEXT,
  "Classification" TEXT,
  "Department" TEXT,
  "DateAcquired" TEXT,
  "Cataloged" TEXT,
  "ObjectID" TEXT,
  "URL" TEXT,
  "ThumbnailURL" TEXT,
  "Circumference (cm)" TEXT,
  "Depth (cm)" TEXT,
  "Diameter (cm)" TEXT,
  "Height (cm)" TEXT,
  "Length (cm)" TEXT,
  "Weight (kg)" TEXT,
  "Width (cm)" TEXT,
  "Seat Height (cm)" TEXT,
  "Duration (sec.)" TEXT
);


comment on table raw.Artworks is 'describes artwork characteristics';



