### ➡️ Solution 1  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
with salaries(   msl , dnm , sl , enm ) as (
  select  
      max(salary) 
        over( partition by d.id ) 
    , d.name 
    , salary 
    , e.name 
  
  from 
      employee e
  
      join department d 
         on d.id = e.departmentid
)
  
select  
    dnm as department 
  , enm as employee 
  , sl as salary

from 
    salaries 
    
where 
      sl = msl;
~~~


### ➡️ Solution 2  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
with cte( did , sl ) as (
  select 
      departmentid 
    , max(salary) 
  
  from 
      employee 
  
  group by 
      departmentid
                        )
  
  
select 
    d.name as department 
  , e.name as employee 
  , e.salary as salary

from   
    employee e 
    
    join department d
       on e.departmentid = d.id 
  
where 
      1=1
  and e.salary = (
                    select 
                        sl 
                    from 
                        cte  
                    where 
                        d.id = did  
                 );
~~~


### ➡️ Solution 3  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
with ranked_salaries as (

    select 
        e.name
      , e.salary
      , e.departmentId
      , dense_rank()
          over( partition by 
                    e.departmentId 
                order by 
                    e.salary desc )
        as rnk
    
    from 
        Employee e
)

select 
    d.name
      as Department
  , r.name
      as Employee
  , r.salary
      as Salary
from 
    ranked_salaries r

    join Department d
       on d.id = r.departmentId

where 
    r.rnk = 1
~~~


### ➡️ Solution 4  

**MySQL**,  **PostgreSQL**

~~~sql
select 
    d.name as department 
  , e.name as employee 
  , salary 

from 
    employee e 
    
    join department d 
       on d.id = e.departmentid 

where 
      1=1
  and ( e.departmentid , salary ) in 
          ( 
            select 
                departmentid 
              , max(salary) 
            
            from 
                employee 
            
            group by 
                departmentid 
          );
~~~
