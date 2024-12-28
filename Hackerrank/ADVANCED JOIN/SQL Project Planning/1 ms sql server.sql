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
-- |  solution 1: ms sql server
-- +--------------------------------------------------------------------+


with start_dates as (
  select 
      p.start_date 
  
  from 
      projects p

  where 
      p.start_date not in (select end_date from projects )  
                    ) 


, projects_start_and_end_date as (
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
      ) as last_date

  from start_dates t  
                                 )



select 
    p.start_date 
  , p.last_date 

from 
    projects_start_and_end_date p
    /* 
      The secod cte already has the answer but it is not possible to sort it directly 
      because it can't used the newly created last_date field so we need to query that 
      cte so we can use last_date field to order the results
      */

order by 
    datediff(dd , p.start_date , p.last_date)
  , p.start_date;