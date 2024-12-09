--mysql  &  ms sql server
select cast( min(lat_n) as decimal(12,4) ) from station 
where lat_n > 38.7780 ;



--mysql 
select round( lat_n , 4 ) from station 
where lat_n > 38.7780 order by lat_n asc limit 1;



--ms sql server
select top 1 cast( lat_n as decimal(8,4) ) from station 
where lat_n > 38.7780 order by lat_n asc;
