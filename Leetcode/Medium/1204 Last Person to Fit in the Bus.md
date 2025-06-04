### ➡️ Solution 1  

**MySQL**,  **PostgreSQL**

~~~sql
with on_the_bus as (
    select 
        person_name
      , sum(weight)
          over(order by turn asc)
        as total_weight

    from 
        Queue
)

select 
    person_name

from 
    on_the_bus

where 
    total_weight <= 1000


order by 
    total_weight desc

limit 1
~~~

**MS SQL Server**

~~~sql
with on_the_bus as (
    select 
        person_name
      , sum(weight)
          over(order by turn asc)
        as total_weight

    from 
        Queue
)

select 
    top 1
    person_name

from 
    on_the_bus

where 
    total_weight <= 1000


order by 
    total_weight desc
~~~


# 📖 Extra solutions 📖  

### ➡️ Solution 2  

**MySQL**,  **PostgreSQL**

~~~sql 
select   
    q1.person_name 

from 
    queue q1 
    
    join queue q2 
       on q1.turn >= q2.turn 

group by 
    q1.person_name 

having   
    sum( q2.weight ) <= 1000

order by 
    sum( q2.weight ) desc 

limit 1 ;
~~~  

**MS SQL Server**

~~~sql 
select   
    top 1 q1.person_name 

from 
    queue q1 
    
    join queue q2 
       on q1.turn >= q2.turn 

group by 
    q1.person_name 

having   
    sum( q2.weight ) <= 1000

order by 
    sum( q2.weight ) desc ;
~~~  
