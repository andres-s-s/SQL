--MySQL 
SELECT T.product_id , COALESCE( P.new_price , 10 ) AS price 
FROM (
    SELECT product_id , MAX(
        CASE WHEN 
          STR_TO_DATE( change_date, '%Y-%m-%d') <= 
          STR_TO_DATE('2019-08-16', '%Y-%m-%d')
        THEN change_date END
    ) AS dt
    FROM Products
    GROUP BY product_id
) AS T 
LEFT JOIN Products P
ON P.product_id = T.product_id AND T.dt = P.change_date;



--MySQL 
WITH CTE AS (
    SELECT DISTINCT product_id ,
    FIRST_VALUE(new_price) OVER(PARTITION BY product_id 
    ORDER BY change_date DESC ) AS price 
    FROM Products
    WHERE STR_TO_DATE( change_date, '%Y-%m-%d') <= 
          STR_TO_DATE('2019-08-16', '%Y-%m-%d')
)
SELECT * FROM CTE 
UNION ALL 
SELECT DISTINCT product_id , 10 AS price 
FROM Products
WHERE product_id NOT IN (SELECT product_id FROM CTE );



--MS SQL SERVER
SELECT T.product_id , COALESCE( P.new_price , 10 ) AS price 
FROM (
    SELECT product_id , MAX(
        CASE WHEN 
          CAST( change_date  AS DATE) <= 
          CAST('2019-08-16'  AS DATE )
        THEN change_date END
    ) AS dt
    FROM Products
    GROUP BY product_id
) AS T 
LEFT JOIN Products P
ON P.product_id = T.product_id AND T.dt = P.change_date;



--MS SQL SERVER
WITH CTE AS (
    SELECT DISTINCT product_id ,
    FIRST_VALUE(new_price) OVER(PARTITION BY product_id 
    ORDER BY change_date DESC ) AS price 
    FROM Products
    WHERE CAST( change_date  AS DATE) <= 
          CAST('2019-08-16'  AS DATE )
)
SELECT * FROM CTE 
UNION ALL 
SELECT DISTINCT product_id , 10 AS price 
FROM Products
WHERE product_id NOT IN (SELECT product_id FROM CTE );
