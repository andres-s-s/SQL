/* mysql */
select 
    round( sum(s.lat_n)  , 2 )
  , round( sum(s.long_w) , 2 ) 

from 
    station s;



/* mysql  &  ms sql server */
select 
    cast( sum(s.lat_n)  as decimal(8,2) )
  , cast( sum(s.long_w) as decimal(8,2) ) 

from 
    station s;
