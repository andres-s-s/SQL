### ➡️ Solution 1  

**MySQL**,  **PostgreSQL**, **MS SQL Server**  

~~~sql
select  
    e.name 

from 
    employee e 
    
    join employee e2
       on e.id = e2.managerid 

group by 
    e.name 
  , e.id

having 
    count(*) >= 5;
~~~



### ➡️ Solution 2  


**MySQL**,  **PostgreSQL**, **MS SQL Server**  

~~~sql
with managers as (

    select 
        e.managerId

    from 
        Employee e

    group by 
        e.managerId

    having 
        count(*) >= 5 
)


select 
    e.name

from 
    Employee e

    join managers m
       on m.managerId = e.id
~~~





### ➡️ Solution 3  

~~~sql
select 
    e.name 

from 
    employee e

where 
      1=1
  and e.id in (
              select 
                  managerid 
              
              from 
                  employee 
              
              group by 
                  managerid 
             
              having 
                  count(*) >= 5  
            );
~~~