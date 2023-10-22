--MySQL  &  MS SQL SERVER
SELECT ROUND( SUM( tiv_2016 ) , 2 ) AS tiv_2016 FROM Insurance I
WHERE 
tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 
                   HAVING COUNT(*) > 1 )
AND EXISTS  (SELECT lat , lon FROM Insurance WHERE I.lat = lat AND I.lon = lon
             GROUP BY lat , lon  HAVING COUNT(*) = 1 );



--MySQL  &  MS SQL SERVER
WITH CTE  AS (SELECT tiv_2015 FROM Insurance 
              GROUP BY tiv_2015 HAVING COUNT(*) > 1 ), 
     CTE2 AS (SELECT lat , lon FROM Insurance  GROUP BY lat , lon
              HAVING COUNT(*) = 1 )

SELECT ROUND ( SUM( tiv_2016 ) , 2 ) AS tiv_2016 FROM Insurance I
JOIN CTE2 AS C ON C.lat = I.lat AND C.lon = I.lon
WHERE I.tiv_2015 IN (SELECT tiv_2015 FROM CTE )
AND C.lat IS NOT NULL ;



--MySQL  &  MS SQL SERVER ---FASTEST
WITH CTE (tiv_2016 , tiv_2015c , latlonc ) AS(
    SELECT tiv_2016 ,
    COUNT(*) OVER( PARTITION BY tiv_2015 ) , 
    COUNT(*) OVER( PARTITION BY lat , lon)
    FROM Insurance 
)

SELECT ROUND( SUM( tiv_2016 ) , 2 ) AS tiv_2016 FROM 
CTE WHERE tiv_2015c > 1 AND latlonc = 1 ; 



--MySQL 
SELECT ROUND( SUM( tiv_2016 ) , 2 ) AS tiv_2016 FROM Insurance 
WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 
                   HAVING COUNT(*) > 1 )
AND (lat,lon)  IN (SELECT lat , lon FROM Insurance GROUP BY lat , lon 
                   HAVING COUNT(*) = 1 );



--MySQL 
SELECT ROUND( SUM( tiv_2016 ) , 2 ) as tiv_2016 FROM(

    SELECT *  FROM Insurance  GROUP BY lat , lon  HAVING COUNT(*) = 1 
    AND tiv_2015 IN (SELECT tiv_2015 FROM Insurance 
                     GROUP BY tiv_2015 HAVING COUNT(*)>1 )

) AS T ;
