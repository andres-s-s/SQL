--mysql  &  ms sql server
select sum(c.population) from city c join country co on co.code =  c.countrycode where co.continent = "Asia";
select sum(c.population) from city c join country co on co.code =  c.countrycode and co.continent = "Asia";
