SELECT 
  EXTRACT(MONTH FROM event_date) AS mth , 
  COUNT(DISTINCT user_id) AS monthly_active_users
FROM user_actions U
WHERE TO_CHAR(event_date , 'DD/MM/YYYY') LIKE '%07/2022%'
  AND EXISTS(
    SELECT * FROM user_actions 
    WHERE user_id = U.user_id AND 
    TO_CHAR(event_date , 'DD/MM/YYYY') LIKE '%06/2022%'
--  EXTRACT(MONTH FROM event_date) =
--  EXTRACT(MONTH FROM U.event_date - interval '1 month')
)
GROUP BY EXTRACT(MONTH FROM event_date);
