--mysql  &  ms sql server
select cast( lat_n as decimal(10,4) ) from station s 
where (select count(*) from station where lat_n > s.lat_n ) =
      (select count(*) from station where lat_n < s.lat_n ) ;



--mysql
set @index := -1;
select round(lat_n,4) from 
        (select @index := @index + 1 as ind , 
         lat_n from station order by lat_n    ) as t
where ind in ( floor(@index/2) , ceil(@index/2) ) ;



--ms sql server
declare @tm int;
set @tm = (select count(*) - 1 from station);
select cast(lat_n as decimal(10,4) ) from 
         (select row_number() over(order by lat_n) - 1 as ind , lat_n
          from station ) as t
where ind  in ( floor( @tm/2.00 ) , ceiling( @tm/2.00 ) ) ;



--ms sql server
set @tm = (select count(*) from station);  /*o select*/
select cast( lat_n as decimal( 8, 4) ) from 
    (select  lat_n , row_number() over( order by lat_n ) as num 
     from station ) as t
where  @tm % 2 = 0 and t.num in (@tm/2, @tm/2+1) or t.num = (@tm+1)/2;



--ms sql server
declare @tm int;
set @tm = (select count(*) - 1 from station);
select cast(lat_n as decimal(10,4) ) from 
         (select row_number() over(order by lat_n) - 1 as ind , lat_n
          from station ) as t
where ind % 2 != 0 and ind in (@tm/2 , @tm/2 + 1) or ind = ( @tm/2) ;
