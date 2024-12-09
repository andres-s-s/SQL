--mysql  &  ms sql server
select distinct city from station where right(city,1) not in  ("a","e","i","o","u") and left(city , 1) not in  ("a","e","i","o","u");

--mysql
select distinct city from station where city rlike "^[^oiuea].*" and city regexp  ".*[^oiuea]$";

--mysql
select distinct city from station where city not rlike "^[oiuea].*" and city not regexp  ".*[oiuea]$";

--mysql
select distinct city from station where regexp_like(city , "^[^oiuea].*[^oiuea]$" );

--ms sql server
select distinct city from station where city not like "[aeiou]%" and city not like "%[aeiou]";

--ms sql server
select distinct city from station where city like "[^aeiou]%" and city like "%[^aeiou]";

--ms sql server
select distinct city from station where city like "[^aeiou]%[^aeiou]";
