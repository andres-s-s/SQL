--MySQL
SELECT id , COUNT(*) AS num
FROM (
    SELECT accepter_id  AS id FROM requestaccepted
    UNION ALL
    SELECT requester_id AS id FROM requestaccepted
) AS T 
GROUP BY id ORDER BY COUNT(*) DESC LIMIT 1 ;



--MySQL
WITH 
CTE  AS (SELECT requester_id AS id , COUNT(*) AS cnt
        FROM RequestAccepted GROUP BY requester_id ) , 
CTE2 AS (SELECT accepter_id  AS id , COUNT(*) AS cnt
         FROM RequestAccepted GROUP BY accepter_id )

SELECT id , num FROM (
    SELECT id , SUM( cnt ) AS num FROM (
        SELECT id , cnt   FROM CTE  UNION ALL 
        SELECT id , cnt   FROM CTE2 
    ) AS T
    GROUP BY id
) AS T2 
ORDER BY num DESC LIMIT 1 ;



---MS SQL SERVER
SELECT TOP 1 id , COUNT(*) AS num
FROM (
    SELECT accepter_id  AS id FROM requestaccepted
    UNION ALL
    SELECT requester_id AS id FROM requestaccepted
) AS T 
GROUP BY id ORDER BY COUNT(*) DESC;



---MS SQL SERVER
WITH 
CTE  AS (SELECT requester_id AS id , COUNT(*) AS cnt
        FROM RequestAccepted GROUP BY requester_id ) , 
CTE2 AS (SELECT accepter_id  AS id , COUNT(*) AS cnt
         FROM RequestAccepted GROUP BY accepter_id )

SELECT TOP 1 id , num FROM (
    SELECT id , SUM( cnt ) AS num FROM (
        SELECT id , cnt   FROM CTE  UNION ALL 
        SELECT id , cnt   FROM CTE2 
    ) AS T
    GROUP BY id
) AS T2 
ORDER BY num DESC ;
