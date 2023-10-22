--MySQL  &  MS SQL SERVER
SELECT user_id , 
ROUND(
COUNT(CASE WHEN action = 'confirmed' THEN 1 ELSE NULL END )/ 
CAST( COUNT(*) AS FLOAT ) , 2 ) AS confirmation_rate
FROM Confirmations
GROUP BY user_id 
UNION ALL
SELECT user_id , 00.00 AS confirmation_rate 
FROM Signups WHERE user_id NOT IN 
    (SELECT DISTINCT user_id FROM Confirmations);



--MySQL  &  MS SQL SERVER
SELECT S.user_id , 
COALESCE(
  ROUND(
  COUNT(CASE WHEN C.action = 'confirmed' THEN 1 ELSE NULL END )/ 
  CAST( COUNT(C.action) AS FLOAT ) , 2 ) 
  , 0.00 
)  AS confirmation_rate
FROM Signups S LEFT JOIN Confirmations C
ON S.user_id = C.user_id 
GROUP BY user_id ;
