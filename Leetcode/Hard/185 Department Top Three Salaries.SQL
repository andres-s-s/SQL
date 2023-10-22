--MySQL  &  MS SQL SERVER
WITH CTE AS (
  SELECT * ,
  DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC ) AS ind
  FROM Employee
)
SELECT D.name AS Department , C.name AS Employee , C.Salary
FROM  CTE AS C 
JOIN  Department D 
ON    ind BETWEEN 1 AND 3
AND   C.departmentId = D.id  ;



--MySQL  &  MS SQL SERVER
SELECT D.name AS Department , 
E.name AS Employee , 
E.Salary 
FROM Employee   E
JOIN Department D
ON E.departmentId = D.id
WHERE 3 > (SELECT COUNT(DISTINCT Salary) 
           FROM Employee WHERE D.id = departmentId 
           AND Salary > E.Salary );
