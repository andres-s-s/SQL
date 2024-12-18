--MySQL 
SELECT 
    alg 
  , MAX(IF(Q = "Q1" , volm , NULL ))  AS "Q1" 
  , MIN(IF(Q = "Q2" , volm , NULL ))  AS "Q2" 
  , MAX(IF(Q = "Q3" , volm , NULL ))  AS "Q3" 
  , MIN(IF(Q = "Q4" , volm , NULL ))  AS "Q4"

FROM (
      SELECT 
          algorithm AS alg  
        , SUM(volume) AS volm 
        , Q  
      
      FROM (
            SELECT 
                coin_code 
              , volume 
              , CASE 
                  WHEN UNIX_TIMESTAMP(dt) 
                  BETWEEN 
                        UNIX_TIMESTAMP('2020-01-01 00:00:00') 
                    AND UNIX_TIMESTAMP('2020-03-31 23:59:59') 
                  THEN "Q1"
                 
                 WHEN UNIX_TIMESTAMP(dt) BETWEEN  
                UNIX_TIMESTAMP('2020-04-01 00:00:00') 
                AND 
                UNIX_TIMESTAMP('2020-06-30 23:59:59') 
                THEN "Q2"
            WHEN UNIX_TIMESTAMP(dt) BETWEEN  
                UNIX_TIMESTAMP('2020-07-01 00:00:00' ) 
                AND 
                UNIX_TIMESTAMP('2020-09-30 23:59:59') 
                THEN "Q3"
            WHEN UNIX_TIMESTAMP(dt) BETWEEN 
                UNIX_TIMESTAMP('2020-10-01 00:00:00') 
                AND 
                UNIX_TIMESTAMP('2020-12-31 23:59:59') 
                THEN "Q4"
            ELSE NULL 
            END AS "Q"   
        FROM TRANSACTIONS                            
    ) AS Tr
    JOIN COINS AS C
    ON Tr.coin_code = C.code
    WHERE Q IS NOT NULL
    GROUP BY alg , Q 
    ) AS T 
GROUP BY alg
ORDER BY alg ASC



--MS SQL SERVER 
SELECT alg , 
    MAX( CASE WHEN Q = "Q1" THEN volm END )  AS "Q1" ,
    MIN( CASE WHEN Q = "Q2" THEN volm END )  AS "Q2" ,
    MAX( CASE WHEN Q = "Q3" THEN volm END )  AS "Q3" ,
    MIN( CASE WHEN Q = "Q4" THEN volm END )  AS "Q4"
 FROM (
    SELECT algorithm AS alg  , SUM(volume) AS volm , Q  FROM (
        SELECT coin_code ,volume , 
            CASE 
            WHEN CAST(dt AS timestamp ) BETWEEN  
                CAST('2020-01-01 00:00:00' AS timestamp)
                AND 
                CAST('2020-03-31 23:59:59' AS timestamp)
                THEN "Q1"
            WHEN CAST(dt AS timestamp ) BETWEEN  
                CAST('2020-04-01 00:00:00'  AS timestamp)
                AND 
                CAST('2020-06-30 23:59:59'  AS timestamp) 
                THEN "Q2"
            WHEN CAST(dt AS timestamp ) BETWEEN  
                CAST('2020-07-01 00:00:00'  AS timestamp)
                AND 
                CAST('2020-09-30 23:59:59'  AS timestamp)
                THEN "Q3"
            WHEN CAST(dt AS timestamp ) BETWEEN 
                CAST('2020-10-01 00:00:00'  AS timestamp)
                AND 
                CAST('2020-12-31 23:59:59'  AS timestamp)
                THEN "Q4"
            ELSE NULL 
            END AS "Q"   
        FROM TRANSACTIONS                            
    ) AS Tr
    JOIN COINS AS C
    ON Tr.coin_code = C.code
    WHERE Q IS NOT NULL
    GROUP BY algorithm , Q 
    ) AS T 
GROUP BY alg
ORDER BY alg ASC;
