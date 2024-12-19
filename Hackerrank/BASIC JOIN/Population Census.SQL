/* mysql  &  ms sql server */
select 
    sum(c.population) 

from 
    city c 
    
    join country co 
       on co.code =  c.countrycode 

where 
      1=1
  and co.continent = "Asia";




/* mysql  &  ms sql server */
select 
    sum(c.population) 

from 
    city c 

    join country co 
       on co.code =  c.countrycode 
      and co.continent = "Asia";
