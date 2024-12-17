/* mysql  &  ms sql server */
select 
    c.name 

from 
    city c

where 
      1=1
  and c.countrycode = "USA" 
  and c.population > 120000;
