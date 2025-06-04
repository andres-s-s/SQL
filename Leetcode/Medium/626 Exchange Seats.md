### ➡️ Solution 1  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
select 
    s.id
  , case
      when id % 2 = 0 
        then lag(student)
                over(order by id)
        else coalesce( 
                lead(student)
                    over(order by id)
              , student
            )
    end 
    as "student"
    
from 
    Seat s

order by 
        s.id
~~~


### ➡️ Solution 2  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
select 
    row_number() 
      over(
        order by 
            (
                case 
                    when id % 2 = 0 
                    then id - 1 
                    
                    else id + 1 
                end 
            ) asc 
          ) 

      as id
 , student 

from 
    seat;
~~~


# 📖 Extra solutions 📖  

### ➡️ Solution 3  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
with cte as ( 
  select 
      id 
    , student    

from 
    seat    

where 
      1=1
  and id % 2 != 0 
  and id = (select count(*) from seat )

union all 
  
select 
    s1.id 
  , s2.student 

from 
    seat s1 
    
    join seat s2 
       on s1.id - 1 = s2.id 

where 
    s1.id % 2  = 0 
  
union all 
  
select 
    s1.id 
  , s2.student 

from 
    seat s1 
    
    join seat s2 
       on s1.id + 1 = s2.id 

where 
      s1.id % 2 != 0 
)
select 
    * 

from 
    cte 

order by 
    id asc ; 
~~~