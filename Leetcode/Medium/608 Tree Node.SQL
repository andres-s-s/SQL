--mysql  &  ms sql server
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



--mysql  &  ms sql server
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



--mysql
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