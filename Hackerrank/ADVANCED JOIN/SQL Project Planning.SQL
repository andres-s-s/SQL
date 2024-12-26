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










/* mysql */

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




/* mysql */

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
            min(p.end_date) 
      
        from 
            projects p
     
        where 
              1=1
          and p.end_date not in (select start_date from projects)  
          and p.end_date > s.start_date 
    ) as end_date

from 
    start_dates s

order by 
    end_date - s.start_date 
  , s.start_date;




/* mysql */
select 
    t1.start_date 
  , t2.end_date 
 
from (
        select 
            p.start_date 
          , row_number() 
              over(
                order by 
                    p.start_date 
                  ) 
              as ind 
        
        from 
            projects p 
        
        where 
            p.start_date not in (select end_date from projects )  
    ) as t1

    join (
            select 
                p.end_date   
              , row_number() 
                  over(
                    order by 
                        p.end_date 
                      )
                  as ind 
         
            from 
                projects p
            
            where 
                p.end_date not in (select start_date from projects)   
         ) as t2
       on t1.ind = t2.ind 

order by 
    datediff( t2.end_date , t1.start_date )
  , t1.start_date;




/* mysql */
select 
    t1.start_date 
  , t2.end_date 

from (
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
    ) as t1

  join (
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
    ) as t2
     on t1.ind = t2.ind 
     
order by 
    datediff(  t2.end_date , t1.start_date )
  , t1.start_date;




/* mysql */
select 
    min(t2.start_date) 
  , max(t2.end_date) 

from (
        select 
            t.start_date 
          , t.end_date 
          , sum(t.tf) 
              over(
                order by 
                    t.start_date
                  ) 
              as same_proj
    
        from (
                select 
                    p.start_date 
                  , p.end_date 
                  , case 
                        when lag(p.end_date) 
                               over(
                                 order by 
                                     p.start_date
                                   ) = p.start_date
                        then 0 
                        else 1 
                      
                      end as tf
                
                from 
                    projects p
              ) t
     ) as t2

group by 
    t2.same_proj

order by 
    datediff( max(end_date) , min(start_date) )
  , min(start_date);




/* mysql */
select 
    min(t2.start_date) 
  , max(t2.end_date) 

from (
        select 
            t.start_date 
          , t.end_date 
          , sum(t.tf) 
              over(
                order by 
                    start_date
                  ) 
              as same_proj
        from (
                select 
                    p.start_date 
                  , p.end_date 
                  , if( 
                        lag(p.end_date) 
                          over(
                            order by 
                                p.start_date
                              ) = start_date 
                      , 0 
                      , 1 
                      )  
                      as tf
                from 
                    projects p
             ) t
     ) as t2

group by 
    t2.same_proj

order by 
    datediff( max(t2.end_date) , min(t2.start_date) )
  , min(t2.start_date);




/* ms sql server */
select 
    t1.start_date 
  , t1.end_date 

from (
        select 
            t.start_date 
          , (
                select 
                    top 1 p.end_date 
                
                from 
                    projects p
                
                where
                      1=1 
                  and p.end_date not in (select start_date from projects)  
                  and p.end_date > t.start_date 
                
                order by 
                    end_date 
            ) as end_date
        from (
                select 
                    p.start_date 
                
                from 
                    projects p
                
                where 
                    p.start_date not in (select end_date from projects )  
             ) as t  
     ) t1

order by 
    datediff(dd , t1.start_date , t1.end_date)
  , t1.start_date;




/* ms sql server */
select 
    t1.start_date 
  , t2.end_date 

from (
        select 
            p.start_date 
          , row_number() 
              over(
                order by 
                    p.start_date 
                  ) 
              as ind 
        
        from 
            projects p
        
        where 
            p.start_date not in (select end_date from projects )  
     ) as t1

    join (
            select 
                p.end_date
              , row_number() 
                  over(
                    order by 
                        p.end_date 
                      )   
                  as ind 
            
            from 
                projects p
            
            where 
                p.end_date not in (select start_date from projects)   
         ) as t2
         on t1.ind = t2.ind 

order by 
    datediff( dd, t1.start_date, t2.end_date)
  , t1.start_date;




/* ms sql server */
select 
    min(t2.start_date) 
  , max(t2.end_date) 

from (  
        select 
            t.start_date 
          , t.end_date 
          , sum(t.tf) 
              over(
                order by 
                    start_date
                  ) 
              as p
        from (
                select 
                    p.start_date 
                  , p.end_date 
                  , case 
                      when 
                        lag(p.end_date) 
                          over(
                            order by 
                                p.start_date
                              ) = p.start_date
                      then 0 
                      else 1 

                    end as tf
                from 
                    projects p
             ) t
     ) as t2

group by 
    t2.p

order by 
    datediff( dd, min(t2.start_date) , max(t2.end_date) )
  , min(t2.start_date);