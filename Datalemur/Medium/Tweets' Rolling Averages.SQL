SELECT 
    user_id 
  , tweet_date 
  , ROUND(
      AVG(tweet_count) 
      OVER( 
        PARTITION BY 
            user_id 
        ORDER BY 
            tweet_date ASC 
        
        RANGE BETWEEN 
            INTERVAL '2' DAY PRECEDING AND CURRENT ROW  ) 
          --ROWS BETWEEN 2 PRECEDING AND CURRENT ROW )
    , 2) 
    AS rolling_avg_3d

FROM tweets;
