--MySQL  &  MS SQL SERVER
WITH CTE( dId , sl ) AS (
    SELECT departmentId , MAX(salary) 
    FROM Employee GROUP BY departmentId
)
SELECT 
D.name AS Department , E.name AS Employee , E.salary AS Salary
FROM   Employee E JOIN Department D
ON     E.departmentId = D.id 
WHERE   E.salary =  (SELECT sl FROM CTE  WHERE D.id = dId  );



--MySQL  &  MS SQL SERVER
WITH CTE(   msl , dn , sl , en ) AS (
    SELECT  MAX(salary) OVER(PARTITION BY D.id ) , D.name , salary , E.name 
    FROM Employee E
    JOIN Department D ON D.id = E.departmentId
)
SELECT  dn AS Department , en AS Employee , sl AS Salary
FROM CTE WHERE sl = msl;



--MySQL 
SELECT D.name AS Department , E.name AS Employee , Salary 
FROM Employee E JOIN Department D 
ON D.id = E.departmentId 
WHERE ( E.departmentId , Salary ) IN 
      ( SELECT departmentId , MAX(Salary) FROM Employee 
        GROUP BY departmentId );
