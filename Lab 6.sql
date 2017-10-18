-- Dietrich Mosel -- 
-- Professor Labouseur --
-- Database Management -- 
-- October 16th, 2017 --

-- 1 --
SELECT name, city
FROM customers
WHERE city IN (SELECT city
	       FROM products
	       GROUP BY city
	       ORDER BY count (*) DESC
	       Limit 1
	       );

-- 2 --
SELECT name
FROM products
WHERE priceUSD >= (SELECT avg(priceUSD)
		   FROM products)
ORDER BY name DESC;

-- 3 --
SELECT c.name, o.pid, o.totalUSD
FROM customers c INNER JOIN orders o ON c.cid = o.cid
ORDER BY o.totalUSD ASC;

-- 4 --
SELECT c.name, COALESCE (SUM(totalUSD), 0)
FROM orders o, customers c
WHERE c.cid = o.cid
GROUP BY c.name
ORDER BY name DESC;

-- 5 -- 
SELECT c.name, a.name, p.name
FROM customers c, agents a, products p, orders o
WHERE c.cid = o.cid
AND a.aid = o.aid
AND a.city = 'Newark';

-- 6 --
SELECT o.totalUSD, SUM(totalUSD * quantity)
FROM orders o
GROUP BY o.totalUSD;

-- 7 --
-- The difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN is that
-- a LEFT OUTER JOIN returns everything from the left table and corresponding 
-- matching rows from the right table. A RIGHT OUTER JOIN does the opposite 
-- in that it returns everything from the right table and corresponding matching
-- rows from the left table. Examples will follow below...

-- Examples -- 

-- Left Outer Join -- 
SELECT *
FROM customers c LEFT OUTER JOIN agents a ON c.city = a.city
ORDER BY c.city DESC;

-- We can see that this left outer join takes everything from the customers 
-- table and only selects those aid, name, city and commission columns
-- from agents that match

-- Right Outer Join --
SELECT *
FROM customers c RIGHT OUTER JOIN agents a ON c.city = a.city
ORDER BY c.city DESC;

-- In this example, we see that the right outer join returns everything 
-- in the agents table while at the same time, only yielding cid, name, city
-- and discountPct that match

