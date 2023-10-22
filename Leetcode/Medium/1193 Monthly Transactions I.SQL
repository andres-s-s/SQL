--MySQL  &  MS SQL SERVER
SELECT LEFT( trans_date , 7 ) AS month , 
country , 
COUNT(*)  AS trans_count , 
COUNT(  CASE WHEN state = 'approved' THEN amount END  ) AS approved_count , 
SUM( amount ) AS trans_total_amount , 
SUM(    CASE WHEN state = 'approved' THEN amount ELSE 0 END ) AS approved_total_amount
FROM Transactions 
GROUP BY country , LEFT( trans_date , 7 ) ; 



--MySQL
SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month , 
country , 
COUNT(*)  AS trans_count , 
COUNT( IF( state = 'approved' , amount , NULL)  ) AS approved_count , 
SUM( amount ) AS trans_total_amount , 
SUM(   IF( state = 'approved' , amount , 0   )  ) AS approved_total_amount
FROM Transactions 
GROUP BY country , DATE_FORMAT(trans_date, '%Y-%m') ; 



--MS SQL SERVER
SELECT FORMAT( trans_date , 'yyyy-MM' ) AS month , 
country , 
COUNT(*)  AS trans_count , 
COUNT(  CASE WHEN state = 'approved' THEN amount END  ) AS approved_count , 
SUM( amount ) AS trans_total_amount , 
SUM(    CASE WHEN state = 'approved' THEN amount ELSE 0 END ) AS approved_total_amount
FROM Transactions 
GROUP BY country , FORMAT( trans_date , 'yyyy-MM' ) ; 
