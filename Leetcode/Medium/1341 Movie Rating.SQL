--mysql  &  ms sql server
select 
    * 

from (
        select 
            distinct first_value(u.name) 
                        over( 
                          order by 
                              count(*) desc 
                            , u.name asc 
                            )
              as results
            
            from 
                users u 
            
                join movierating m
                   on u.user_id = m.user_id 
            
            group by 
                u.name 
              , u.user_id
  /* limit 1 or top 1 instead of distinct */
     ) as t

union all

select 
    * 

from (
        select 
            distinct first_value( m.title ) 
                         over( 
                           order by 
                               sum(rating)
                             / cast( count(*) as float ) desc 
                             , m.title asc 
                             ) 
              as results
  
        from 
            movies m 
  
        join movierating mr
           on m.movie_id = mr.movie_id
  
        where
              1=1 
          and left( created_at , 7 ) = '2020-02'
  
        group by 
            m.title 
          , m.movie_id
  /* limit 1 or top 1 instead of distinct */
) as t2;





--mysql  
select * from (
  select u.name as results
  from users u 
  join movierating m
  on u.user_id = m.user_id 
  group by u.name , u.user_id
  order by count(*) desc , u.name asc
  limit 1 
) as t
union all 
select * from (
    select m.title as results
    from movies m 
    join movierating mr
    on m.movie_id = mr.movie_id
    where left( created_at , 7 ) = '2020-02'
--  where date_format(created_at , '%y-%m') = 
--  date_format( str_to_date( '2020-02' , '%y-%m') ,'%y-%m')
    group by m.title , m.movie_id
    order by avg(rating) desc , m.title asc
    limit 1 
) as t2;



--ms sql server
select 
    * 

from (
        select 
            top 1 u.name 
              as results
        
        from 
            users u 
    
            join movierating m
               on u.user_id = m.user_id 
    
        group by 
            u.name 
          , u.user_id
    
        order by 
            count(*) desc 
          , u.name asc

) as t

union all 

select 
    * 

from (
        select 
            top 1 m.title 
              as results
        
        from 
            movies m 
        
            join movierating mr
               on m.movie_id = mr.movie_id
        
        where
              1=1 
          and left( created_at , 7 ) = '2020-02'
    --  where concat( year(  created_at  ), month(   created_at  )) = '20202'
        
        group by 
            m.title 
          , m.movie_id
        
        order by 
            avg( 
                  cast( rating as float ) 
               ) desc 
          , m.title asc
) as t2;
