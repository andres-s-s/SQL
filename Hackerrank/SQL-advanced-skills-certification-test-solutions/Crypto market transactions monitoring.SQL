--MySQL 
SELECT sender , MIN(dt) , MAX(dt) , COUNT(*) , SUM(amount) FROM (
    SELECT sender , dt , amount , SUM(tf) OVER(ORDER BY sender , dt ASC ) AS st FROM (
        SELECT sender , dt , amount ,
            CASE WHEN 
            TIMESTAMPDIFF( HOUR , LAG(dt) OVER(ORDER BY sender , dt ASC ) , dt ) <= UNIX_TIMESTAMP('0000-00-00 00:01:00')
            AND LAG(sender) OVER(ORDER BY sender , dt ASC ) = sender 
            THEN 0 ELSE 1 END AS tf
            FROM TRANSACTIONS
        ) AS T
    ) T2
GROUP BY st , sender
HAVING SUM(amount) >= 150 AND COUNT(*) > 1
ORDER BY sender , MIN(dt) , MAX(dt)



--MS SQL SERVER
SELECT sender , MIN(dt) , MAX(dt) , COUNT(*) , SUM(amount) FROM (
    SELECT sender , dt , amount , SUM(tf) OVER(ORDER BY sender , dt ASC ) AS st FROM (
        SELECT sender , dt , amount ,
            CASE WHEN 
            DATEDIFF( second, LAG(dt) OVER(ORDER BY sender , dt ASC ) , dt ) <= 3600
            AND LAG(sender) OVER(ORDER BY sender , dt ASC ) = sender 
            THEN 0 ELSE 1 END AS tf
            FROM TRANSACTIONS
        ) AS T
    ) T2
GROUP BY st , sender
HAVING SUM(amount) >= 150 AND COUNT(*) > 1
ORDER BY sender , MIN(dt) , MAX(dt);

