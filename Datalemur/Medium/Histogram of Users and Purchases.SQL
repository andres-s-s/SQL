  SELECT transaction_date , user_id , COUNT(*) 
  FROM (
    SELECT user_id ,	spend , transaction_date ,
    DENSE_RANK() 
    OVER(PARTITION BY user_id 
        ORDER BY transaction_date DESC ) AS ind
    FROM user_transactions
  ) AS T
  WHERE ind = 1 
  GROUP BY transaction_date , user_id
  ORDER BY transaction_date;
