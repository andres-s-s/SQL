SELECT user_id , spend , transaction_date FROM (
    SELECT * , ROW_NUMBER()
      OVER(PARTITION BY user_id ORDER BY transaction_date ASC) AS ind 
    FROM transactions
) AS T 
WHERE ind = 3;
