--MySQL  &  MS SQL SERVER
SELECT MAX( salary ) AS SecondHighestSalary  FROM Employee 
WHERE ( SELECT MAX( salary ) FROM Employee ) != salary ;



--MySQL  &  MS SQL SERVER
SELECT MAX( salary ) AS SecondHighestSalary
FROM (  SELECT salary , DENSE_RANK() OVER(ORDER BY salary DESC) AS ind
        FROM Employee 
     ) AS T 
WHERE ind = 2;



--MySQL
SELECT CASE WHEN COUNT(*) = 0 THEN NULL ELSE salary END AS SecondHighestSalary
FROM (  SELECT salary , DENSE_RANK() OVER(ORDER BY salary DESC) AS ind
        FROM Employee 
     ) AS T 
WHERE ind = 2;



--MySQL
SELECT
    (SELECT DISTINCT Salary 
    FROM Employee ORDER BY salary DESC 
    LIMIT 1 OFFSET 1 )  
AS SecondHighestSalary;



--MS SQL SERVER
SELECT ISNULL( 
    (SELECT  salary 
    FROM (
        SELECT  salary , DENSE_RANK() OVER(ORDER BY salary DESC) AS ind
        FROM Employee 
         ) AS T 
    WHERE ind = 2
    GROUP BY salary ) 
, NULL ) AS SecondHighestSalary;



--MS SQL SERVER
SELECT
   (SELECT DISTINCT Salary 
    FROM Employee ORDER BY salary DESC 
    OFFSET 1 ROW FETCH NEXT 1 ROW ONLY)  
AS SecondHighestSalary;
