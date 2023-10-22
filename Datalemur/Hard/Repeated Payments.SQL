WITH T AS (
SELECT 
  CASE WHEN 
  EXTRACT( EPOCH FROM ( transaction_timestamp -
  LAG(transaction_timestamp) 
  OVER(PARTITION BY credit_card_id , merchant_id ,  amount ) ) ) <=600
  THEN 1 ELSE NULL 
  END AS tf
FROM transactions
)
SELECT COUNT(tf) FROM T;
