--MySQL  
WITH CTE AS ( 
    SELECT users_id AS id FROM Users WHERE banned = 'Yes' 
)
SELECT request_at AS Day ,
ROUND(
    AVG( CASE WHEN status != 'completed' THEN 1 ELSE 0 END )
, 2 ) AS "Cancellation Rate"
FROM Trips  
WHERE    client_id NOT IN (SELECT id FROM CTE)
AND      driver_id NOT IN (SELECT id FROM CTE) 
AND      STR_TO_DATE( request_at  , '%Y-%m-%d')
BETWEEN  STR_TO_DATE( '2013-10-01', '%Y-%m-%d')
AND      STR_TO_DATE( '2013-10-03', '%Y-%m-%d')
GROUP BY request_at;



--MySQL  
WITH CTE AS ( 
    SELECT users_id AS id FROM Users WHERE banned = 'No' 
)
SELECT request_at AS Day ,
ROUND(
    AVG( CASE WHEN status != 'completed' THEN 1 ELSE 0 END )
, 2 ) AS "Cancellation Rate"
FROM Trips T
JOIN CTE   C
ON   T.client_id = C.id
JOIN CTE   C2
ON   T.driver_id = C2.id
WHERE    STR_TO_DATE(  request_at  ,'%Y-%m-%d')
BETWEEN  STR_TO_DATE( '2013-10-01', '%Y-%m-%d')
AND      STR_TO_DATE( '2013-10-03', '%Y-%m-%d')
GROUP BY request_at;



--MS SQL SERVER
WITH CTE AS ( 
    SELECT users_id AS id FROM Users WHERE banned = 'Yes' 
)
SELECT request_at AS Day ,
ROUND(
    AVG( CASE WHEN status != 'completed' THEN 1.0 ELSE 0.0 END )
, 2 ) AS "Cancellation Rate"
FROM Trips  
WHERE    client_id NOT IN (SELECT id FROM CTE)
AND      driver_id NOT IN (SELECT id FROM CTE) 
AND      CAST(    request_at  AS DATE )
BETWEEN  CAST(  '2013-10-01'  AS DATE)
AND      CAST(  '2013-10-03'  AS DATE)
GROUP BY request_at;



--MS SQL SERVER
WITH CTE AS ( 
    SELECT users_id AS id FROM Users WHERE banned = 'No' 
)
SELECT request_at AS Day ,
ROUND(
    AVG( CASE WHEN status != 'completed' THEN 1.0 ELSE 0.0 END )
, 2 ) AS "Cancellation Rate"
FROM Trips T
JOIN CTE   C
ON   T.client_id = C.id
JOIN CTE   C2
ON   T.driver_id = C2.id
WHERE    CAST(    request_at  AS DATE )
BETWEEN  CAST(  '2013-10-01'  AS DATE)
AND      CAST(  '2013-10-03'  AS DATE)
GROUP BY request_at;
