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
