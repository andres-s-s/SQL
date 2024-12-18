/* mysql  &  ms sql server */
select 
    sum(c.population) 

from 
    city c

where 
      1=1
  and c.countrycode = "JPN";
