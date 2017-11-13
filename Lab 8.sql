DROP TABLE ActorData;
DROP TABLE DirectorData;
DROP TABLE PeopleData;
DROP TABLE MovieData;
DROP TABLE SalesData;
DROP TABLE CastData;


CREATE TABLE ActorData (
	PID int,
	BirthDate date,
	HairColor varchar(255),
	EyeColor varchar(255),
	HeightInInches int,
	Weight int,
	FavoriteColor varchar(255),
	ScreenActorsGuildAnniversaryDate date
);

CREATE TABLE DirectorData (
	PID int,
	FilmSchoolAttended varchar(255),
	DirectorsGuildAnniversaryDate date,
	FavoriteLensMaker varchar(255)
);

CREATE TABLE PeopleData (
	PID int,
	FirstName varchar(255),
	LastName varchar(255),
	Address varchar(255),
	SpouseName varchar(255)
);

CREATE TABLE MovieData (
	MPAANumber int,
	MovieName varchar(255),
	YearReleased int
);

CREATE TABLE SalesData (
	MPAANumber int,
	DomesticBoxOfficeSales int,
	ForeignBoxOfficeSales int,
	DVD/Blu-RaySales int
);

CREATE TABLE CastData (
	PID int,
	MPAANumber int,
	FirstName varchar(255),
	LastName varchar(255)
);