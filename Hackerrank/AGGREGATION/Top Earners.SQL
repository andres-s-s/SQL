--MySQL  &  MS SQL Server
SELECT salary * months , COUNT(*) FROM EMPLOYEE     
WHERE  salary * months = ( SELECT MAX(salary * months) FROM EMPLOYEE )
GROUP BY salary * months;



--MySQL 
SELECT salary * months AS te, COUNT(*) FROM EMPLOYEE     
GROUP BY salary * months
HAVING te = ( SELECT MAX(salary * months) FROM EMPLOYEE );



--MySQL 
SELECT salary * months AS te, COUNT(*) FROM EMPLOYEE     
GROUP BY te
ORDER BY te DESC LIMIT 1 ;



--MS SQL Server
SELECT salary * months , COUNT(*) FROM EMPLOYEE     
GROUP BY salary * months
HAVING salary * months = ( SELECT MAX(salary * months) FROM EMPLOYEE );



--MS SQL Server
SELECT TOP 1 salary * months , COUNT(*) FROM EMPLOYEE     
GROUP BY salary * months
ORDER BY salary * months DESC;
