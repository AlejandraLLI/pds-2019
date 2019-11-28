create schema if not exists raw;

drop table if exists raw.Artists;

create table raw.Artists (
  "ConstituentID" TEXT,
  "DisplayName" TEXT,
  "ArtistBio" TEXT,
  "Nationality" TEXT,
  "Gender" TEXT,
  "BeginDate" TEXT,
  "EndDate" TEXT,
  "Wiki_QID" TEXT,
  "QID" TEXT
  "ULAN" TEXT
);

comment on table raw.account is 'describes artist characteristics';


drop table if exists raw.Artworks;

create table raw.Artworks (
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
	"Circumference" TEXT,
	"Depth" TEXT,
	"Diameter" TEXT,
	"Height" TEXT,
	"Length" TEXT,
	"Weight" TEXT,
	"Width" TEXT,
	"Seat_Height" TEXT,
	"Duration" TEXT

);


comment on table raw.client is 'describes artwork characteristics';



