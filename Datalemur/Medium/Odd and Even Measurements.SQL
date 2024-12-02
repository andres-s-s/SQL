WITH ranked_measurements AS (
  SELECT 
      measurement_value 
    , measurement_time 
    , ROW_NUMBER() 
        OVER(
          PARTITION BY DATE( measurement_time )
          ORDER BY 
              measurement_time ASC) 
        AS ind
  FROM 
    measurements
)

SELECT 
    DATE(measurement_time ) 
  , SUM(
      CASE 
        WHEN 
          ind % 2 != 0 
        THEN 
          measurement_value 
        ELSE 
          0 
      END 
       ) 
      AS odd_sum 
  , SUM(
      CASE 
        WHEN 
          ind % 2 = 0 
        THEN 
          measurement_value 
        ELSE 
          0 
      END ) 
      AS even_sum

FROM 
  ranked_measurements 

GROUP BY 
    DATE( measurement_time )

ORDER BY DATE
    ( measurement_time ) ASC ;
