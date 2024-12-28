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