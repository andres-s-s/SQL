/* mysql  &  ms sql server */
select 
    distinct s.city 

from 
    station s

where 
      1=1
  and right(s.city,1)  not in  ("a","e","i","o","u") 
  and left(s.city , 1) not in  ("a","e","i","o","u");




/* mysql */
select 
    distinct s.city 

from 
    station s

where 
      1=1
  and s.city rlike   "^[^oiuea].*" 
  and s.city regexp  ".*[^oiuea]$";




/* mysql */
select 
    distinct s.city 

from 
    station s

where 
      1=1
  and s.city not rlike   "^[oiuea].*" 
  and s.city not regexp  ".*[oiuea]$";




/* mysql */
select 
    distinct s.city 

from 
    station s

where 
      1=1
  and regexp_like(s.city , "^[^oiuea].*[^oiuea]$" );




/* ms sql server */
select 
    distinct s.city 

from 
    station s

where 
      1=1
  and s.city not like "[aeiou]%" 
  and s.city not like "%[aeiou]";




/* ms sql server */
select 
    distinct s.city 

from 
    station s

where 
      1=1
  and s.city like "[^aeiou]%" 
  and s.city like "%[^aeiou]";




/* ms sql server */
select 
    distinct s.city 

from 
    station s

where 
      1=1
  and s.city like "[^aeiou]%[^aeiou]";