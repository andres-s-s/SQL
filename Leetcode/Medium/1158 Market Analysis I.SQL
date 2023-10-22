--MySQL  &  MS SQL SERVER
WITH CTE AS (
    SELECT buyer_id , COUNT(*) AS cnt 
    FROM Orders
    WHERE YEAR(order_date) = '2019' 
    GROUP BY buyer_id
)

SELECT U.user_id AS buyer_id , U.join_date , COALESCE( C.cnt , 0 ) AS orders_in_2019
FROM Users U LEFT JOIN CTE C 
ON U.user_id = C.buyer_id ;



--MySQL  &  MS SQL SERVER
SELECT U.user_id AS buyer_id , U.join_date ,  COUNT(O.buyer_id) AS orders_in_2019
FROM Users U 
LEFT JOIN Orders O
ON U.user_id = O.buyer_id AND YEAR(O.order_date) = '2019'
GROUP BY U.user_id  , U.join_date;



--MySQL  &  MS SQL SERVER
SELECT user_id AS buyer_id , join_date ,
    (SELECT COUNT(*) FROM Orders O
     WHERE U.user_id = O.buyer_id
     AND   LEFT( order_date , 4) = '2019' ) 
     AS orders_in_2019
 FROM Users U;
