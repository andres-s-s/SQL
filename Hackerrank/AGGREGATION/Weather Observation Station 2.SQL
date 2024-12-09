--mysql
select round( sum(lat_n) , 2 ), round( sum(long_w) , 2 ) from station;



--mysql  &  ms sql server
select cast( sum(lat_n)  as decimal(8,2) ),
       cast( sum(long_w) as decimal(8,2) ) 
from station;
