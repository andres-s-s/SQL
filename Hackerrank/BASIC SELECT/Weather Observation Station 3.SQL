--mysql  &  ms sql server
select distinct city from station where id % 2 = 0;
--mysql
select distinct city from station where mod(id , 2 ) = 0;
