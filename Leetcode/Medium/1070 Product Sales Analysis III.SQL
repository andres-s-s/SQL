--MySQL  &  MS SQL SERVER
SELECT product_id , year AS first_year , quantity , price 
FROM   Sales
WHERE  CONCAT(product_id , year ) IN 
      (SELECT CONCAT( product_id , MIN(year) ) FROM Sales 
       GROUP BY product_id ); 



--MySQL  &  MS SQL SERVER 
WITH CTE AS (
    SELECT product_id , MIN(year) AS year 
    FROM Sales GROUP BY product_id
)

SELECT product_id , year AS first_year , quantity , price 
FROM Sales S
WHERE year = (SELECT year FROM CTE C 
              WHERE S.product_id = C.product_id  )  ;



--MySQL
SELECT product_id , year AS first_year , quantity , price 
FROM Sales
WHERE (product_id , year ) IN 
      (SELECT product_id , MIN(year) FROM Sales 
       GROUP BY product_id ); 



--MySQL  &  MS SQL SERVER ---Testcases passed, but took too long.
SELECT product_id , year AS first_year , quantity , price 
FROM (
    SELECT DENSE_RANK() 
    OVER(PARTITION BY product_id ORDER BY year ASC ) AS ind , 
    product_id , year , quantity , price 
    FROM Sales
) AS T 
WHERE ind = 1 ; 
