-- In City, select all cities in the USA with a population of greater than 100,000
select * from city where countrycode = 'USA' and population > 100000;

-- In Station, query cities and states
select city, state from station;

-- In Station, select only city names with even id numbers
select distinct city from station where mod(id, 2) = 0;

-- In Station, find the difference between total cities and unique cities
select count (city) - count (distinct city) from station; 

-- In Station, select the longest and shortest city names and their char lengths.
-- If there is more than one result, print the first first result after sorting
--alphabetically.
select * 
from (
    select city, length(city) 
    from station
    where length(city) = (select max(length(city)) from station)
	order by city)
where rownum = 1;

select * 
from (
    select city, length(city)
    from station
    where length(city) = (select min(length(city)) from station)
    order by city)
where rownum = 1 ;

-- In Station, select unique city names that start with vowels
select distinct city from station where regexp_like(city,'^(A|E|I|O|U)');

-- In Station, select unique city names that start and end with vowels
select distinct city from station where regexp_like(city,'^(A|E|I|O|U)') 
and regexp_like(city,'(a|e|i|o|u)$');

-- In Station, select unique city names that don't either start or end with vowels
select distinct city from station where not regexp_like(city,'^(A|E|I|O|U)') 
or not regexp_like(city,'(a|e|i|o|u)$');

-- From Students, select students who received greater than 75 marks. Order 
-- by the last three characters of their name, then by id ascending.
select name
from students
where marks > 75
order by substr(name, -3), id asc;

-- From employee, select names of employees who have been employed less than 10
-- months and make over 2000 dollars per month. Order the selection by 
-- employee_id ascending.
select name from employee
where months < 10 and
salary > 2000
order by employee_id asc;

-- From employees, select the difference between average salaries and 
-- average salaries with all zeroes removed.
select ceil(avg(salary) - avg(replace(salary, 0))) from employees;

-- Find total earnings (salary * months) and query the top earnings along with
-- the number of employees with top earnings.
select * from (
select (salary * months) as earnings, count(*) 
from employee group by (salary * months) 
order by earnings desc) 
where rownum = 1;

-- Select the sum of all lat and the sum of all long coordinated from station,
-- both rounded to two decimal places.
select round((sum(lat_n)), 2), round((sum(long_w)), 2) from station;

-- Select corresponding longitude for the max latitude less than 137.2345. 
-- Round longitude to 4 decimal places.
select round(long_w, 4) from station where lat_n = (
    select max(lat_n) 
    from station 
    where lat_n < 137.2345);
