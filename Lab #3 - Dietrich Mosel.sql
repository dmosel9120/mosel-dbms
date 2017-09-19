-- Dietrich Mosel -- 
-- Lab #3 --
-- Professor Labouseur -- 
-- September 18th 2017 --

-- #1 -- 
select ordno, totalusd
from orders;

-- #2 --
select name, city
from agents
where name = 'Smith';

-- #3 -- 
select pid, name, priceusd
from products
where qty > 200010;

-- #4 --
select name, city
from customers
where city = 'Duluth';

-- #5 --
select name 
from agents
where city not in ('New York', 'Duluth');

-- #6 --
select *
from products
where city not in ('Dallas','Duluth')
And priceusd >= 1.00;

-- #7 -- 
select *
from orders
where month = 'Mar'
or month = 'May';

-- #8 -- 
select *
from orders 
where month = 'Feb' 
And totalusd >= 500.00;

-- #9 -- 
select *
from orders
where cid = 'c005';
