--MySQL  &  MS SQL SERVER
SELECT DISTINCT num AS ConsecutiveNums FROM (
    SELECT num , SUM(tf) OVER(ORDER BY id ASC ) AS  ind 
    FROM (
        SELECT num , id ,
        CASE WHEN LAG(num) OVER(ORDER BY id ASC) = num THEN 0 ELSE 1 END AS tf
        FROM Logs
    ) AS T
) AS T2 
GROUP BY num , ind
HAVING COUNT(*) >= 3 ;



--MySQL  &  MS SQL SERVER
SELECT DISTINCT L.num AS  ConsecutiveNums FROM Logs L 
JOIN Logs L2 ON L.id = L2.id + /*-*/ 1 AND L.num = L2.num 
JOIN Logs L3 ON L.id = L3.id + /*-*/ 2 AND L.num = L3.num ;  



--MySQL  &  MS SQL SERVER
SELECT DISTINCT L.num AS  ConsecutiveNums FROM Logs L 
JOIN Logs L2 ON  L.id = L2.id - /*+*/ 1 AND L.num = L2.num 
JOIN Logs L3 ON L2.id = L3.id - /*+*/ 1 AND L2.num = L3.num ;  



--MySQL  &  MS SQL SERVER
WITH numbers(n2 , n1 , n) AS (
    SELECT 
    /*LAG*/LEAD( num , 2)  OVER(ORDER BY id ASC) ,
    /*LAG*/LEAD( num )     OVER(ORDER BY id ASC) ,
    num 
    FROM Logs
)
SELECT DISTINCT n ConsecutiveNums FROM numbers WHERE n=n1 AND n=n2



--MySQL  &  MS SQL SERVER
SELECT DISTINCT num AS ConsecutiveNums FROM Logs L
WHERE  ( id + 1 , num ) IN (SELECT id , num FROM Logs )       AND
EXISTS (SELECT * FROM Logs WHERE num = L.num AND id = L.id - 1  )  
