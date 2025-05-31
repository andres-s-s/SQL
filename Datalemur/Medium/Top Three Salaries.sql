with employees_and_ranked_salaries as (
  select 
      e.name
    , e.salary
    , e.department_id
    , dense_rank()
        over(partition by 
               e.department_id 
             order by 
               e.salary desc
            )
        as ranked_salaries
  
  from 
      employee e
)

select 
    d.department_name
  , e.name
  , e.salary

from 
    employees_and_ranked_salaries e

    join department d
       on d.department_id = e.department_id

where 
    ranked_salaries in (  1 
                        , 2
                        , 3  )

order by 
    d.department_name asc
  , e.salary desc
  , e.name
;