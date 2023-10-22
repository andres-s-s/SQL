SELECT category , product , sp AS total_spend 
FROM (
    SELECT * , 
    ROW_NUMBER() 
    OVER(PARTITION BY category ORDER BY sp DESC) AS ind
    FROM (
        SELECT category , product , SUM(spend) AS sp
        FROM product_spend
        WHERE EXTRACT( YEAR FROM transaction_date ) = '2022'
        GROUP BY category , product 
    ) AS T 
) AS T2
WHERE ind IN ( 1 , 2 );
