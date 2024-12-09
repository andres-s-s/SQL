--mysql
select city , length(city) from station order by length(city) asc  , city limit 1;
select city , length(city) from station order by length(city) desc , city limit 1;



--ms sql server
select top 1 city , len(city) from station order by len(city) asc  , city;
select top 1 city , len(city) from station order by len(city) desc , city;
