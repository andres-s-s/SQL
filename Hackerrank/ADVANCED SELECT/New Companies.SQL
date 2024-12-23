/* mysql  &  ms sql server */
select 
    c.company_code 
  , c.founder 
  , count(distinct lm.lead_manager_code)
  , count(distinct sm.senior_manager_code)
  , count(distinct m.manager_code)
  , count(distinct e.employee_code)

from 
    company c 

    join lead_manager lm 
       on c.company_code = lm.company_code

    join senior_manager sm 
       on sm.lead_manager_code = lm.lead_manager_code
      
    join manager m 
       on m.senior_manager_code = sm.senior_manager_code

    join employee e 
       on e.manager_code = m.manager_code 

group by 
    c.company_code 
  , c.founder

order by 
    c.company_code asc ;




/* mysql  &  ms sql server */
select 
    c.company_code 
  , c.founder 
  , count(distinct lm.lead_manager_code)  
  , count(distinct sm.senior_manager_code)  
  , count(distinct m.manager_code)
  , count(distinct e.employee_code)

from 
    company c  
  , lead_manager lm
  , senior_manager sm 
  , manager m 
  , employee e 

where 
      1=1
  and e.manager_code         =  m.manager_code 
  and m.senior_manager_code  = sm.senior_manager_code 
  and sm.lead_manager_code   = lm.lead_manager_code 
  and c.company_code         = lm.company_code 

group by 
    c.company_code 
  , c.founder

order by 
    c.company_code asc ;