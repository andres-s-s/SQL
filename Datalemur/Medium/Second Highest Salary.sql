with salaries as (
  select 
      salary
    , dense_rank()
        over(order by salary desc)
        as ranked_salaries
  
  from 
      employee e
)

select 
    distinct salary

from 
    salaries

where 
    ranked_salaries = 2