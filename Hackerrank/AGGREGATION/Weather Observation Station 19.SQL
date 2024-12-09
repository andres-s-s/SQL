--mysql  &  ms sql server
select cast( 
      sqrt(   power( max(lat_n) -  min(lat_n)  ,2 ) + 
              power( max(long_w) - min(long_w) ,2 ) )
    as decimal(12,4)  )
from station ;



--mysql
select round( 
      sqrt(   power( max(lat_n) -  min(lat_n)  ,2 ) + 
              power( max(long_w) - min(long_w) ,2 ) )
    , 4 )
from station ;



--ms sql server
select cast( 
      sqrt(   square( max(lat_n) -  min(lat_n)   ) + 
              square( max(long_w) - min(long_w)  ) )
    as decimal(12,4)  )
from station ;
