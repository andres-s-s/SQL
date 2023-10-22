--MySQL  &  MS SQL Server
SELECT CAST( ( MAX(LAT_N) - MIN(LAT_N) ) + ( MAX(LONG_W) - MIN(LONG_W) ) 
            AS DECIMAL(12,4) )
FROM STATION ;



--MySQL
SELECT ROUND( ( MAX(LAT_N) - MIN(LAT_N) ) + ( MAX(LONG_W) - MIN(LONG_W) ) 
            , 4 )
FROM STATION ;
