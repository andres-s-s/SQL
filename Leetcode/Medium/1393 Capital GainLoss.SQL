--MySQL  &  MS SQL SERVER
WITH CTE AS (
  SELECT stock_name , 
    CASE WHEN operation = 'Buy' THEN 
    LEAD(price) OVER(ORDER BY stock_name , operation_day ASC) - price 
    ELSE 0 END AS gl 
  FROM Stocks
)
SELECT stock_name , SUM(gl) AS capital_gain_loss 
FROM CTE GROUP BY stock_name;



--MySQL  &  MS SQL SERVER
SELECT stock_name , SUM(gl) AS capital_gain_loss
FROM (
    SELECT stock_name , 
    CASE  WHEN operation = 'Buy' THEN  -price ELSE price 
    END AS gl 
    FROM Stocks
) AS T 
GROUP BY stock_name;



--MySQL  &  MS SQL SERVER
SELECT DISTINCT stock_name , 
  SUM( CASE WHEN operation = 'Buy' THEN -price ELSE price END )
  OVER(PARTITION BY stock_name) AS capital_gain_loss
FROM Stocks;
