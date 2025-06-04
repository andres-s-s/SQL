### ➡️ Solution 1 

**MySQL**,  **PostgreSQL**

~~~sql
(
select 
    u.name
      as results

from 
    MovieRating m

    join Users u
       on u.user_id = m.user_id

group by 
    m.user_id
  , u.name

order by
    count(*) desc
  , u.name asc

limit 1
)

union all


(
select 
    m.title
      as results

from 
    MovieRating mr

    join Movies m
       on mr.movie_id = m.movie_id

where 
      mr.created_at between '2020-02-01' and '2020-02-28'

group by 
    mr.movie_id
  , m.title

order by
    avg(mr.rating) desc
  , m.title asc

limit 1
)
~~~

**MS SQL Server**

~~~sql
select 
    results
from

(
    select 
        top 1
        u.name
          as results
    
    from 
        MovieRating m
    
        join Users u
           on u.user_id = m.user_id
    
    group by 
        m.user_id
      , u.name
    
    order by
        count(*) desc
      , u.name asc
) as user_result

union all


select 
    results
from
    (
    select 
        top 1
        m.title
          as results
    
    from 
        MovieRating mr
    
        join Movies m
           on mr.movie_id = m.movie_id
    
    where 
          mr.created_at between '2020-02-01' and '2020-02-28'
       -- concat( year(  created_at  ), month(   created_at  )) = '20202'
    
    group by 
        mr.movie_id
      , m.title
    
    order by
        avg( cast(mr.rating as decimal) ) desc
      , m.title asc
) as movie_result
~~~

### ➡️ Solution 2  

**MySQL**, **MS SQL Server**

~~~sql
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
~~~


