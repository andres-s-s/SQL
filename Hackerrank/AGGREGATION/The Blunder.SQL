--MySQL
SELECT CEIL( AVG(salary) - AVG( REPLACE(salary , 0 , "") ) ) FROM EMPLOYEES;



--MySQL  &  MS SQL Server
SELECT CEILING( AVG( CAST( salary AS DECIMAL) ) - 
                AVG( CAST( REPLACE(salary , 0 , "") AS DECIMAL) ) ) 
FROM EMPLOYEES;
