SELECT 
    age_bucket 
  , ROUND(
      ( SUM(time_spent) 
        FILTER(WHERE activity_type =  'send')
       )/SUM(time_spent) *100.0 , 2 ) AS send_perc 
  , ROUND(
        SUM( time_spent  ) 
        FILTER(WHERE activity_type =  'open' )
      /SUM(time_spent) *100.0 , 2 ) AS open_perc 

FROM  
  activities AS A

    JOIN age_breakdown AS Ag 
      ON A.user_id = Ag.user_id 

WHERE 
      1=1  
  and activity_type != 'chat'

GROUP BY 
    age_bucket ;
