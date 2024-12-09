--mysql  &  ms sql server
select cast( long_w as decimal(12,4) ) from station 
where lat_n = (select min(lat_n) from station where lat_n > 38.7780 );



--mysql
select round( long_w , 4 ) from station 
where lat_n > 38.7780 order by lat_n asc limit 1;



--ms sql server
select top 1 cast( long_w as decimal(8,4) ) from station 
where lat_n > 38.7780 order by lat_n asc ;
