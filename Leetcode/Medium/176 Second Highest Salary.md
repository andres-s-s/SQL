
### ➡️ Solution 1  

**MySQL**,  **PostgreSQL**, **MS SQL Server**, **Oracle**

~~~sql
select 
    max( salary ) 
    as secondhighestsalary  

from 
    employee 

where 
      1=1
  and salary != (
                    select 
                        max( salary ) 
                    from 
                        employee 
                 )  ;
~~~

### ➡️ Solution 2  

**MySQL**,  **PostgreSQL**  

~~~sql
select
    (
      select 
          distinct 
          e.salary 
      
      from 
          employee e 
      
      order by 
          e.salary desc 
      
      limit 1 
      offset 1 

    ) as secondhighestsalary;

/*
  If you trying using a cte or getting rid of the subquery the query will not  
  return null when needed
*/
~~~


**MS SQL Server**
~~~sql
select
    (
      select
          distinct 
          e.salary

      from
          employee e

      order by
          e.salary desc
    
      offset 1 row
      fetch next 1 row only

    ) as secondhighestsalary;
~~~


### ➡️ Solution 3  

**MySQL**,  **PostgreSQL**, **MS SQL Server** 

~~~sql
select 
    min(salary) 
    as secondhighestsalary

from (  
        select 
            salary 
          , dense_rank() 
              over(order by salary desc ) 
            as seq
        from employee 
     ) as t 

where 
    seq = 2;
~~~


# 📖 Extra solutions 📖  

### ➡️ Solution 4  

**MySQL**

~~~sql
select 
    case 
        
        when count(*) = 0 
        then null 
        
        else salary 
    
      end as secondhighestsalary

from (  
        select 
            salary 
          , dense_rank() 
              over( order by salary desc ) 
            as ind
        
        from 
            employee 
     ) as t 

where 
      ind = 2;
~~~






### ➡️ Solution 5  

**MS SQL Server** 
~~~sql
with ranked_salaries as (

  select
      salary 
    , dense_rank() 
        over( order by salary desc ) 
      as ind
  
  from 
      employee 
                        )


select 
    isnull( 
            (select 
                 salary 
             from 
                 ranked_salaries
             where 
                 ind = 2
             group by 
                 salary 
            ) 
          , null 
          ) 
      as secondhighestsalary;
~~~