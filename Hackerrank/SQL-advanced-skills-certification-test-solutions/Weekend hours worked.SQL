--MySQL
SELECT emp_id , SUM(num) FROM (
    SELECT emp_id ,  
    TIMESTAMPDIFF(HOUR , MIN(timestamp) , MAX(timestamp) )  AS num
    FROM ATTENDANCE
    WHERE WEEKDAY( timestamp ) IN (5 , 6)
    GROUP BY  DATE_FORMAT(timestamp, "%Y %m %d ") , emp_id
    ) AS T
GROUP BY emp_id;



--MS SQL SERVER
SELECT emp_id , SUM(num) FROM (
    SELECT emp_id ,  
    DATEDIFF(SECOND ,  MIN(timestamp) , MAX(timestamp) )/3600  AS num
    FROM ATTENDANCE
    WHERE DATEPART( WEEKDAY , timestamp ) IN ( 1 , 7 ) 
--  WHERE DATENAME( WEEKDAY ,  CAST( timestamp AS DATE )) IN ( "Sunday" , "Saturday" )
    GROUP BY  CAST( timestamp AS DATE )   , emp_id
    ) AS T
GROUP BY emp_id;
