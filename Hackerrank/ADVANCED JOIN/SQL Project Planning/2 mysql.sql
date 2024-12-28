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
-- |  solution 2: mysql
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