### ➡️ Solution 1  

**MySQL**

~~~sql  
with min_dates as (

    select 
        a.player_id
      , a.event_date
      , min(a.event_date)
          over( partition by
                    a.player_id
                order by
                    a.event_date asc )
        as min_date
    
    from 
        Activity a
)


select 
    round(
        count(case 
                when datediff( event_date , min_date ) = 1 
                then 1 
              end)
        /
        count(distinct player_id)
      , 2 
    )
    as "fraction"

from 
    min_dates  

/*
  If instead of using datediff you do event_date - min_date = 1 
  You get an error in instances like 2016-02-29 - 2016-03-01 = 1
  However on postgresql you can do it that way

  Regarding the function datediff on ms sql server the order of the dates is opposite to MySQL
*/
~~~


**PostgreSQL**  
~~~sql
with min_dates as (

    select 
        a.player_id
      , a.event_date
      , min(a.event_date)
          over( partition by
                    a.player_id
                order by
                    a.event_date asc )
        as min_date
    
    from 
        Activity a
)


select 
    round(
        count(case 
                when event_date - min_date  = 1 
                then 1 
              end)
        /
        count(distinct player_id)::decimal
      , 2 
    )
    as "fraction"

from 
    min_dates  
~~~


**MS SQL Server**  

~~~sql
with min_dates as (

    select 
        a.player_id
      , a.event_date
      , min(a.event_date)
          over( partition by
                    a.player_id
                order by
                    a.event_date asc )
        as min_date
    
    from 
        Activity a
)


select 
    round(
        count(case 
                when datediff( dd , min_date  , event_date) = 1 
                then 1 
              end)
        /
        cast( count(distinct player_id) as decimal )
      , 2 
    )
    as "fraction"

from 
    min_dates  

/*
  Regarding the function datediff the order of the dates is opposite to MySQL
*/
~~~

### ➡️ Solution 2  

**MySQL**

~~~sql
with min_dates as (

    select 
        a.player_id
      , min(a.event_date)
        as min_date
    
    from 
        Activity a

    group by 
        a.player_id
)


select 
    round(
        count(a.player_id)
        /
        count(m.player_id)
      , 2 
    )
    as "fraction"

from 
    min_dates m 

    left join Activity a
       on m.player_id = a.player_id
      and adddate(m.min_date, interval  1 day) = a.event_date
~~~

**PostgreSQL**
~~~sql
with min_dates as (

    select 
        a.player_id
      , min(a.event_date)
        as min_date
    
    from 
        Activity a

    group by 
        a.player_id
)


select 
    round(
        count(a.player_id)
        /
        count(m.player_id)::decimal
      , 2 
    )
    as "fraction"

from 
    min_dates m 

    left join Activity a
       on m.player_id = a.player_id
      and m.min_date + interval '1 day' = a.event_date
~~~


**MS SQL Server**
~~~sql
with min_dates as (

    select 
        a.player_id
      , min(a.event_date)
        as min_date
    
    from 
        Activity a

    group by 
        a.player_id
)


select 
    round(
        count(a.player_id)
        /
        cast ( count(m.player_id) as decimal )
      , 2 
    )
    as "fraction"

from 
    min_dates m 

    left join Activity a
       on m.player_id = a.player_id
      and dateadd(day, 1, m.min_date) = a.event_date
~~~


# 📖 Extra solutions 📖 



**MySQL**  

~~~sql
select 
    round(  
            count( a2.player_id ) 
          / count( a1.player_id ) 
        , 2 
         ) 
      as fraction

from 
    activity a1

    left join activity a2 
       on  a1.player_id =  a2.player_id 
      and adddate(a1.event_date, interval  1 day) = a2.event_date

where 
      1=1
  and (a1.event_date , a1.player_id ) in 
                                        (
                                            select 
                                                min(event_date) 
                                              , player_id  
                                            
                                            from 
                                                activity 
                                            
                                            group by 
                                                player_id
                                        );
  
~~~


**MS SQL Server**  
~~~sql
select 
    round(
            count( player_id)
          / cast( 
                  (
                    select 
                        count(distinct player_id) 
                          as tamnt 
                    
                    from 
                        activity
                  ) as float
                )
        , 2 
         ) 
      as fraction

from (
        select 
            player_id 
        
        from (
                select 
                    player_id 
                  , event_date 
                
                from (
                        select 
                            player_id 
                          , event_date 
                          , row_number() 
                              over(
                                partition by 
                                    player_id 
                                order by    
                                    event_date asc 
                                  ) 
                              as ind
                        
                        from 
                            activity
                     ) as t 
      
                where 
                      1=1
                  and ind = 1 
                   or ind = 2 
             ) as t2 
  
        group by 
            player_id 
  
        having 
            datediff( 
                        dd 
                      , min(event_date) 
                      , max(event_date)  
                    ) = 2 - 1
     ) as t3 ;
  
~~~



**MySQL**   
~~~sql  
select 
    round( 
            count( player_id )
          / (
              select 
                  count(distinct player_id ) 
              
              from 
                  activity) 
        , 2 
         )
      as fraction
from (
      select 
          t.player_id  
      from (
              select 
                  player_id 
                , min(event_date) 
                    as event_date
          
              from 
                  activity 
              
              group by 
                  player_id
           ) as t 
      
      join activity a 
         on a.player_id = t.player_id 
        and adddate(t.event_date, interval 1 day) = a.event_date
     ) as t2;
~~~


**MySQL**  

~~~sql  
select 
    round(
            count( player_id)
          / (
              select 
                  count(distinct player_id) 
                    as tamnt 
              from 
                  activity
            ) 
        , 2 
         ) 
      as fraction

from (
        select 
            player_id

        from (
                select 
                    player_id 
                  , event_date 
                
                from (
                        select 
                            player_id 
                          , event_date 
                          , row_number() 
                              over(
                                partition by 
                                    player_id 
                                order by 
                                    event_date asc 
                                  ) 
                              as ind
                        
                        from 
                            activity
                     ) as t 
        where 
            ind in (1 , 2 )
             ) as t2 
        
        group by 
            player_id 

        having 
            datediff( max(event_date) , min(event_date) ) =  2 - 1
     ) as t3 ;
~~~

**MySQL**  
~~~sql
select 
    round( 
            sum( tf )
          /
            count(distinct player_id) 
        , 2 
         )
      as fraction

from (
        select 
            player_id 
          , ind = 2 
            and datediff(event_date , min(event_date) 
                  over(
                    partition by 
                        player_id)
                        ) = 2 - 1 
              as tf
        
        from (
                select 
                    player_id 
                  , event_date 
                  , row_number() 
                      over(
                        partition by 
                            player_id 
                        order by 
                            event_date asc 
                          ) 
                      as ind
                
                from 
                    activity
             ) as t 
  
        where 
              ind = 1 or ind = 2 
     ) as t2;
  
  
~~~


**MS SQL Server**  
~~~sql
select 
    round( 
            count( player_id )
          / cast( 
                  (
                    select 
                        count(distinct player_id ) 
                    
                    from 
                        activity
                  ) as float
                ) 
        , 2 )
      as fraction

from (
        select 
            t.player_id  
        
        from (
                select 
                    player_id 
                  , min(event_date) 
                      as event_date
                
                from 
                    activity 
                
                group by 
                    player_id
             ) as t 

        join activity a 
           on a.player_id = t.player_id 
          and dateadd(
                          day 
                        , 1 
                        , t.event_date 
                     ) = a.event_date 
     ) as t2;
~~~


**MS SQL Server**
~~~sql
select 
    round( 
            sum( tf )
          / cast(
                  (
                    select 
                        count(distinct player_id) 
                          as tamnt 
                    
                    from 
                        activity
                  ) as float
                )
        , 2 
         )
      as fraction

from (
        select 
            player_id 
          , case 
                when ind = 2 
                 and datediff(
                                dd 
                              , min(event_date) 
                                  over(
                                    partition by 
                                      player_id)  
                              , event_date
                             ) = 2 - 1  
                then 1 
                
                else 0 
            end 
              as tf
        
        from (
                select 
                    player_id 
                  , event_date 
                  , row_number() 
                      over(
                        partition by 
                            player_id 
                        order by 
                            event_date asc 
                          ) 
                      as ind
                
                from 
                    activity
             ) as t 
  
        where 
              ind = 1 
           or ind = 2 
  
     ) as t2;
~~~


**MS SQL Server**
~~~sql
with cte as (
  select 
      min(event_date) 
        as md 
    , player_id 
    
  from 
      activity 
  
  group by 
      player_id
            )

select 
    round(  
            count( a2.player_id ) 
          / cast( 
                    count( a1.player_id ) as float 
                )
        , 2 ) 
      as fraction

from 
    activity a1

    left join activity a2 
       on a1.player_id =  a2.player_id 
      and dateadd(
                    day 
                  , 1 
                  , a1.event_date 
                 ) = a2.event_date

where 
      1=1
  and exists(
                select 
                    * 
                
                from 
                    cte 
                
                where 
                      1=1
                  and a1.event_date = md 
                  and a1.player_id = player_id );
  
~~~