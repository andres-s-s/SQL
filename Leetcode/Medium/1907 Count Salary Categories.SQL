--MySQL  &  MS SQL SERVER
WITH CTE AS (
    SELECT CASE 
    WHEN income < 20000 THEN 'Low Salary' 
    WHEN income > 50000 THEN 'High Salary'
    ELSE 'Average Salary' 
    END AS category 
    FROM Accounts 
    UNION ALL 
    SELECT 'Low Salary' AS category 
    UNION ALL 
    SELECT 'Average Salary' AS category 
    UNION ALL 
    SELECT 'High Salary' AS category  
)
SELECT category , COUNT(*) - 1 AS accounts_count 
FROM CTE GROUP BY category;



--MySQL  &  MS SQL SERVER
SELECT 'Low Salary' AS category ,  
    (SELECT COUNT(*) 
    FROM Accounts 
    WHERE income < 20000 ) AS accounts_count 
 
UNION ALL 

SELECT 'Average Salary' AS category ,  
    (SELECT COUNT(*) 
    FROM Accounts 
    WHERE income >= 20000 AND income <= 50000 ) AS accounts_count
 
UNION ALL 

SELECT 'High Salary' AS category ,  
    (SELECT COUNT(*) 
    FROM Accounts 
    WHERE income > 50000 ) AS accounts_count 
  ;



--MySQL  &  MS SQL SERVER
WITH 
CTE  AS (
    SELECT 'Low Salary' AS category 
    UNION ALL 
    SELECT 'Average Salary' AS category 
    UNION ALL 
    SELECT 'High Salary' AS category  ) , 
CTE2 AS (
    SELECT CASE 
    WHEN income < 20000 THEN 'Low Salary' 
    WHEN income > 50000 THEN 'High Salary'
    ELSE 'Average Salary' 
    END AS category 
    FROM Accounts )

SELECT C.category , COALESCE( COUNT(C2.category) , 0 ) AS accounts_count
FROM CTE C
LEFT JOIN CTE2 C2
ON C.category = C2.category 
GROUP BY C.category;
