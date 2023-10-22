--MySQL  &  MS SQL Server
SELECT CONCAT( name ,"(", UPPER( LEFT(occupation , 1 ) ) , ")" ) FROM OCCUPATIONS ORDER BY name;
SELECT CONCAT("There are a total of " , COUNT(*) ," " ,  LOWER(occupation) , "s." )
FROM OCCUPATIONS GROUP BY occupation
ORDER BY COUNT(*) ASC , occupation;



--MySQL  &  MS SQL Server
SELECT CONCAT( name ,"(", UPPER( SUBSTRING(occupation,1,1) ) , ")" ) FROM OCCUPATIONS ORDER BY name;
SELECT CONCAT("There are a total of " , COUNT(*) ," " ,  LOWER(occupation) , "s." )
FROM OCCUPATIONS GROUP BY occupation
ORDER BY COUNT(*) ASC , occupation;



--MySQL
SELECT CONCAT( name ,"(", UPPER( SUBSTR(occupation,1,1) ) , ")" ) FROM OCCUPATIONS ORDER BY name;
SELECT CONCAT("There are a total of " , COUNT(*) ," " ,  LOWER(occupation) , "s." )
FROM OCCUPATIONS GROUP BY occupation
ORDER BY COUNT(*) ASC , occupation;
