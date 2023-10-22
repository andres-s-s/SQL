--MySQL  &  MS SQL Server
SELECT CAST( LAT_N AS DECIMAL(10,4) ) FROM STATION S 
WHERE (SELECT COUNT(*) FROM STATION WHERE LAT_N > S.LAT_N ) =
      (SELECT COUNT(*) FROM STATION WHERE LAT_N < S.LAT_N ) ;



--MySQL
SET @index := -1;
SELECT ROUND(LAT_N,4) FROM 
        (SELECT @index := @index + 1 AS ind , 
         LAT_N FROM STATION ORDER BY LAT_N    ) AS T
WHERE ind IN ( FLOOR(@index/2) , CEIL(@index/2) ) ;



--MS SQL Server
DECLARE @tm INT;
SET @tm = (SELECT COUNT(*) - 1 FROM STATION);
SELECT CAST(LAT_N AS DECIMAL(10,4) ) FROM 
         (SELECT ROW_NUMBER() OVER(ORDER BY LAT_N) - 1 AS ind , LAT_N
          FROM STATION ) AS T
WHERE ind  IN ( FLOOR( @tm/2.00 ) , CEILING( @tm/2.00 ) ) ;



--MS SQL Server
SET @tm = (SELECT COUNT(*) FROM STATION);  /*o SELECT*/
SELECT CAST( LAT_N AS DECIMAL( 8, 4) ) FROM 
    (SELECT  LAT_N , ROW_NUMBER() OVER( ORDER BY LAT_N ) AS num 
     FROM STATION ) AS T
WHERE  @tm % 2 = 0 AND T.num IN (@tm/2, @tm/2+1) OR T.num = (@tm+1)/2;



--MS SQL Server
DECLARE @tm INT;
SET @tm = (SELECT COUNT(*) - 1 FROM STATION);
SELECT CAST(LAT_N AS DECIMAL(10,4) ) FROM 
         (SELECT ROW_NUMBER() OVER(ORDER BY LAT_N) - 1 AS ind , LAT_N
          FROM STATION ) AS T
WHERE ind % 2 != 0 AND ind IN (@tm/2 , @tm/2 + 1) OR ind = ( @tm/2) ;
