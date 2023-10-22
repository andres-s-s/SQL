--MySQL  &  MS SQL SERVER
WITH  Amt   AS ( 
    SELECT COUNT(*) AS cnt FROM Product 
)
, Customers AS (
    SELECT DISTINCT customer_id , product_key FROM Customer 
) 
SELECT customer_id FROM Customers GROUP BY customer_id 
HAVING COUNT(*) = (SELECT cnt FROM Amt );



--MySQL  &  MS SQL SERVER
SELECT customer_id 
FROM Customer 
GROUP BY customer_id 
HAVING COUNT(DISTINCT product_key) = 
      (SELECT COUNT(*) FROM Product);
