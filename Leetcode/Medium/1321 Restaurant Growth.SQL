--MySQL  
SELECT 
C1.visited_on , 
SUM(C2.amount) AS amount ,
ROUND( SUM(C2.amount)/7 , 2 ) AS average_amount 
FROM (
    SELECT DISTINCT visited_on FROM Customer 
    WHERE STR_TO_DATE( visited_on , '%Y-%m-%d')  >
        (SELECT ADDDATE( MIN(visited_on), INTERVAL 5 DAY)  FROM Customer ) )
AS C1 
JOIN Customer C2
ON   STR_TO_DATE( C2.visited_on , '%Y-%m-%d') 
BETWEEN 
SUBDATE(     C1.visited_on, INTERVAL 6 DAY)  AND
STR_TO_DATE( C1.visited_on , '%Y-%m-%d')   
GROUP BY C1.visited_on  
ORDER BY C1.visited_on ASC ;



--MS SQL SERVER
WITH CTE AS (
    SELECT DISTINCT visited_on FROM Customer 
    WHERE CAST( visited_on AS DATE )  >
        (SELECT DATEADD(DAY , 5 , MIN(visited_on) )  FROM Customer ) 
)
SELECT 
C1.visited_on , 
SUM(C2.amount) AS amount ,
ROUND( SUM(C2.amount)/7.0 , 2 ) AS average_amount 
FROM CTE AS C1 
JOIN Customer C2
ON   CAST( C2.visited_on AS DATE ) 
BETWEEN 
DATEADD(DAY , -6 , C1.visited_on )  AND
CAST( C1.visited_on AS DATE )   
GROUP BY C1.visited_on 
ORDER BY C1.visited_on ASC ;




--MySQL  
WITH CTE AS (
    SELECT DISTINCT visited_on FROM Customer 
    WHERE STR_TO_DATE( visited_on , '%Y-%m-%d')  >
        (SELECT ADDDATE( MIN(visited_on), INTERVAL 5 DAY)  FROM Customer ) ) , 

    CTE2 AS (
    SELECT visited_on , 
       (SELECT SUM(amount)  FROM Customer
        WHERE STR_TO_DATE( visited_on , '%Y-%m-%d') BETWEEN 
        SUBDATE(     C.visited_on, INTERVAL 6 DAY)  AND
        STR_TO_DATE( C.visited_on , '%Y-%m-%d')   
        ) AS amount
    FROM CTE C
    )

SELECT visited_on , 
amount , 
ROUND( amount/7 , 2 ) AS average_amount
FROM CTE2;



--MS SQL SERVER
WITH CTE AS (
    SELECT DISTINCT visited_on FROM Customer 
    WHERE CAST( visited_on AS DATE )  >
        (SELECT DATEADD(DAY , 5 , MIN(visited_on) )  FROM Customer ) ) , 

    CTE2 AS (
    SELECT visited_on , 
       (SELECT SUM(amount)  FROM Customer
        WHERE CAST( visited_on AS DATE ) BETWEEN 
        DATEADD(DAY , -6 , C.visited_on ) AND
        CAST(  C.visited_on  AS DATE )   
        ) AS amount
    FROM CTE C
    )

SELECT visited_on , 
amount , 
ROUND( amount/7.0 , 2 ) AS average_amount
FROM CTE2;



--MySQL
SELECT DISTINCT visited_on , 
  amount ,
  ROUND( amount/7 , 2 ) AS average_amount
FROM (
  SELECT visited_on , 
    SUM( amount )
      OVER( ORDER BY visited_on 
      RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW )
    AS amount
    FROM Customer
) AS T
WHERE visited_on > 
  (SELECT ADDDATE( MIN(visited_on) , INTERVAL 5 DAY)  FROM Customer )
ORDER BY visited_on ASC;




--MS SQL SERVER
--This could work if there were not missing dates as the description of the problem suggest by stating that 
--(there will be at least one customer every day).
WITH CTE AS (
    SELECT visited_on , SUM(amount) AS amount
    FROM Customer
    GROUP BY visited_on

)

SELECT DISTINCT visited_on , 
  amount ,
  ROUND( amount/7.0 , 2 ) AS average_amount
FROM (
  SELECT visited_on , 
    SUM( amount )
      OVER( ORDER BY visited_on 
      ROWS BETWEEN  6 PRECEDING AND CURRENT ROW )
    AS amount
    FROM CTE
) AS T
WHERE visited_on > 
   (SELECT DATEADD(DAY , 5 , MIN(visited_on) )  FROM Customer )
ORDER BY visited_on ASC;
