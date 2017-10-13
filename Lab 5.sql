-- Dietrich Mosel --
-- Professor Labouseur -- 
-- Database Management -- 
-- October 9th 2017 -- 

-- 1 --
SELECT DISTINCT c.city
FROM customers c INNER JOIN orders o ON c.cid=o.cid
WHERE c.cid = 'c006';

-- 2 -- 
SELECT DISTINCT o1.pid
FROM orders o1 INNER JOIN customers c ON c.cid=o1.cid
	       INNER JOIN orders o2 ON o1.aid=o2.aid
WHERE c.city = 'Beijing'
ORDER BY o1.pid ASC 

-- 3 --
SELECT name
FROM customers
WHERE cid NOT IN (SELECT DISTINCT cid
	          FROM orders
	          ); 

-- 4 --
SELECT c.name
FROM customers c LEFT OUTER JOIN orders o ON c.cid=o.cid
WHERE o.cid IS NULL;

-- 5 --
SELECT DISTINCT c.name, a.name
FROM customers c, orders o, agents a
WHERE c.cid = o.cid
AND o.aid = a.aid
AND c.city = a.city
 
-- 6 --
SELECT c.name, a.name, c.city
FROM customers c, agents a
WHERE c.city = a.city

-- 7 -- 
SELECT name, city
FROM customers
WHERE city in (SELECT city
	       FROM products 
	       GROUP BY city
	       ORDER BY count (*) ASC
	        Limit 1
	       ); 




