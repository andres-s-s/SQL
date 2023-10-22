--MySQL  &  MS SQL Server
SELECT DISTINCT city FROM STATION WHERE RIGHT(city,1) NOT IN  ("a","e","i","o","u") OR LEFT(city , 1) NOT IN  ("a","e","i","o","u");

--MySQL
SELECT DISTINCT city FROM STATION WHERE city RLIKE "^[^oiuea].*" OR city REGEXP  ".*[^oiuea]$";

--MySQL
SELECT DISTINCT city FROM STATION WHERE city NOT RLIKE "^[oiuea].*" OR city NOT REGEXP  ".*[oiuea]$";

--MS SQL Server
SELECT DISTINCT city FROM STATION WHERE city NOT LIKE "[aeiou]%" OR city NOT LIKE "%[aeiou]";

--MS SQL Server
SELECT DISTINCT city FROM STATION WHERE city LIKE "[^aeiou]%" OR city LIKE "%[^aeiou]";
