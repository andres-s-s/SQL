--mysql  &  ms sql server
select 
    round( 
            sum( tiv_2016 ) 
          , 2 
         ) 
      as tiv_2016 from insurance i

where 
      1=1
  and tiv_2015 in (
                    select 
                        tiv_2015 
                    
                    from 
                        insurance 
                    
                    group by 
                        tiv_2015 
                    
                    having 
                        count(*) > 1 
                  )
  and exists  (
                    select 
                        lat 
                      , lon 
                    
                    from 
                        insurance 
                    
                    where 
                          i.lat = lat 
                      and i.lon = lon
             
                    group by 
                        lat 
                      , lon  
                    
                    having 
                        count(*) = 1 );



--mysql  &  ms sql server
with cte  as (
  select 
      tiv_2015 
   
  from 
      insurance 
              
  group by 
      tiv_2015 
  
  having 
      count(*) > 1 
             )


, cte2 as (
  select 
      lat 
    , lon 
  
  from 
      insurance  

  group by 
      lat 
    , lon

  having 
      count(*) = 1 )



select 
    round ( 
              sum( tiv_2016 ) 
            , 2 
          ) 
      as tiv_2016 

from 
    insurance i

    join cte2 as c 
       on c.lat = i.lat 
      and c.lon = i.lon

where 
      1=1
  and i.tiv_2015 in ( 
                        select 
                            tiv_2015 
                        from 
                            cte )
  and c.lat is not null ;



--mysql  &  ms sql server ---fastest
with cte (tiv_2016 , tiv_2015c , latlonc ) as (
  select 
      tiv_2016 
    , count(*) 
        over( 
          partition by 
              tiv_2015 ) 
    , count(*) 
        over( 
          partition by 
              lat 
            , lon
            )
  
  from 
      insurance 
)

select 
    round( 
            sum( tiv_2016 ) 
          , 2 
         ) 
      as tiv_2016 
      
from 
    cte 

where 
      1=1
  and tiv_2015c > 1 
  and latlonc = 1 ; 



--mysql 
select 
    round( 
            sum( tiv_2016 ) 
          , 2 
         ) 
      as tiv_2016 

from 
    insurance 

where 
      1=1
  and tiv_2015  in (
                    select 
                        tiv_2015 
                    
                    from 
                        insurance 
                    
                    group by 
                        tiv_2015 
                    
                    having 
                        count(*) > 1 
                   )
  and (lat,lon) in (
                    select 
                        lat 
                      , lon 
                    
                    from 
                        insurance 
                    
                    group by 
                        lat 
                      , lon 
                   
                    having 
                        count(*) = 1 
                   );



--mysql 
select 
    round( 
            sum( tiv_2016 ) 
          , 2 
         ) 
      as tiv_2016 

from (   
        select 
            *  
        
        from 
            insurance  
        
        group by 
            lat 
          , lon  
        
        having
              1=1 
          and count(*) = 1 
          and tiv_2015 in ( select 
                                tiv_2015 
                            
                            from 
                                insurance 
                            
                            group by 
                                tiv_2015 
                            
                            having 
                                count(*)>1 )

     ) as t ;
