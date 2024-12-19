/* mysql  &  ms sql server */
select 
    co.continent 
  , floor(avg(c.population)) 

from country co 

join city c 
   on c.countrycode = co.code 

group by  
    co.continent ;
