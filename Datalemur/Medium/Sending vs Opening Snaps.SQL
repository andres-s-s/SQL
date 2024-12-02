select 
    age_bucket 
  , round(
      ( sum(time_spent) 
        filter(where activity_type =  'send')
       )/sum(time_spent) *100.0 , 2 ) as send_perc 
  , round(
        sum( time_spent  ) 
        filter(where activity_type =  'open' )
      /sum(time_spent) *100.0 , 2 ) as open_perc 

from  
  activities as a

    join age_breakdown as ag 
      on a.user_id = ag.user_id 

where 
      1=1  
  and activity_type != 'chat'

group by 
    age_bucket ;
