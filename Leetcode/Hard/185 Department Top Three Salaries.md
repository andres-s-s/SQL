## 📝 Problem 📝

A high earner in a department is an employee who has a salary in the top 
three unique salaries for that department.

Write a solution to find the employees who are high earners in each of the departments.

Return the result table in any order.


    Table: Employee
    +--------------+---------+
    | Column Name  | Type    |
    +--------------+---------+
    | id           | int     |
    | name         | varchar |
    | salary       | int     |
    | departmentId | int     |
    +--------------+---------+
  
  
    Table: Department
    +-------------+---------+
    | Column Name | Type    |
    +-------------+---------+
    | id          | int     |
    | name        | varchar |
    +-------------+---------+





### ➡️ Solution 1  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql

with ranked_employee_salaries as  (
  select 
      e.id
    , e.name
    , e.salary
    , e.departmentId
    , dense_rank() 
        over(
          partition by 
              e.departmentid 
          order by 
              e.salary desc 
            ) 
        as ind /* For each deparment, It will create a list, the biggest salary gets 1,
                    if it's not unique all of them get 1
                    The same happens with all the 3 top salaries
                  */
  
  from 
      employee e
                                 )
--close cte



select 
    d.name as department  -- name of the deparment
  , r.name as employee    -- name of the employee
  , r.salary

from  
    ranked_employee_salaries r 

    join department d 
       on (r.ind between 1 and 3) -- Inclusive in both ends, top 3 unique salaries for that department
      and r.departmentid = d.id  ;
~~~




### ➡️ Solution 2  

**MySQL**,  **PostgreSQL**, **MS SQL Server**  


~~~sql
select 
    d.name as department -- department name
  , e.name as employee   -- employee   name
  , e.salary 

from 
    employee e

    join department d
       on e.departmentid = d.id

where 3 > (
            select 
                count(distinct m.salary) 
            
            from 
                employee m
            
            where 
                  d.id = m.departmentid 
              and m.salary > e.salary 
         );
/*
  Example:


  employee e:                              
  | department | employee | salary |       
  | ---------- | -------- | ------ |
  | IT         | Joe      | 85000  |        
  | IT         | Max      | 90000  |
  | IT         | Randy    | 85000  |
  | IT         | Will     | 70000  |  Record being processed in the first select

  Now in the subquery thanks to the where clause, employees from the same department get
  selected and the second filter, unique salaries above 70000 get counted (85000, 90000) 
  and since in this case 3 > 2 is true, this record gets selected

  If there were three unique salarys bigger than that one
  this salary would be in the top four and since 3 (number used to filter) > 3 (amount of salaries
  bigger than that one) is not true
  this would not be selected
  */
~~~