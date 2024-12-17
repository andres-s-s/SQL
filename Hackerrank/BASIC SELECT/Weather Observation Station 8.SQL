/* mysql  &  ms sql server */
select 
    distinct s.city 

from 
    station s

where 
      1=1
  and right(s.city , 1) in  ("a","e","i","o","u") 
  and left(s.city , 1)  in  ("a","e","i","o","u");




/* mysql */
select 
    distinct s.city 

from 
    station s

where 
      1=1
  and s.city rlike "^[aeiou].*[aeiou]$";




/* ms sql server */
select 
    distinct s.city 

from 
    station s

where 
      1=1
  and s.city like "[aeiou]%[aeiou]";
