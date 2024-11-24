/*
Instructions:
Assume you're given a table containing information on Facebook user actions. 

Write a query to obtain number of monthly active users (MAUs) in July 2022.
An active user is defined as a user who has performed actions such as 'sign-in', 
'like', or 'comment' in both the current month and the previous month.
*/


with 
  users_in_june_of_2022 as (
    select 
        distinct u.user_id 

    from 
      user_actions u

    where 
          1=1
      and to_char( u.event_date , 'DD/MM/YYYY' ) like '%06/2022%'
) 
--List of users who performed an action such as 'sign-in', 'like', or 'comment' in june of 2022



select 
    extract(month from u.event_date) as mth  
  , count(distinct u.user_id) as monthly_active_users

from 
  user_actions u

    join users_in_june_of_2022 u_june
      on u_june.user_id = u.user_id

where 
      1=1
  and to_char(u.event_date , 'DD/MM/YYYY') like '%07/2022%'
      --Users who performed an action such as 'sign-in', 'like', or 'comment' in july of 2022

group by
    extract(month from u.event_date);





/*
Alternative
*/
with 
    users_in_june_of_2022 as (
      select 
          u.user_id 

      from user_actions u

      where 
            1=1
        and to_char( u.event_date , 'DD/MM/YYYY' ) like '%06/2022%'
)



select 
    extract(month from u.event_date) as mth  
  , count(distinct u.user_id) as monthly_active_users

from 
  user_actions u

where 
      1=1
  and to_char(u.event_date , 'DD/MM/YYYY') like '%07/2022%'
  and exists(
        select * from users_in_june_of_2022 u_june where u.user_id = u_june.user_id
  )

group by
    extract( month from u.event_date );