--MySQL  &  MS SQL Server
SELECT C.name FROM CITY C JOIN COUNTRY Co ON  Co.code =  C.countrycode WHERE Co.continent = "Africa";
SELECT C.name FROM CITY C JOIN COUNTRY Co ON  Co.code =  C.countrycode AND Co.continent = "Africa";
