--mysql  &  ms sql server
select c.name from city c join country co on  co.code =  c.countrycode where co.continent = "Africa";
select c.name from city c join country co on  co.code =  c.countrycode and co.continent = "Africa";
