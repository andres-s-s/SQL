
### ➡️ Solution 1  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
with categories as (

select 
    case 
        when income < 20000 
        then 'Low Salary'
        
        when income between 20000 and 50000
        then 'Average Salary'
  
        else 'High Salary'
    end
    as category

from 
    Accounts

union all

select 
    'Low Salary'
    as category

union all

select 
    'Average Salary'
    as category

union all

select 
    'High Salary'
    as category
)


select 
    category
  , count(*) - 1
    as accounts_count

from 
    categories 

group by 
    category
~~~





### ➡️ Solution 2  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
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
~~~



