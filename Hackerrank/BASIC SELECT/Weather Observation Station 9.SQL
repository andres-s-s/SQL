--mysql  &  ms sql server
select distinct city from station where left(city , "1") not in ("a","e","i","o","u");

--mysql
select distinct city from station where city not rlike  "^[aeiou]";

--mysql
select distinct city from station where city rlike  "^[^aeiou]";

--mysql
select distinct city from station where regexp_like(city , "^[^aioue]");

--ms sql server
select distinct city from station where city not like "[aeiou]%";

--ms sql server
select distinct city from station where city like "[^aeiou]%";
