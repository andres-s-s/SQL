--MySQL  &  MS SQL SERVER
SELECT DISTINCT FIRST_VALUE(person_name) OVER(ORDER BY wght DESC )
AS person_name
FROM (
    SELECT person_name , SUM(weight) OVER(ORDER BY turn ASC)  AS wght 
    FROM Queue
) AS T
WHERE wght <= 1000;



--MySQL  
SELECT person_name
FROM (
    SELECT person_name , SUM(weight) OVER(ORDER BY turn ASC)  AS wght 
    FROM Queue
) AS T
WHERE wght <= 1000
ORDER BY wght DESC LIMIT 1 ;



--MS SQL SERVER
SELECT TOP 1 person_name
FROM (
    SELECT person_name , SUM(weight) OVER(ORDER BY turn ASC)  AS wght 
    FROM Queue
) AS T
WHERE wght <= 1000
ORDER BY wght DESC;



--MySQL  
SELECT   Q1.person_name 
FROM     Queue Q1 JOIN Queue Q2 
ON       Q1.turn >= Q2.turn 
GROUP BY Q1.person_name 
HAVING   SUM( Q2.weight ) <= 1000
ORDER BY SUM( Q2.weight ) DESC 
LIMIT 1 ;



--MS SQL SERVER
SELECT   TOP 1 Q1.person_name 
FROM     Queue Q1 JOIN Queue Q2 
ON       Q1.turn >= Q2.turn 
GROUP BY Q1.person_name 
HAVING   SUM( Q2.weight ) <= 1000
ORDER BY SUM( Q2.weight ) DESC ;
