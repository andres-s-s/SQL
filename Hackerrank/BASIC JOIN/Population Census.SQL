--MySQL  &  MS SQL Server
SELECT SUM(C.population) FROM CITY C JOIN COUNTRY Co ON Co.code =  C.countrycode WHERE Co.continent = "Asia";
SELECT SUM(C.population) FROM CITY C JOIN COUNTRY Co ON Co.code =  C.countrycode AND Co.continent = "Asia";
