--MySQL  &  MS SQL Serve
SELECT (SELECT id FROM WANDS WHERE code = T.code AND T.power = power AND coins_needed = min_c) , 
age , min_c , power FROM 
(SELECT W.code , power , age , MIN(coins_needed) AS min_c FROM WANDS AS W JOIN WANDS_PROPERTY AS Wp
 ON W.code = Wp.code WHERE is_evil = 0
 GROUP BY  W.code , power , age) AS T
ORDER BY power DESC , age DESC;



--MySQL  &  MS SQL Server
SELECT id , T.age , T.min_c , T.power FROM 
    (SELECT W.code , power , age , MIN(coins_needed) AS min_c FROM WANDS AS W JOIN WANDS_PROPERTY AS Wp
    ON W.code = Wp.code WHERE is_evil = 0
    GROUP BY  W.code , power , age) AS T 
JOIN WANDS AS W ON T.code = W.code AND W.coins_needed = min_c AND W.power = T.power
ORDER BY power DESC , age DESC;



--MySQL  &  MS SQL Server 
SELECT (SELECT id FROM WANDS W2 JOIN WANDS_PROPERTY Wp2  ON W2.code = Wp2.code 
        WHERE Wp.age = Wp2.age AND W.power = W2.power AND  coins_needed = MIN(W.coins_needed)
        AND is_evil = 0 ) , 
age , MIN(coins_needed) AS min_c , power 
FROM WANDS AS W JOIN WANDS_PROPERTY AS Wp ON W.code = Wp.code 
WHERE is_evil = 0
GROUP BY power , age 
ORDER BY power DESC , age DESC;



--MySQL  &  MS SQL Server 
SELECT id , age , coins_needed , power 
FROM WANDS AS W JOIN WANDS_PROPERTY AS Wp ON W.code = Wp.code 
WHERE is_evil = 0 
AND coins_needed = (SELECT MIN(coins_needed) FROM WANDS AS W2 JOIN WANDS_PROPERTY AS Wp2 ON W2.code = Wp2.code
                    WHERE Wp2.age = Wp.age AND W.power = W2.power )
ORDER BY power DESC , age DESC;



--MS SQL Server
SELECT id , age ,coins_needed , power FROM (
    SELECT id , power , age , coins_needed ,
    ROW_NUMBER() OVER(PARTITION BY power , age ORDER BY coins_needed ASC ) AS coun 
    FROM WANDS AS W JOIN WANDS_PROPERTY AS Wp ON W.code = Wp.code WHERE is_evil = 0 ) AS T
WHERE coun = 1 
ORDER BY power DESC , age DESC;



--MS SQL Server
SELECT id , age ,coins_needed , power FROM (
    SELECT id , power , age , coins_needed ,
    MIN(coins_needed) OVER(PARTITION BY power , age ) AS min_c
    FROM WANDS AS W JOIN WANDS_PROPERTY AS Wp ON W.code = Wp.code WHERE is_evil = 0 ) AS T
WHERE min_c = coins_needed
ORDER BY power DESC , age DESC;
