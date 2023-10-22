--MySQL  &  MS SQL Server
SELECT DISTINCT city FROM STATION WHERE RIGHT(city,1) NOT IN  ("a","e","i","o","u") AND LEFT(city , 1) NOT IN  ("a","e","i","o","u");

--MySQL
SELECT DISTINCT city FROM STATION WHERE city RLIKE "^[^oiuea].*" AND city REGEXP  ".*[^oiuea]$";

--MySQL
SELECT DISTINCT city FROM STATION WHERE city NOT RLIKE "^[oiuea].*" AND city NOT REGEXP  ".*[oiuea]$";

--MySQL
SELECT DISTINCT city FROM STATION WHERE REGEXP_LIKE(city , "^[^oiuea].*[^oiuea]$" );

--MS SQL Server
SELECT DISTINCT city FROM STATION WHERE city NOT LIKE "[aeiou]%" AND city NOT LIKE "%[aeiou]";

--MS SQL Server
SELECT DISTINCT city FROM STATION WHERE city LIKE "[^aeiou]%" AND city LIKE "%[^aeiou]";

--MS SQL Server
SELECT DISTINCT city FROM STATION WHERE city LIKE "[^aeiou]%[^aeiou]";
