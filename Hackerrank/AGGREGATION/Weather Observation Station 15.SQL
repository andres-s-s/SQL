--mysql  &  ms sql server
select cast( long_w as decimal(12,4) ) from station 
where lat_n = (select max(lat_n) from station where lat_n < 137.2345 );



--mysql 
select round( long_w , 4 ) from station 
where lat_n < 137.2345 order by lat_n desc limit 1;



--ms sql server
select top 1 cast( long_w as decimal(8,4) ) from station 
where lat_n < 137.2345 order by lat_n desc ;
