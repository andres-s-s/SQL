--mysql  &  ms sql server
with cte as (
  select 
      case 
          when income < 20000 
          then 'low salary' 
  
          when income > 50000 
          then 'high salary'
  
          else 'average salary' 
      end 
        as category 
  
  from 
      accounts 
  
  union all 
  
  select 
      'low salary' 
        as category 

  union all 
  
  select 
      'average salary' 
        as category 
  
  union all 
  
  select 
      'high salary' 
          as category  
)



select 
    category 
  , count(*) - 1 
      as accounts_count 

from 
    cte 

group by 
    category;





--mysql  &  ms sql server
select 
    'low salary' 
      as category 
  , (
      select 
          count(*) 
      
      from 
          accounts 
    
      where 
          income < 20000 
    ) as accounts_count 
 
union all 

select 
    'average salary' 
      as category 
   , (
      select 
          count(*) 
      
      from 
          accounts 
      
      where 
            1=1
        and income >= 20000 
        and income <= 50000 
     ) as accounts_count
 
union all 

select 
    'high salary' 
      as category 
  , (
      select 
          count(*) 
    
      from 
          accounts 
      
      where 
            1=1
        and income > 50000 
    ) as accounts_count 
  ;





--mysql  &  ms sql server
with cte  as (
  select 
      'low salary' 
        as category 
    
  union all

  select 
      'average salary' 
        as category 
  
  union all 
    
  select 
      'high salary' 
        as category  
             ) 


, cte2 as (
  select 
      case 
          when income < 20000 
          then 'low salary' 

          when income > 50000 then 'high salary'
          else 'average salary' 

      end 
        as category 

from 
    accounts 
          )



select 
    c.category 
  , coalesce( 
                count(c2.category) 
              , 0 ) 
      as accounts_count

from 
    cte c

    left join cte2 c2
       on c.category = c2.category 

group by 
    c.category;
