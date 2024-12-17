/* mysql  &  ms sql server */
select 
    distinct s.city 

from 
    station s

where 
      1=1
  and right(s.city , 1) not in  ("a","e","i","o","u") ;
  /*From right to left take one character and make sure it is not a vowel */


/* mysql */
select 
    distinct s.city 

from 
    station s

where 
      1=1
  and s.city regexp  ".*[^oiuea]$";
/*  
  Alternatives for the where clause

  and s.city not regexp  ".*[oiuea]$"   

  and not regexp_like(s.city , "[aioue]$");   

  and regexp_like(s.city , "[^aioue]$");   
    
  and s.city rlike  ".*[^oiuea]$";   

  and s.city not rlike  ".*[oiuea]$";   
  */




/* ms sql server */
select 
    distinct s.city 

from 
    station s

where 
      1=1
  and s.city like "%[^aeiou]";
--and s.city not like "%[aeiou]" --Alternative;
