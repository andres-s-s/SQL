--MySQL
SELECT 
ROUND(
COUNT( player_id)/(SELECT COUNT(DISTINCT player_id) AS tamnt FROM Activity) 
, 2 ) AS fraction
FROM (
    SELECT player_id FROM (
        SELECT player_id , event_date FROM (
            SELECT player_id , event_date , 
            ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date ASC ) AS ind
            FROM Activity
        ) AS T 
        WHERE ind IN (1 , 2 )
    ) AS T2 
    GROUP BY player_id 
    HAVING DATEDIFF( MAX(event_date) , MIN(event_date) ) =  2 - 1
) AS T3 ;



--MySQL
SELECT ROUND( COUNT( player_id )/( SELECT COUNT(DISTINCT player_id ) FROM Activity) , 2 )
AS fraction
FROM (
    SELECT T.player_id  FROM (
        SELECT player_id , MIN(event_date) AS event_date
        FROM Activity GROUP BY player_id
    ) AS T 
    JOIN Activity A 
    ON   A.player_id = T.player_id 
    AND  ADDDATE(T.event_date, INTERVAL 1 DAY) = A.event_date
) AS T2;



--MySQL
SELECT ROUND( SUM( tf )/COUNT(DISTINCT player_id) , 2 )
AS fraction
FROM (
    SELECT player_id , ind = 2 AND DATEDIFF(event_date , MIN(event_date) OVER(PARTITION BY player_id)) = 2 - 1 AS tf
    FROM (
        SELECT player_id , event_date , 
        ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date ASC ) AS ind
        FROM Activity
    ) AS T 
    WHERE ind = 1 OR ind = 2 
) AS T2;



---MySQL
SELECT ROUND(  COUNT( A2.player_id ) / COUNT( A1.player_id ) , 2 ) AS fraction
FROM Activity A1
LEFT JOIN Activity A2 
ON  A1.player_id =  A2.player_id 
AND ADDDATE(A1.event_date, INTERVAL  1 DAY) = A2.event_date
WHERE (A1.event_date , A1.player_id ) IN 
(SELECT MIN(event_date) , player_id  FROM Activity GROUP BY player_id);



--MS SQL SERVER
SELECT 
ROUND(
COUNT( player_id)/CAST( (SELECT COUNT(DISTINCT player_id) AS tamnt FROM Activity) AS FLOAT)
, 2 ) AS fraction
FROM (
    SELECT player_id FROM (
        SELECT player_id , event_date FROM (
            SELECT player_id , event_date , 
            ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date ASC ) AS ind
            FROM Activity
        ) AS T 
        WHERE ind = 1 OR ind = 2 
    ) AS T2 
    GROUP BY player_id 
    HAVING DATEDIFF(DD , MIN(event_date) , MAX(event_date)  ) = 2 - 1
) AS T3 ;



--MS SQL SERVER
SELECT ROUND( COUNT( player_id )/CAST( (SELECT COUNT(DISTINCT player_id ) FROM Activity) AS FLOAT) , 2 )
AS fraction
FROM (
    SELECT T.player_id  FROM (
        SELECT player_id , MIN(event_date) AS event_date
        FROM Activity GROUP BY player_id
    ) AS T 
    JOIN Activity A 
    ON   A.player_id = T.player_id 
    AND  DATEADD(DAY , 1 , T.event_date ) = A.event_date 
) AS T2;



--MS SQL SERVER 
SELECT ROUND( SUM( tf )/CAST((SELECT COUNT(DISTINCT player_id) AS tamnt FROM Activity) AS FLOAT), 2 )
AS fraction
FROM (
    SELECT player_id , CASE WHEN ind = 2 AND DATEDIFF(DD ,  MIN(event_date) OVER(PARTITION BY player_id)  , event_date) = 2 - 1  
    THEN 1 ELSE 0 END AS tf
    FROM (
        SELECT player_id , event_date , 
        ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date ASC ) AS ind
        FROM Activity
    ) AS T 
    WHERE ind = 1 OR ind = 2 
    
) AS T2;



--MS SQL SERVER
WITH CTE AS (SELECT MIN(event_date) AS md , player_id FROM Activity GROUP BY player_id)

SELECT ROUND(  COUNT( A2.player_id ) / CAST( COUNT( A1.player_id ) AS FLOAT ), 2 ) AS fraction
FROM Activity A1
LEFT JOIN Activity A2 
ON  A1.player_id =  A2.player_id 
AND DATEADD(DAY , 1 , A1.event_date ) = A2.event_date
WHERE EXISTS(SELECT * FROM CTE WHERE A1.event_date = md AND A1.player_id = player_id );
