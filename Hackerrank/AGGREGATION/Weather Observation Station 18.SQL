--mysql  &  ms sql server
select cast( ( max(lat_n) - min(lat_n) ) + ( max(long_w) - min(long_w) ) 
            as decimal(12,4) )
from station ;



--mysql
select round( ( max(lat_n) - min(lat_n) ) + ( max(long_w) - min(long_w) ) 
            , 4 )
from station ;
