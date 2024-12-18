/* mysql  &  ms sql server */
select 
    cast( sum(s.lat_n) as decimal(12,4) )

from 
    station s

where 
      1=1
  and s.lat_n > 38.7880 
  and s.lat_n < 137.2345 ;




/* mysql */ 
select 
    round( sum(s.lat_n) , 4 )

from 
    station s

where 
      1=1
  and s.lat_n > 38.7880 
  and s.lat_n < 137.2345 ;




/* mysql */ 
select 
    truncate( sum(s.lat_n) , 4 )

from 
    station s

where 
      1=1
  and s.lat_n > 38.7880 
  and s.lat_n < 137.2345 ;