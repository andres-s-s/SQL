/* mysql  &  ms sql server */
select 
    distinct city 

from 
    station 

where 
      1=1
  and right(city , 1) in  ("a","e","i","o","u");



/* mysql */
select 
    distinct city 

from 
    station 

where 
      1=1
  and city rlike  "^.*[aeiou]$";



/* ms sql server */
select 
    distinct city 

from 
    station 

where 
      1=1
  and city like '%[aeiou]';
