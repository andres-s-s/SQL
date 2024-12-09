--mysql  &  ms sql server
select distinct city from station where right(city,1) not in  ("a","e","i","o","u") or left(city , 1) not in  ("a","e","i","o","u");

--mysql
select distinct city from station where city rlike "^[^oiuea].*" or city regexp  ".*[^oiuea]$";

--mysql
select distinct city from station where city not rlike "^[oiuea].*" or city not regexp  ".*[oiuea]$";

--ms sql server
select distinct city from station where city not like "[aeiou]%" or city not like "%[aeiou]";

--ms sql server
select distinct city from station where city like "[^aeiou]%" or city like "%[^aeiou]";
