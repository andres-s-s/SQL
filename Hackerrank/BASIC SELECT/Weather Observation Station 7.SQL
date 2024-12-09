--mysql  &  ms sql server
select distinct city from station where right(city , 1) in  ("a","e","i","o","u");

--mysql
select distinct city from station where city rlike  "^.*[aeiou]$";

--ms sql server
select distinct city from station where city like '%[aeiou]';
