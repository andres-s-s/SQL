--MySQL  &  MS SQL Server
SELECT DISTINCT city FROM STATION WHERE RIGHT(city , 1) IN  ("a","e","i","o","u") AND LEFT(city , 1) IN  ("a","e","i","o","u");

--MySQL
SELECT DISTINCT city FROM STATION WHERE city RLIKE "^[aeiou].*[aeiou]$";

--MS SQL Server
SELECT DISTINCT city FROM STATION WHERE city LIKE "[aeiou]%[aeiou]";
