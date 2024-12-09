--mysql  &  ms sql server
select cast( max(lat_n)  as decimal(12,4) )
from station
where lat_n < 137.2345 ;



--mysql
select round( max(lat_n) , 4 )
from station
where lat_n < 137.2345 ;



--mysql
select truncate( lat_n , 4 )
from station
where lat_n < 137.2345 order by lat_n desc limit 1 ;



--ms sql server
select top 1 cast( lat_n  as decimal(12,4) )
from station
where lat_n < 137.2345 order by lat_n desc ;
