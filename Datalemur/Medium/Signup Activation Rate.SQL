SELECT ROUND( COUNT(T.email_id)/COUNT(*)::DECIMAL , 2 )
  AS activation_rate
FROM emails E
LEFT JOIN texts T
  ON  T.email_id = E.email_id 
  AND T.signup_action = 'Confirmed';
