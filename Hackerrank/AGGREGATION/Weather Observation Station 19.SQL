/* mysql  &  ms sql server */
select 
    cast( 
      sqrt(   
            power( max(s.lat_n)  -  min(s.lat_n)   ,  2 ) 
          + power( max(s.long_w) -  min(s.long_w)  ,  2 ) 
          )
      as decimal(12,4)  )

from 
    station s;



/* mysql */
select 
    round( 
        sqrt(  
            power( max(s.lat_n) -  min(s.lat_n)  , 2 ) 
          + power( max(s.long_w) - min(s.long_w) , 2 ) 
            )
      , 4 )

from 
    station s;



/* ms sql server */
select 
    cast( 
      sqrt(   
            square( max(s.lat_n) -  min(s.lat_n)   ) 
          + square( max(s.long_w) - min(s.long_w)  ) 
            )
      as decimal(12,4)  )

from 
    station s;
