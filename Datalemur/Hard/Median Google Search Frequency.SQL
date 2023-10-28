-- 1 
SELECT 
ROUND(
  CASE WHEN LENGTH(d_set) % 2 != 0 
    THEN  CAST( SUBSTRING( d_set , CAST(CEIL(LENGTH(d_set)/2 ) AS INT ) , 1 ) AS INT )
    ELSE (CAST( SUBSTRING( d_set , LENGTH(d_set)/2 , 1 )     AS INT ) +
          CAST( SUBSTRING( d_set , LENGTH(d_set)/2 + 1 , 1 ) AS INT ) )/2.0
  END 
, 1 ) AS median
FROM (
    SELECT STRING_AGG(numb , '') AS d_set
    FROM (
        SELECT REPEAT( CAST( searches AS VARCHAR ) , num_users ) AS numb
        FROM  search_frequency
        ORDER BY searches ASC
    ) AS T 
) AS T2;



-- 2
WITH T AS (
  SELECT searches , GENERATE_SERIES(1 , num_users , 1)
  FROM search_frequency
)
SELECT 
  ROUND(PERCENTILE_CONT(0.50) 
    WITHIN GROUP ( ORDER BY searches )::DECIMAL , 1 ) 
  AS median
FROM T;
