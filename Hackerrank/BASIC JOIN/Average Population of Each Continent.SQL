--MySQL  &  MS SQL Server
SELECT Co.continent , FLOOR(AVG(C.population)) FROM COUNTRY Co JOIN CITY C ON C.countrycode = Co.code GROUP BY  Co.continent ;
