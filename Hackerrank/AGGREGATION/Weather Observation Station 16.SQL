/* mysql  &  ms sql server */
select 
    cast( min(s.lat_n) as decimal(12,4) ) 

from 
    station s

where 
      1=1
  and s.lat_n > 38.7780 ;




/* mysql */
select 
    round( s.lat_n , 4 ) 

from 
    station s

where 
      1=1
  and s.lat_n > 38.7780 

order by 
    s.lat_n asc 

limit 1;




/* ms sql server */
select 
    top 1 cast( s.lat_n as decimal(8,4) ) 

from 
    station s 

where 
      1=1
  and s.lat_n > 38.7780 

order by 
    s.lat_n asc;
