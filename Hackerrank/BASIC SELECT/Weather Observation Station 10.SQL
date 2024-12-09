--mysql  &  ms sql server
select distinct city from station where right(city , 1) not in  ("a","e","i","o","u") ;

--mysql
select distinct city from station where city regexp  ".*[^oiuea]$";

--mysql
select distinct city from station where city not regexp  ".*[oiuea]$";

--mysql
select distinct city from station where not regexp_like(city , "[aioue]$");

--mysql
select distinct city from station where regexp_like(city , "[^aioue]$");

--mysql
select distinct city from station where city rlike  ".*[^oiuea]$";

--mysql
select distinct city from station where city not rlike  ".*[oiuea]$";

--ms sql server
select distinct city from station where city like "%[^aeiou]";

--ms sql server
select distinct city from station where city not like "%[aeiou]";
