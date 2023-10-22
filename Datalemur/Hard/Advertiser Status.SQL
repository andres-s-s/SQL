SELECT COALESCE(A.user_id , D.user_id ) AS user_id ,
  CASE 
    WHEN D.user_id IS NULL THEN 'CHURN'
    ELSE 
      CASE
        WHEN A.status = 'CHURN'  THEN 'RESURRECT'
        WHEN A.user_id  IS NULL  THEN 'NEW' 
        ELSE  'EXISTING'
      END
  END AS new_status
FROM advertiser A
FULL OUTER JOIN daily_pay D
  ON D.user_id = A.user_id
ORDER BY user_id;
