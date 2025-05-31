/*
  You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. 
  It is guaranteed that the difference between the End_Date and the Start_Date is equal 
  to 1 day for each row in the table.

  If the End_Date of the tasks are consecutive, then they are part of the same project

  Write a query to output the start and end dates of projects listed by the number of days 
  it took to complete the project in ascending order. If there is more than one project 
  that have the same number of completion days, then order by the start date of the project.

  Column          Type
  Task_id         Integer
  Start_Date      Date
  End_Date        Date
  */










-- +--------------------------------------------------------------------+
-- |  solution 1: mysql
-- +--------------------------------------------------------------------+


with start_dates as (
  select 
      p.start_date 
  
  from 
      projects p
  
  where 
      p.start_date not in (
                            select 
                                end_date 
                            from 
                                projects 
                          )  
                    ) 



select 
    s.start_date 
  , (
        select 
            p.end_date 

        from 
            projects p

        where 
              1=1
          and p.end_date not in (select start_date from projects)  
          and p.end_date > s.start_date 

        order by 
            p.end_date 

        limit 1 
    ) as end_date 

from 
    start_dates s

order by 
    end_date - s.start_date 
  , s.start_date;






-- +--------------------------------------------------------------------+
-- |  solution 2: mysql
-- +--------------------------------------------------------------------+


with start_dates as (
  select 
      p.start_date
  from 
      Projects p
  where 
         1=1
    and p.start_date not in 
                   (select end_date from Projects)
)


, end_dates as (
  select 
      p.end_date
  
  from 
     Projects p
  
  where
         1=1
    and p.end_date not in 
                   (select start_date from Projects)
)

select 
    s.start_date
  , (
        select min(e.end_date)
        from end_dates e
        where e.end_date > s.start_date
    ) 
      as end_date

from
    start_dates s

order by 
    end_date - s.start_date asc
  , s.start_date




-- +--------------------------------------------------------------------+
-- |  solution 3: mysql
-- +--------------------------------------------------------------------+

with start_dates as (
  select 
      p.start_date
    , row_number() 
        over(order by p.start_date asc)
        as seq
  from 
      Projects p
  where 
         1=1
    and p.start_date not in 
                   (select end_date from Projects)
)


, end_dates as (
  select 
      p.end_date
    , row_number() 
        over(order by p.end_date asc)
        as seq
  from 
     Projects p
  
  where
         1=1
    and p.end_date not in 
                   (select start_date from Projects)
)

select 
    s.start_date
  , e.end_date

from
    start_dates s

    join end_dates e
       on e.seq = s.seq
      
order by 
    e.end_date - s.start_date asc
  , s.start_date





-- +--------------------------------------------------------------------+
-- |  solution 4: mysql
-- +--------------------------------------------------------------------+


with start_dates as (
  select 
      p.start_date 
    , @num := @num + 1 
        as ind 
  
  from 
      projects p
    , (select @num := 0) 
        as nt
  
  where 
      p.start_date not in (select end_date from projects ) 

  order by 
      p.start_date
                    ) 


, end_dates as (
  select 
      p.end_date  
    , @numb := @numb + 1 
        as ind  
  
  from 
      projects p
    , (select @numb := 0) 
        as nt 
  
  where 
      p.end_date not in (select start_date from projects)   
  
  order by 
      p.end_date
               ) 


select 
    s.start_date 
  , e.end_date 

from 
    start_dates s

    join end_dates e
       on s.ind = e.ind 
     
order by 
    datediff(  e.end_date , s.start_date )
  , s.start_date;




-- +--------------------------------------------------------------------+
-- |  solution 5: mysql
-- +--------------------------------------------------------------------+

with new_projects as  (
    select
        p.start_date 
      , p.end_date 
      , case 
            when lag(p.end_date) 
                   over(
                     order by 
                         p.start_date
                       ) = p.start_date
            then 0 -- If the previous end_date and the current start_date are the same
            else 1 -- If they are not the same 
          
          end as tf
    
    from 
        projects p
                      )


, same_projects as (
  select 
      n.start_date 
    , n.end_date 
    , sum(n.tf) 
        over(
          order by 
              n.start_date
            ) 
        as same_proj

  from 
      new_projects n
               ) 



select 
    min(s.start_date) 
  , max(s.end_date) 

from 
    same_projects s

group by 
    s.same_proj

order by 
    datediff( max(s.end_date) , min(s.start_date) )
  , min(s.start_date);



-- +--------------------------------------------------------------------+
-- |  solution 6: mysql
-- +--------------------------------------------------------------------+


with new_projects as (
  select 
      p.start_date 
    , p.end_date 
    , if( 
          lag(p.end_date) 
            over(
              order by 
                  p.start_date
                ) = start_date 
        , 0 -- If the previous end_date and the current start_date are the same
        , 1 -- If they are not the same 
        )  
        as tf
  from 
            projects p
             )


, same_projects as (
  select 
      n.start_date 
    , n.end_date 
    , sum(n.tf) 
        over(
          order by 
              n.start_date
            ) 
        as same_proj

  from 
      new_projects n
               ) 


select 
    min(s.start_date) 
  , max(s.end_date) 

from 
    same_projects s

group by 
    s.same_proj

order by 
    datediff( max(s.end_date) , min(s.start_date) )
  , min(s.start_date);




-- +--------------------------------------------------------------------+
-- |  solution 7: ms sql server
-- +--------------------------------------------------------------------+


with start_dates as (
  select 
      p.start_date
  from 
      Projects p
  where 
         1=1
    and p.start_date not in 
                   (select end_date from Projects)
)


, end_dates as (
  select 
      p.end_date
  
  from 
     Projects p
  
  where
         1=1
    and p.end_date not in 
                   (select start_date from Projects)
)

, final_result as ( -- it's not sorted yet
select 
    s.start_date
  , (
        select min(e.end_date)
        from end_dates e
        where e.end_date > s.start_date
    ) 
      as end_date

from
    start_dates s

)

select 
    f.start_date
  , f.end_date

from 
    final_result f

order by 
    datediff(dd , f.start_date , f.end_date) asc
  , f.start_date




-- +--------------------------------------------------------------------+
-- |  solution 7: ms sql server
-- +--------------------------------------------------------------------+


with start_dates as (
  select 
      p.start_date
    , row_number() 
        over(order by p.start_date asc)
        as seq
  from 
      Projects p
  where 
         1=1
    and p.start_date not in 
                   (select end_date from Projects)
)


, end_dates as (
  select 
      p.end_date
    , row_number() 
        over(order by p.end_date asc)
        as seq
  from 
     Projects p
  
  where
         1=1
    and p.end_date not in 
                   (select start_date from Projects)
)

select 
    s.start_date
  , e.end_date

from
    start_dates s

    join end_dates e
       on e.seq = s.seq

order by 
    datediff(dd, s.start_date  , e.end_date ) asc
  , s.start_date;



-- +--------------------------------------------------------------------+
-- |  solution 7: ms sql server
-- +--------------------------------------------------------------------+


with new_projects as  (
    select
        p.start_date 
      , p.end_date 
      , case 
            when lag(p.end_date) 
                   over(
                     order by 
                         p.start_date
                       ) = p.start_date
            then 0 -- If the previous end_date and the current start_date are the same
            else 1 -- If they are not the same 
          
          end as tf
    
    from 
        projects p
                      )


, same_projects as (
  select 
      n.start_date 
    , n.end_date 
    , sum(n.tf) 
        over(
          order by 
              n.start_date
            ) 
        as same_proj

  from 
      new_projects n
               ) 



select 
    min(s.start_date) 
  , max(s.end_date) 

from 
    same_projects s

group by 
    s.same_proj

order by 
    datediff( dd, min(s.start_date) , max(s.end_date) )
  , min(s.start_date);
