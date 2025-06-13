### ➡️ Solution 1  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
with cte as (
  select 
      distinct p_id 
  
  from 
      tree)

select 
    id 
  , case 
        when p_id is null 
        then 'root' 
     
        when id in (select p_id from cte ) 
        then 'inner'  
     
        else 'leaf'
    
      end as 'type'

from 
    tree ; 
~~~


### ➡️ Solution 2  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
with cte as (
  select 
      distinct p_id 
  
  from 
      tree)

select 
    id 
  , case 
        when t.p_id is null 
        then 'root' 
        
        when c.p_id is null 
        then 'leaf'  
   
        else 'inner'
      
      end as 'type'

from 
    tree t 
    
    left join cte c 
       on t.id = c.p_id ; 
~~~


# 📖 Extra solutions 📖  

### ➡️ Solution 3

**MySQL**

~~~sql
with cte as (
  select 
      distinct p_id 
  
  from 
      tree  )



select 
    id 
  , if(p_id is null 
      , "root" 
      , if(
              id in (select p_id from cte ) 
            , "inner" 
            , "leaf") 
          ) 
    as type

from 
    tree ; 
~~~