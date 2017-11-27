----------------------------------------------------------------------------------------
-- Courses and Prerequisites
-- by Alan G. Labouseur
-- Tested on Postgres 9.3.2

-- Dietrich Mosel --
--Professor Labouseur -- 
-- Database Management --
-- November 27th 2017 -- 

-- LAB 10 --
----------------------------------------------------------------------------------------
drop table if exists Prerequisites;
drop table if exists Courses;


--
-- The table of courses.
--
create table Courses (
    num      integer not null,
    name     text    not null,
    credits  integer not null,
  primary key (num)
);


insert into Courses(num, name, credits)
values (499, 'CS/ITS Capping', 3 );

insert into Courses(num, name, credits)
values (308, 'Database Systems', 4 );

insert into Courses(num, name, credits)
values (221, 'Software Development Two', 4 );

insert into Courses(num, name, credits)
values (220, 'Software Development One', 4 );

insert into Courses(num, name, credits)
values (120, 'Introduction to Programming', 4);

select * 
from courses
order by num ASC;


--
-- Courses and their prerequisites
--
create table Prerequisites (
    courseNum integer not null references Courses(num),
    preReqNum integer not null references Courses(num),
  primary key (courseNum, preReqNum)
);

insert into Prerequisites(courseNum, preReqNum)
values (499, 308);

insert into Prerequisites(courseNum, preReqNum)
values (499, 221);

insert into Prerequisites(courseNum, preReqNum)
values (308, 120);

insert into Prerequisites(courseNum, preReqNum)
values (221, 220);

insert into Prerequisites(courseNum, preReqNum)
values (220, 120);

select *
from Prerequisites
order by courseNum DESC;

-- 1 -----------------------------------------------

create or replace function PreReqsFor (int, REFCURSOR) returns refcursor as 
$$
declare
   courseNumber int   := $1;
   output   REFCURSOR := $2;
begin
   open output for 
	SELECT preReqNum
	FROM Prerequisites
	WHERE courseNum = courseNumber;
   return output;
end;
$$ 
language plpgsql;

select PreReqsFor(220, 'res1');
Fetch all from res1;

-- 2 -----------------------------------------------

create or replace function IsPreReqFor (int, REFCURSOR) returns refcursor as 
$$
declare
   courseNumber int   := $1;
   output   REFCURSOR := $2;
begin
   open output for 
	SELECT courseNum
	FROM Prerequisites
	WHERE preReqNum = courseNumber;
   return output;
end;
$$ 
language plpgsql;


select IsPreReqFor(120, 'res2');
Fetch all from res2;


