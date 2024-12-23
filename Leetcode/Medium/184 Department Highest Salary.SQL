--mysql  &  ms sql server
with cte( did , sl ) as (
  select 
      departmentid 
    , max(salary) 
  
  from 
      employee 
  
  group by 
      departmentid
                        )
  
  
select 
    d.name as department 
  , e.name as employee 
  , e.salary as salary

from   
    employee e 
    
    join department d
       on e.departmentid = d.id 
  
where 
      1=1
  and e.salary = (
                    select 
                        sl 
                    from 
                        cte  
                    where 
                        d.id = did  
                 );
  
  
  
  --mysql  &  ms sql server
with cte(   msl , dn , sl , en ) as (
  select  
      max(salary) 
        over(
          partition by 
              d.id 
            ) 
    , d.name 
    , salary 
    , e.name 
  
  from 
      employee e
  
      join department d 
         on d.id = e.departmentid
                                    )
  
select  
    dn as department 
  , en as employee 
  , sl as salary

from 
    cte 
    
where 
      sl = msl;
  
  
  
  --mysql 
select 
    d.name as department 
  , e.name as employee 
  , salary 

from 
    employee e 
    
    join department d 
       on d.id = e.departmentid 

where 
      1=1
  and ( e.departmentid , salary ) in 
          ( 
            select 
                departmentid 
              , max(salary) 
            
            from 
                employee 
            
            group by 
                departmentid 
          );
  