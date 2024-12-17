/* mysql */
select 
    s.city 
  , length(s.city) 

from 
    station s

order by 
    length(s.city) asc  
  , s.city limit 1;



select 
    s.city 
  , length(s.city) 

from 
    station s

order by 
    length(s.city) desc 
  , s.city limit 1;




/* ms sql server */
select 
    top 1 s.city 
  , len(s.city) 

from 
    station s 

order by 
    len(s.city) asc  
  , s.city;



select 
    top 1 s.city 
  , len(s.city) 

from 
    station s 

order by 
    len(s.city) desc 
  , s.city;
