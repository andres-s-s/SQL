/*
Instructions:
Assume you're given a table containing information on Facebook user actions. 

Write a query to obtain number of monthly active users (MAUs) in July 2022.
An active user is defined as a user who has performed actions such as 'sign-in', 
'like', or 'comment' in both the current month and the previous month.
*/


/*
It takes the users who performed an action in July, then it makes sure these users also
performed an action the month before after that we have a list of active users however
if the same user performed several actions in the month, It will appear more than once
and we don't want that therefore grouping by month and since all the records are from the 
same month that will return one line then the count function plus distinct will let as know
how many distinct users are
*/




with users_in_june_of_2022 as (
  select 
      u.user_id 

  from user_actions u

  where 
        1=1
    and to_char( u.event_date , 'DD/MM/YYYY' ) like '%06/2022%'
)
--List of users who performed an action such as 'sign-in', 'like', or 'comment' in june of 2022




select 
    extract(month from u.event_date) as mth  -- Current month
  , count(distinct u.user_id) as monthly_active_users

from 
  user_actions u

where 
      1=1
  and to_char(u.event_date , 'DD/MM/YYYY') like '%07/2022%' -- Current month
  -- Users who performed an action such as 'sign-in', 'like', or 'comment' in july of 2022
  and exists(
        select 
            u_june.user_id 
          
        from 
          users_in_june_of_2022 u_june 
        
        where 
            u.user_id = u_june.user_id
            )
        

group by
    extract( month from u.event_date );









-- another

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
    , max(uw.mth) as mnth

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