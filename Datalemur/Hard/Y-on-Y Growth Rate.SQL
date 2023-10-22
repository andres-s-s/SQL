SELECT 
  EXTRACT(YEAR FROM transaction_date) AS yr , 
  product_id , 
  spend AS curr_year_spend , 
  pys AS prev_year_spend   ,
  ROUND( ( ( spend - pys ) *100.0 )/pys , 2 )
    AS yoy_rate
FROM (
    SELECT
      * ,
      LAG(spend) 
      OVER(PARTITION BY product_id 
      ORDER BY transaction_date) 
      AS pys
    FROM user_transactions
) AS T
ORDER BY product_id , transaction_date ASC;
