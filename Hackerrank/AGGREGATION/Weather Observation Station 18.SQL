/* mysql  &  ms sql server */
select 
    cast( 
            ( max(s.lat_n)  - min(s.lat_n) ) 
          + ( max(s.long_w) - min(s.long_w) ) 
      as decimal(12,4) )

from 
    station s;




/* mysql */
select 
    round( 
            ( max(s.lat_n) - min(s.lat_n) ) 
          + ( max(s.long_w) - min(s.long_w) ) 
          , 4 
         )

from 
    station s;
