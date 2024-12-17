/* mysql  &  ms sql server */
select 
    c.id
  , c.name
  , c.countrycode
  , c.district
  , c.population

from 
    city c

where 
      1=1
  and c.countrycode = "USA" 
  and c.population > 100000;
