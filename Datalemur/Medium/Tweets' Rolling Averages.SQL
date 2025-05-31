select
    t.user_id
  , t.tweet_date
  , round(
      avg(tweet_count)
        over(partition by 
                t.user_id
             
             order by 
                t.tweet_date
             
             range between  
                interval '2' day preceding and current row)
      , 2 )     --rows between 2 preceding and current row
      as rolling_avg_3d
from 
    tweets t;
