--MySQL  &  MS SQL Server
SELECT DISTINCT city FROM STATION WHERE LEFT(city , 1 ) IN ("a","e","i","o","u");

--MySQL
SELECT DISTINCT city FROM STATION WHERE city RLIKE "^[aeiou]";

--MS SQL Server
SELECT DISTINCT city FROM STATION WHERE city LIKE '[uoiea]%';
