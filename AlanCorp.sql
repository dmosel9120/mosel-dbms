DROP TABLE Locations CASCADE;

-- This table highlights the numerous locations that the three key divisions of the firm can be found --

CREATE TABLE IF NOT EXISTS Locations (
	LID int NOT NULL UNIQUE,
	state varchar(255) NOT NULL,
	city varchar(255) NOT NULL,
	street varchar(255) NOT NULL,
	addressNumber int NOT NULL,
	numberOfFloors int NOT NULL,
	PRIMARY KEY (LID)
);

INSERT INTO Locations
VALUES (1, 'NY', 'New York', '5th Avenue', 522, 50);

INSERT INTO Locations
VALUES (2, 'CT', 'Greenwich', 'St. Adams', 537, 25);

INSERT INTO Locations
VALUES (3, 'MA', 'Boston', 'Commonwealth Avenue', 129, 35);

SELECT * 
FROM Locations;

DROP TABLE Divisions CASCADE;

-- The Divisions table creates the three sections of the company that make substantial revenue including Private_Wealth_Management, Sales_and_Trading and Investment_Banking

CREATE TABLE IF NOT EXISTS Divisions (
	DID int NOT NULL UNIQUE,
	description varchar(255) NOT NULL,
	yearlyRevenueUSD int NOT NULL,
	numberOfEmployees int NOT NULL,
	nameofPresident varchar(255) NOT NULL,
	PRIMARY KEY (DID)
);

INSERT INTO Divisions
VALUES (1, 'Private Wealth Management', 500000000, 1500, 'John McCmullen');

INSERT INTO Divisions
VALUES (2, 'Sales and Trading', 750000000, 2000, 'Craig Keystone');

INSERT INTO Divisions
VALUES (3, 'Investment Banking', 900000000, 2500, 'Todd Ferguson');

SELECT *
FROM Divisions;

DROP TABLE People CASCADE;

-- The people table is a crucial part of this database as it contains basic information about all of the firms employees -- 

CREATE TABLE IF NOT EXISTS People (
	PID int NOT NULL UNIQUE,
	firstName varchar(255) NOT NULL,
	lastName varchar(255) NOT NULL,
	gender varchar(255) NOT NULL,
	birthDate date NOT NULL,
	hobby varchar(255),
	yearsOfExperience int NOT NULL,
	DID int NOT NULL,
	LID int,
	CONSTRAINT gender_type CHECK (gender = 'F' OR gender = 'M'),
	PRIMARY KEY (PID),
	FOREIGN KEY (DID) REFERENCES Divisions (DID),
	FOREIGN KEY (LID) REFERENCES Locations (LID)
);

-- This is a trigger which displays what division is associated with what location and where the employees can be found -- 

CREATE OR REPLACE FUNCTION Division_Location() RETURNS trigger AS 
$$
BEGIN
	IF NEW.PID = (SELECT MAX(PID) FROM People) THEN 
		IF NEW.DID = 1 THEN
			UPDATE People 
			SET LID = 3
			WHERE PID = NEW.PID;
		END IF;
	
		IF NEW.DID = 2 THEN
			UPDATE People
			SET LID = 2
			WHERE PID = NEW.PID;
		END IF;
		
		IF NEW.DID = 3 THEN
			UPDATE People
			SET LID = 1
			WHERE PID = NEW.PID;
		END IF;

	END IF;
	RETURN NEW;

END;
$$
LANGUAGE PLPGSQL;

DROP TRIGGER IF EXISTS Divison_Location ON People;
CREATE TRIGGER Division_Location
AFTER INSERT ON People
FOR EACH ROW 
EXECUTE PROCEDURE Division_Location();


INSERT INTO People
VALUES (1, 'Jesse', 'Korris', 'M', '19600517', 'Skiing', 27, (SELECT DID FROM divisions WHERE description = 'Sales and Trading'));

INSERT INTO People
VALUES (2, 'Mitch', 'Krout', 'M', '19700206', 'Hangliding', 17, (SELECT DID FROM divisions WHERE description = 'Investment Banking'));

INSERT INTO People
VALUES (3, 'Greg', 'King', 'M', '19430725', 'Golfing', 5, (SELECT DID FROM divisions WHERE description = 'Private Wealth Management'));

INSERT INTO People
VALUES (4, 'Jessica', 'Albert', 'F', '19660303', 'Billiards', 2, (SELECT DID FROM divisions WHERE description = 'Private Wealth Management'));

INSERT INTO People
VALUES (5, 'Angela', 'Paulson', 'F', '19720801', 'Soccer', 10, (SELECT DID FROM divisions WHERE description = 'Investment Banking'));

INSERT INTO People
VALUES (6, 'Dietrich', 'Mosel', 'M', '19960710', 'Running', 0, (SELECT DID FROM divisions WHERE description = 'Private Wealth Management'));

INSERT INTO People
VALUES (7, 'Alan', 'Labouseur', 'M', '19651118', 'Portal', 14, (SELECT DID FROM divisions WHERE description = 'Sales and Trading'));

INSERT INTO People
VALUES (8, 'Sam', 'Chantly', 'F', '19870122', 'Cooking', 6, (SELECT DID FROM divisions WHERE description = 'Sales and Trading'));

INSERT INTO People
VALUES (9, 'Chris', 'Badolato', 'M', '19571212', 'Restoring Cars', 32, (SELECT DID FROM divisions WHERE description = 'Private Wealth Management'));

INSERT INTO People
VALUES (10, 'Emily', 'Roberts', 'F', '19920919', 'Traveling', 3, (SELECT DID FROM divisions WHERE description = 'Investment Banking'));

INSERT INTO People
VALUES (11, 'Gianna', 'Louro', 'F', '19570314', '', 26, (SELECT DID FROM divisions WHERE description = 'Investment Banking'));

INSERT INTO People
VALUES (12, 'Mark', 'Valentino', 'M', '19630721', 'Card Counting', 14, (SELECT DID FROM divisions WHERE description = 'Private Wealth Management'));

INSERT INTO People
VALUES (13, 'Vinny', 'Donatacci', 'M', '19870307', 'Volunteering', 7, (SELECT DID FROM divisions WHERE description = 'Sales and Trading'));

INSERT INTO People
VALUES (14, 'Kenny', 'Walshek', 'M', '19690516', 'Teaching', 15, (SELECT DID FROM divisions WHERE description = 'Private Wealth Management'));

INSERT INTO People
VALUES (15, 'Michaela', 'Murray', 'F', '19590401', 'Wine Tasting', 8, (SELECT DID FROM divisions WHERE description = 'Investment Banking'));

INSERT INTO People
VALUES (16, 'Bianca', 'Luparello', 'F', '19740603', 'Clubbing', 2, (SELECT DID FROM divisions WHERE description = 'Sales and Trading'));

INSERT INTO People
VALUES (17, 'John', 'Lee', 'M', '19571010', 'Video Games', 36, (SELECT DID FROM divisions WHERE description = 'Private Wealth Management'));

INSERT INTO People
VALUES (18, 'Kyle', 'Hannafin', 'M', '19770920', 'Basketball', 22, (SELECT DID FROM divisions WHERE description = 'Private Wealth Management'));

INSERT INTO People
VALUES (19, 'Olivia', 'Cray', 'F', '19840727', 'Coding', 18, (SELECT DID FROM divisions WHERE description = 'Sales and Trading'));

INSERT INTO People
VALUES (20, 'Tom', 'Slattery', 'M', '19881229', 'Snow Boarding', 13, (SELECT DID FROM divisions WHERE description = 'Investment Banking'));

SELECT *
FROM People;

DROP TABLE Client_Service_Associates CASCADE;

-- The Client_Service_Associates table describes a position at the firm which is lower level but serves as a springboard to the analyst level -- 

CREATE TABLE IF NOT EXISTS Client_Service_Associates (
	CSAID int NOT NULL UNIQUE,
	position varchar(255) NOT NULL DEFAULT 'Client Service Associate', -- The default function in this statement makes it so that we dont have to input the position over and over again -- 
	numberOfLanguagesSpoken int NOT NULL,
	cellPhoneNumber int NOT NULL,
	emailsSentInADay int NOT NULL,
	PRIMARY KEY (CSAID), 
	FOREIGN KEY (CSAID) REFERENCES people(PID)
);

INSERT INTO Client_Service_Associates
VALUES (3, DEFAULT, 3, 51631856, 30);

INSERT INTO Client_Service_Associates
VALUES (4, DEFAULT, 2, 64951324, 50);

INSERT INTO Client_Service_Associates
VALUES (6, DEFAULT, 4, 65385109, 34);

INSERT INTO Client_Service_Associates
VALUES (8, DEFAULT, 1, 54675638, 45);

INSERT INTO Client_Service_Associates
VALUES (10, DEFAULT, 1, 93756475, 25);

INSERT INTO Client_Service_Associates
VALUES (15, DEFAULT, 2, 66254091, 66);

INSERT INTO Client_Service_Associates
VALUES (16, DEFAULT, 3, 29061534, 89);

SELECT *
FROM Client_Service_Associates;

DROP TABLE Managing_Directors CASCADE;

-- The Managing_Directors table describes a position at the firm which is the highest level and makes all the important decisions -- 

CREATE TABLE IF NOT EXISTS Managing_Directors (
	MID int NOT NULL UNIQUE,
	position varchar(255) NOT NULL DEFAULT 'Managing Director',
	salary int NOT NULL,
	numberOfClients int NOT NULL,
	meetingsPerYear int NOT NULL,
	PRIMARY KEY (MID), 
	FOREIGN KEY (MID) REFERENCES people(PID)
);

INSERT INTO Managing_Directors
VALUES (1, DEFAULT, 250778, 275, 223);

INSERT INTO Managing_Directors
VALUES (9, DEFAULT, 176348, 236, 187);

INSERT INTO Managing_Directors
VALUES (11, DEFAULT, 326331, 401, 356);

INSERT INTO Managing_Directors
VALUES (17, DEFAULT, 108450, 210, 142);

INSERT INTO Managing_Directors
VALUES (19, DEFAULT, 223791, 260, 218);

INSERT INTO Managing_Directors
VALUES (20, DEFAULT, 223791, 260, 218);

-- This trigger makes it so that a Managing Director will get a raise if they obtain more than 20% new clients as compared to their existing client base. -- 
-- If they do get 20% more clients, that Managing Director gets a $50,000 raise -- 

CREATE OR REPLACE FUNCTION Pay_Raise() RETURNS trigger AS 
$$
BEGIN 
	IF OLD.numberOfClients < NEW.numberOfClients THEN 
		IF (NEW.numberOfClients - OLD.numberOfClients / OLD.numberOfClients) >= .20 THEN
			UPDATE Managing_Directors 
			SET salary = salary + 50000
			WHERE MID = NEW.MID;
		END IF;

	END IF;
	RETURN NEW;

END;
$$
LANGUAGE PLPGSQL;

CREATE TRIGGER Pay_Raise
AFTER UPDATE ON Managing_Directors
FOR EACH ROW 
EXECUTE PROCEDURE Pay_Raise();

UPDATE Managing_Directors
SET numberOfClients = 315
WHERE MID = 19;

SELECT *
FROM Managing_Directors;

DROP TABLE Analysts CASCADE;

-- The Analysts table describes a position at the firm which is middle level between CSA and Managing Director -- 

CREATE TABLE IF NOT EXISTS Analysts (
	ANID int NOT NULL UNIQUE,
	position varchar(255) NOT NULL DEFAULT 'Analyst',
	companyToResearch varchar(255) NOT NULL,
	firstCollegeAttended varchar(255) NOT NULL,
	favoriteDrink varchar(255),
	PRIMARY KEY (ANID), 
	FOREIGN KEY (ANID) REFERENCES people(PID)
);

INSERT INTO Analysts
VALUES (2, DEFAULT, 'Apple', 'Harvard', 'Dirty Martini');

INSERT INTO Analysts
VALUES (5, DEFAULT, 'Boeing', 'Marist', 'Tokyo Mule');

INSERT INTO Analysts
VALUES (7, DEFAULT, 'ImmunoGen', 'UCLA', 'Four Score');

INSERT INTO Analysts
VALUES (12, DEFAULT, 'Skyworks Solutions', 'UPenn', 'Bloodhound');

INSERT INTO Analysts
VALUES (13, DEFAULT, 'MongoDB', 'Princeton', 'Grog');

INSERT INTO Analysts
VALUES (14, DEFAULT, 'Nvidia', 'Stony Brook', 'Sake Bomb');

INSERT INTO Analysts
VALUES (18, DEFAULT, 'Google', 'Lehigh', 'Long Island Iced Tea');

SELECT *
FROM Analysts;

DROP TABLE Private_Wealth_Management CASCADE;

-- This table describes the Private_Wealth_Management business which entails crucial areas such as how many assets the firm controls -- 

CREATE TABLE IF NOT EXISTS Private_Wealth_Management (
	DID int NOT NULL UNIQUE,
	Divisionname varchar(255) NOT NULL,
	assetsUnderManagement int NOT NULL,
	topTeam varchar(255) NOT NULL,
	vacationDaysTaken int NOT NULL,
	highestNetWorthClient varchar(255) NOT NULL,
	PRIMARY KEY (DID)
);

INSERT INTO Private_Wealth_Management
VALUES (1, 'Private Wealth Management', 500000000, 'Labouseur Wealth Management', 5, 54260771);

SELECT *
FROM Private_Wealth_Management;

DROP TABLE Sales_and_Trading CASCADE;

-- This table describes the Sales_and_Trading division of the business and the types of trades employees make -- 

CREATE TABLE IF NOT EXISTS Sales_and_Trading (
	DID int NOT NULL UNIQUE,
	Divisionname varchar(255) NOT NULL,
	equityPositions int NOT NULL,
	fixedIncomePositions int NOT NULL,
	topTrader varchar(255) NOT NULL,
	PRIMARY KEY (DID)
);

INSERT INTO Sales_and_Trading
VALUES (2, 'Sales and Trading', 10260, 4310, 'Josh Berman');

SELECT *
FROM Sales_and_Trading;

DROP TABLE Investment_Banking CASCADE;

-- The Investment_Banking table describes the division and key areas which are associated with the business like mergers and acquisitions --

CREATE TABLE IF NOT EXISTS Investment_Banking (
	DID int NOT NULL UNIQUE,
	Divisionname varchar(255) NOT NULL,
	numberOfMergers int NOT NULL,
	numberOfAcquisitions int NOT NULL,
	capitalRaised int NOT NULL,
	PRIMARY KEY (DID)
);

INSERT INTO Investment_Banking
VALUES (3, 'Investment Banking', 27, 56, 1320564338);

SELECT *
FROM Investment_Banking;

DROP TABLE Awards CASCADE;

-- The awards table which yields the employee and their rank on the repsective award list along with the year they received the award -- 

CREATE TABLE IF NOT EXISTS Awards (
	AID int NOT NULL,
	PID int NOT NULL,
	rank int NOT NULL,
	yearWon int NOT NULL DEFAULT '1900',
	PRIMARY KEY (AID, PID, yearWon),
	FOREIGN KEY (AID) REFERENCES Accolades (AID),
	FOREIGN KEY (PID) REFERENCES People (PID)
);

INSERT INTO Awards
VALUES (1, 17, 32, '2015');

INSERT INTO Awards
VALUES (1, 17, 24, '2017');

INSERT INTO Awards
VALUES (2, 7, 25, '2015');

INSERT INTO Awards
VALUES (3, 2, 17, '2002');

INSERT INTO Awards
VALUES (4, 13, 48, '2007');

INSERT INTO Awards
VALUES (4, 7, 36, '2007');

INSERT INTO Awards
VALUES (5, 19, 9, '2015');

INSERT INTO Awards
VALUES (6, 5, 37, '2009');

INSERT INTO Awards
VALUES (7, 9, 3, '2013');

INSERT INTO Awards
VALUES (7, 18, 5, '2013');

INSERT INTO Awards
VALUES (8, 14, 13, '2014');

INSERT INTO Awards
VALUES (9, 12, 21, '2017');

INSERT INTO Awards
VALUES (10, 11, 2, '2001');

INSERT INTO Awards
VALUES (10, 11, 4, '2008');

INSERT INTO Awards
VALUES (11, 1, 22, '1998');

INSERT INTO Awards
VALUES (12, 20, 19, '1997');

INSERT INTO Awards
VALUES (12, 20, 13, '2007');

DROP TABLE Accolades CASCADE;

-- Accolades table to describe awards given to employees and the publication in which they come from -- 

CREATE TABLE IF NOT EXISTS Accolades (
	AID int NOT NULL UNIQUE,
	name varchar(255) NOT NULL,
	publication varchar(255) NOT NULL,
	PRIMARY KEY (AID)
);

INSERT INTO Accolades
VALUES (1, 'Top 50 U.S. Money Managers', 'Investors Business Daily');

INSERT INTO Accolades
VALUES (2, 'Top 25 Global Traders', 'Bloomberg');

INSERT INTO Accolades
VALUES (3, 'Top 20 Most Profitable Acquisitions Made', 'Wall Street Journal');

INSERT INTO Accolades
VALUES (4, 'Top 50 Global Traders', 'ZeroHedge');

INSERT INTO Accolades
VALUES (5, 'Top 10 Connecticut Traders', 'Time');

INSERT INTO Accolades
VALUES (6, 'Top 50 Most Profitable Mergers Made', 'Investopedia');

INSERT INTO Accolades
VALUES (7, 'Top 5 Global Money Managers', 'Money Magazine');

INSERT INTO Accolades
VALUES (8, 'Top 15 Largest Money Managers', 'The Economist');

INSERT INTO Accolades
VALUES (9, 'Top 25 Most Influential Money Managers', 'Kiplingers');

INSERT INTO Accolades
VALUES (10, 'Top 5 Most Capital Raised', 'Barrons');

INSERT INTO Accolades
VALUES (11, 'Top 25 Global Traders', 'Fortune');

INSERT INTO Accolades
VALUES (12, 'Top 20 Most Profitable Mergers Made', 'Worth');

SELECT *
FROM Accolades;

CREATE OR REPLACE FUNCTION Average_Rank (int) RETURNS int AS 
$$
DECLARE 

	AID int = $1;

BEGIN 
	RETURN AVG(Rank) 
	       FROM Awards
	       WHERE Awards.AID = $1;

END;
$$
LANGUAGE PLPGSQL;

-- Gives the average rank for the given employee who received an award more than once)

SELECT Average_Rank(4), Average_Rank(1)

-- CSA_Personnel to display what employees work as Client Service Associates -- 

DROP VIEW CSA_Personnel CASCADE;
CREATE VIEW CSA_Personnel AS
SELECT p.firstname, p.lastname, c.position, c.numberOfLanguagesSpoken, cellPhoneNumber, emailsSentInADay
FROM people p, Client_Service_Associates c
WHERE p.PID= c.CSAID;
SELECT *
FROM CSA_Personnel 

-- Honors to display what empoyee earned what award and how recent --

DROP VIEW Honors CASCADE;
CREATE VIEW Honors AS
SELECT p.firstname, p.lastname, l.name, a.rank, a.yearWon
FROM people p, Awards a, Accolades l 
WHERE p.PID = a.PID AND l.AID = a.AID;
SELECT *
FROM Honors 

