/*
  Instructions:
  A median is defined as a number separating the higher half of a data set from the lower half. 
  Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer 
  to 4 decimal places.

  The STATION table is described as follows:
  id, city, state, lat_n, long_w
  */




/* mysql  &  ms sql server */
select 
    cast( s.lat_n as decimal(10,4) ) 

from 
    station s

where 
      1=1
  and   (select 
             count(*) 
         from 
             station s2
         where 
             s2.lat_n > s.lat_n ) 
      = 
        (select 
             count(*) 
         from 
             station s3
         where 
             s3.lat_n < s.lat_n ) ;
/*
  There is a count function in both subquerys, this count function needs to retrieve the 
  same amount for both subquerys therefore it will looks for a lat_n record that when all 
  lat_n records are sorted the amount of lat_n records that are bigger is the same amount as the 
  amount of lat_n records that are smaller than this s.lat_n  one
  */




/* mysql */
set @index := -1; /* Explanation of this line at the end */


select 
    round( 
            t.lat_n 
          , 4) 
            
from (
     select 
         @index := @index + 1 -- It starts with 0
           as ind 
       , s.lat_n 
     
     from 
         station s
     
     order by 
         s.lat_n    
     ) as t
/*The subquery gets a list of Northern Latitudes that is sorted and numbered*/

where 
      1=1
  and t.ind in ( 
                floor(@index/2) 
              , ceil(@index/2)  
             ) ;
/*
  In the @index variable is stored the amount of lat_n - 1
  If you have 10 objects the one in the middle are the 5 and 6 and if you do
  (10 - 1) and round the result (4.5) up and down you get 4 and 5 but if you list 
  of objects starts with the number 0, 4 and 5 happen to be in the middle
  List of ten numbers: 0,1,2,3,4,5,6,7,8,9 
                       1,2,3,4,-,-,1,2,3,4

  If you have 9 objects, an odd number
  0,1,2,3,4,5,6,7,8
  1,2,3,4,-,1,2,3,4

  That is why the variable @index is set to -1, so it starts with 0
  */




/* ms sql server */
declare @tm int;
set @tm = (select count(*) - 1 from station);



select 
    cast( t.lat_n as decimal(10,4) ) 

from 
    (select 
         row_number() 
           over(
                order by s.lat_n) 
            - 1 
            as ind 
        , s.lat_n
     from 
         station s
    ) as t

where 
      1=1
  and t.ind  in ( 
                  floor( @tm/2.00 ) 
                , ceiling( @tm/2.00 ) 
              ) ;




/* ms sql server */
set @tm = (select count(*) from station);  /*o select*/



select 
    cast( lat_n as decimal( 8, 4) ) 

from (
       select  
           lat_n 
         , row_number() 
             over( 
               order by 
                   lat_n 
                 ) 
             as num 
       
       from 
           station 
     ) as t

where  
      1=1
  and @tm % 2 = 0 
  and t.num in (@tm/2, @tm/2+1) 
   or t.num = (@tm+1)/2;




--ms sql server
declare @tm int;
set @tm = (select count(*) - 1 from station);



select 
    cast(lat_n as decimal(10,4) ) 

from (
        select 
            row_number() 
              over(
                order by 
                    lat_n) 
              - 1 
              as ind 
          , lat_n
          
          from 
              station 
     ) as t

where 
      1=1
  and ind % 2 != 0 
  and ind in (@tm/2 , @tm/2 + 1) 
    or ind = ( @tm/2) ;