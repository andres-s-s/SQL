/*
  Amber's conglomerate corporation just acquired some new companies. 
  Each of the companies follows this hierarchy:

  Founder
  ⬇️
  Lead Manager
  ⬇️
  Senior Manager
  ⬇️
  Manager
  ⬇️
  Employee

  Write a query to print the company_code, founder name, total number of lead managers, 
  total number of senior managers, total number of managers, and total number of employees. 
  Order your output by ascending company_code.

  The tables may contain duplicate records.

  company_code  table         Lead_Manager table                Senior_Manager  table
  company_code  string        lead_manager_code   string        senior_manager_code   string
  founder       string        company_code        string        lead_manager_code     string
                                                                company_code          string

  Manager table                       Employee table
  manager_code          string        employee_code         string
  senior_manager_code   string        manager_code          string
  lead_manager_code     string        senior_manager_code   string
  company_code          string        lead_manager_code     string
                                      company_code          string
*/                                





-- +--------------------------------------------------------------------+
-- |  solution 1: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


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
       on c.company_code        = lm.company_code

    join senior_manager sm 
       on sm.lead_manager_code  = lm.lead_manager_code
      
    join manager m 
       on m.senior_manager_code = sm.senior_manager_code

    join employee e 
       on e.manager_code        = m.manager_code 
    /* 
      Technically I could make the joins using only the company_code field since it's used
      in all tables and then use the distinct clause plus the count function to know how many
      unique records are but that would be inefficient remember that tables may contain 
      duplicate records.
      */

group by 
    c.company_code 
  , c.founder

order by 
    c.company_code asc ;





-- +--------------------------------------------------------------------+
-- |  solution 2: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+
/*
  This code is less efficient and does not aligned with modern SQL practices
  */

select 
    c.company_code 
  , c.founder 
  , count(distinct lm.lead_manager_code)  
  , count(distinct sm.senior_manager_code)  
  , count(distinct m.manager_code)
  , count(distinct e.employee_code)

from 
    company         c  
  , lead_manager    lm
  , senior_manager  sm 
  , manager         m 
  , employee        e 

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