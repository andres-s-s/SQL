with T as (
  SELECT 
      * 
    , ROW_NUMBER()
        OVER(
          PARTITION BY 
              user_id 
          ORDER BY 
              transaction_date ASC) 
      AS ind 
  
  FROM 
    transactions
)

SELECT 
    user_id 
  , spend 
  , transaction_date 

FROM 
  T 

WHERE 
      1=1
  and ind = 3;
