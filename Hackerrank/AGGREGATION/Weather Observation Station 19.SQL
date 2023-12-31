--MySQL  &  MS SQL Server
SELECT CAST( 
      SQRT(   POWER( MAX(LAT_N) -  MIN(LAT_N)  ,2 ) + 
              POWER( MAX(LONG_W) - MIN(LONG_W) ,2 ) )
    AS DECIMAL(12,4)  )
FROM STATION ;



--MySQL
SELECT ROUND( 
      SQRT(   POWER( MAX(LAT_N) -  MIN(LAT_N)  ,2 ) + 
              POWER( MAX(LONG_W) - MIN(LONG_W) ,2 ) )
    , 4 )
FROM STATION ;



--MS SQL Server
SELECT CAST( 
      SQRT(   SQUARE( MAX(LAT_N) -  MIN(LAT_N)   ) + 
              SQUARE( MAX(LONG_W) - MIN(LONG_W)  ) )
    AS DECIMAL(12,4)  )
FROM STATION ;
