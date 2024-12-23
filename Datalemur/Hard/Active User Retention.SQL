/*
  Instructions:
  Assume you're given a table containing information on Facebook user actions. 

  Write a query to obtain number of monthly active users (MAUs) in July 2022.
  An active user is defined as a user who has performed actions such as 'sign-in', 
  'like', or 'comment' in both the current month and the previous month.
*/



/*
  The cte takes a list of users who performed an action in june of 2022

  The query filters the data based on the previous list and users who performed 
  an action in july
  Since an user can perform several actions the same month, "distinct" is necessary
  so the same user is only counted once
  The reason of the group by clause is to get the month  


*/




with users_in_june_of_2022 as (
  select 
      distinct u.user_id 

  from 
      user_actions u

  where 
        1=1
    and to_char( u.event_date , 'DD/MM/YYYY' ) like '%06/2022%'

) -- List of users who performed an action such as 'sign-in', 'like', or 'comment' in june of 2022



select 
    extract(month from u.event_date) as mth  -- Current month
  , count(distinct u.user_id) as monthly_active_users

from 
    user_actions u

where 
      1=1
  and to_char(u.event_date , 'DD/MM/YYYY') like '%07/2022%' -- Current month
  -- Users who performed an action such as 'sign-in', 'like', or 'comment' in July of 2022
  and exists(
        select 
            u_june.user_id 
          
        from 
            users_in_june_of_2022 u_june 
        
        where 
            u.user_id = u_june.user_id
            )
        -- Makes sure the users also performed an action the month before

group by
    extract( month from u.event_date );







/*
Alternative
users_who_performed_actions takes all the users who performed an action in July or 
June, it's unknown if the user performed several actions in the same month therefore 
It's necessary to group by user_id and month 
After that there will be only one record per user in a month 
Two columns, user_id and the month that user performed an action

The active_users cte takes advantage of that, grouping by user_id in the second cte
and then getting rid of the users who only have one record
This works because there's only one recod per user in a month therefore if the
user_id appears only one time that means the user didn't performed an 
action in both months then the max funtion takes the current month
This give us a list of users who are active plus the current month

Finally in the last select statement we group by month and count the amount of records
All the months now are the same and each user_id only appears once 
That is why it works
*/



with users_who_performed_actions as (
  select 
      u.user_id
    , extract(month from u.event_date) as mth

  from 
    user_actions u

  where 
        1=1
    and to_char(u.event_date , 'DD/MM/YYYY') like '%07/2022%'
    or  to_char( u.event_date , 'DD/MM/YYYY' ) like '%06/2022%'

  group by 
      u.user_id
    , extract(month from u.event_date) 
)
-- Users who performed an action in June Or July plus the current month 



, active_users as (
  select 
      count( uw.user_id ) 
    , max(uw.mth) as mnth -- Current month

  from 
    users_who_performed_actions uw

  group by 
      uw.user_id
    
  having count( uw.user_id ) > 1
)



select 
    au.mnth
  , count(*)
  
from 
  active_users au

group by 
    mnth