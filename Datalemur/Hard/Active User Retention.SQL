select 
  extract(MONTH from event_date) AS mth , 
  COUNT(DISTINCT user_id) AS monthly_active_users

from user_actions U

where 
      1=1
  and TO_CHAR(event_date , 'DD/MM/YYYY') LIKE '%07/2022%'
  and exists(
        select * from user_actions 
        where user_id = U.user_id AND 
        TO_CHAR(event_date , 'DD/MM/YYYY') LIKE '%06/2022%'
    --  extract(MONTH from event_date) =
    --  extract(MONTH from U.event_date - interval '1 month')
)

GROUP BY 
  extract(MONTH from event_date);
