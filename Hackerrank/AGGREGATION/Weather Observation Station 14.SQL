/* mysql  &  ms sql server */
select 
    cast( max(s.lat_n)  as decimal(12,4) )

from 
    station s

where 
    s.lat_n < 137.2345 ;




/* mysql */
select 
    round( max(s.lat_n) , 4 )

from 
    station s

where 
      1=1
  and s.lat_n < 137.2345 ;



/* mysql */
select 
    truncate( s.lat_n , 4 )

from 
    station s

where 
      1=1
  and s.lat_n < 137.2345 
  
order by 
    s.lat_n desc limit 1 ;




/* ms sql server */
select 
    top 1 cast( s.lat_n  as decimal(12,4) )

from 
    station s

where 
      1=1
  and s.lat_n < 137.2345 

order by 
    s.lat_n desc ;
