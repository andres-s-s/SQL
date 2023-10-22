--MySQL  &  MS SQL SERVER
SELECT 
ROUND( COUNT(*) / CAST( 
  (SELECT COUNT(DISTINCT customer_id) FROM Delivery  ) AS FLOAT ) * 100 , 2 )
AS immediate_percentage
FROM (
    SELECT customer_id , MIN(order_date) AS dt , 
    MIN(customer_pref_delivery_date)     AS cpddt
    FROM Delivery
    GROUP BY customer_id
) AS T
WHERE cpddt =  dt ;



--MySQL  &  MS SQL SERVER
SELECT 
ROUND( COUNT(*) /CAST( 
  (SELECT COUNT(DISTINCT customer_id) FROM Delivery  ) AS FLOAT ) * 100 , 2 )
AS immediate_percentage
FROM Delivery
WHERE order_date = customer_pref_delivery_date 
AND   CONCAT( customer_id,order_date ) IN 
     (SELECT CONCAT( customer_id,MIN(order_date) )
      FROM Delivery
      GROUP BY customer_id ) ;




--MySQL  &  MS SQL SERVER
SELECT 
ROUND( 
    AVG( CASE WHEN order_date = customer_pref_delivery_date 
         THEN 1.0 ELSE 0.0 END) * 100.00 , 2 ) 
AS immediate_percentage
FROM (SELECT customer_id , order_date , customer_pref_delivery_date ,
      ROW_NUMBER() 
      OVER(PARTITION BY customer_id ORDER BY order_date ASC) AS ind
      FROM Delivery
      ) AS T
WHERE ind = 1 ;
