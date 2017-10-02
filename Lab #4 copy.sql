-- Dietrich Mosel -- 
-- Professor Labouseur --
-- Database Systems --
-- October 2, 2017 --

-- #1 -- 
SELECT city
FROM agents
WHERE aid in (SELECT aid
	      FROM orders
	      WHERE cid = 'c006');

-- #2 --
SELECT DISTINCT pid
FROM orders
WHERE cid in (SELECT cid
	      FROM customers 
	      WHERE city = 'Beijing')
ORDER BY pid DESC;

-- #3 -- 
SELECT cid, name
FROM customers 
WHERE cid NOT IN (SELECT cid
	          FROM orders 
	          WHERE aid = 'a03');

-- #4 -- 
SELECT DISTINCT o1.cid
FROM orders o1, orders o2
WHERE o1.pid = 'p01'
AND o2.pid = 'p07'
AND o1.cid = o2.cid;

-- #5 -- 
SELECT DISTINCT pid
FROM products
WHERE pid NOT IN (SELECT pid 
		  FROM orders
		  WHERE aid = 'a02' 
		  OR aid = 'a03')
ORDER BY pid DESC;

-- #6 -- 
SELECT name, discountPct, city
FROM customers 
WHERE cid in (SELECT cid
	      FROM orders
	      WHERE aid in (SELECT aid
			    FROM agents
			    WHERE city = 'Tokyo' 
			    OR city = 'New York')
	      );

-- #7 --
SELECT name 
FROM customers
WHERE city NOT IN ('Duluth', 'London')
AND discountPct in (SELECT discountPct 
		    FROM customers
		    WHERE city in ('Duluth', 'London')
		    );

-- Check constraints are used to limit a range for values that can be --
-- imposed upon a column. When you define a check constraint on one column, -- 
-- it will return values that fit the specific requirements. For example, in a --
-- table of people, you can impose age restrictions so people under the age of --
-- 18 would not be included. Each check constraint has to be defined in the create --
-- table or alter table when using the syntax. Check constraints are useful in --
-- asking for specific data and sorting out useless information. You can insert --
-- certain requirements that, when new data is added, will abide by the check constraint. --
-- A good check constraint could be imposed on a table with employees and salaries where --
-- the salary value is greater than 0. This would force the program to make sure everyone --
-- gets paid. On the other hand, a bad example of a check constraint would be limiting the --
-- names of people who have checking accounts to values between 0 and 500. This is bad --
-- because more people could open checking accounts, in which case you would lose out --
-- on potential business because customers would not be accounted for. Check constraints --
-- are useful in limiting data and creating uniqueness but can also limit or restrict you --
-- or business in a negative way as well. --






