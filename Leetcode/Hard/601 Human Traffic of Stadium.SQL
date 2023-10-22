--MySQL  &  MS SQL SERVER
SELECT id , visit_date , people FROM (
    SELECT id ,visit_date ,people ,
    COUNT(*) OVER(PARTITION BY ind )  AS cnt 
--  COUNT(*) OVER(PARTITION BY ind ) >= 3 AS cnt --MySQL alternative
    FROM (    
        SELECT id ,visit_date ,people ,
        SUM(tf) OVER(ORDER BY id ASC) AS ind
        FROM (
            SELECT * , 
            CASE WHEN LAG(id) OVER(ORDER BY id ASC) = id - 1 
            THEN 0 ELSE 1 END AS tf 
            FROM (
                SELECT * FROM Stadium WHERE people >= 100
            ) AS T 
        ) AS T2
    ) AS T3  
) AS T4
WHERE cnt >= 3 
--WHERE cnt = 1  --MySQL alternative
ORDER BY visit_date ASC;



--MySQL  &  MS SQL SERVER
WITH CTE AS (
    SELECT id , visit_date , people ,
    CASE WHEN 
         LEAD(id)   OVER(ORDER BY id ) - 1 = id AND 
         LEAD(id,2) OVER(ORDER BY id ) - 2 = id
    OR   LEAD(id)   OVER(ORDER BY id ) - 1 = id AND 
         LAG(id)    OVER(ORDER BY id ) + 1 = id
    OR   LAG(id)    OVER(ORDER BY id ) + 1 = id AND
         LAG(id,2)  OVER(ORDER BY id ) + 2 = id
    THEN 1 ELSE NULL END AS tf 
    FROM (SELECT * FROM Stadium WHERE people >= 100 ) AS T
)
SELECT id , visit_date , people 
FROM CTE 
WHERE tf IS NOT NULL 
ORDER BY id ASC;
