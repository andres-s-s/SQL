/* mysql  &  ms sql server */
select 
    distinct s.city 

from 
    station s 

where 
      1=1
  and left(s.city , "1") not in ("a","e","i","o","u");




/* mysql */
select 
    distinct s.city 

from 
    station s 

where 
      1=1
  and s.city not rlike  "^[aeiou]";




/* mysql */
select 
    distinct s.city 

from 
    station s 

where 
      1=1
  and s.city rlike  "^[^aeiou]";




/* mysql */
select 
    distinct s.city 

from 
    station s 

where 
      1=1
  and s.regexp_like(city , "^[^aioue]");




/* ms sql server */
select 
    distinct s.city 

from 
    station s 

where 
      1=1
  and s.city not like "[aeiou]%";




/* ms sql server */
select 
    distinct s.city 

from 
    station s 

where 
      1=1
  and s.city like "[^aeiou]%";