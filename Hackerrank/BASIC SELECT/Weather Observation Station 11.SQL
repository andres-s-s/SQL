/* mysql  &  ms sql server */
select 
    distinct s.city 

from 
    station s 

where 
      1=1
  and right(s.city,1)  not in  ("a","e","i","o","u") 
   or left(s.city , 1) not in  ("a","e","i","o","u");




/* mysql */
select 
    distinct s.city 

from 
    station s

where 
      1=1
  and s.city rlike   "^[^oiuea].*" 
   or s.city regexp  ".*[^oiuea]$";




/* mysql */
select 
    distinct s.city 

from 
    station s

where 
      1=1
  and s.city not rlike   "^[oiuea].*" 
   or s.city not regexp  ".*[oiuea]$";




/* ms sql server */
select 
    distinct s.city 

from 
    station s 

where 
      1=1
  and s.city not like "[aeiou]%" 
   or s.city not like "%[aeiou]";




/* ms sql server */
select 
    distinct s.city 

from 
    station s

where 
      1=1
  and s.city like "[^aeiou]%" 
   or s.city like "%[^aeiou]";