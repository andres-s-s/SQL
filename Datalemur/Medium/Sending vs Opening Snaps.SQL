/*
  Assume you're given tables with information on Snapchat users, including their 
  ages and time spent sending and opening snaps.

  Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a 
  percentage of total time spent on these activities grouped by age group. 
  Round the percentage to 2 decimal places in the output.

  Calculate the following percentages:
    time spent sending / (Time spent sending + Time spent opening)
    Time spent opening / (Time spent sending + Time spent opening)


  activities Example Input
  activity_id	  user_id	  activity_type	  time_spent	  activity_date
  7274	        123	      open	          4.50	        06/22/2022 12:00:00
  1414	        789	      chat	          11.00	        06/25/2022 12:00:00


  age_breakdown Example Input
  user_id	  age_bucket
  123	      31-35
  456	      26-30
  789	      21-25
*/


with send_and_open_percentages as (

  select 
      ag.age_bucket
    , sum(time_spent) 
        filter(where activity_type = 'send') 
        / sum(time_spent)
        as send_perc
    , sum(time_spent) 
        filter(where activity_type = 'open')
        / sum(time_spent)
        as open_perc

  from 
      activities ac
      
      join age_breakdown ag
         on ac.user_id = ag.user_id

  where 
      activity_type != 'chat'

  group by
      ag.age_bucket 
    )


select 
    s.age_bucket
  , round(s.send_perc * 100 , 2)
      as send_perc
  , round(s.open_perc * 100 , 2)
      as open_perc

from 
    send_and_open_percentages s