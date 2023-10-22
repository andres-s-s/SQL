SELECT  customer_id 
FROM customer_contracts C
JOIN products P
  ON C.product_id = P.product_id
GROUP BY customer_id 
HAVING COUNT(DISTINCT product_category) = 
  (SELECT COUNT(DISTINCT product_category) FROM products);
