/* mysql  &  ms sql server */
select 
    e.salary * e.months 
  , count(*) 

from 
    employee e

where
      1=1
  and e.salary * e.months = ( select max(salary * months) from employee )

group by 
    e.salary * e.months;




/* mysql */
select 
    e.salary * e.months 
      as te
  , count(*) 

from 
    employee e     

group by 
    e.salary * e.months

having 
    te = ( select max(salary * months) from employee );




/* mysql */ 
select 
    e.salary * e.months 
      as te
  , count(*) 

from 
    employee e

group by 
    te

order by 
    te desc limit 1 ;




/* ms sql server */
select 
    e.salary * e.months 
  , count(*) 
 
from 
    employee e     

group by 
    e.salary * e.months

having 
    e.salary * e.months = ( select max(salary * months) from employee );




/* ms sql server */
select 
    top 1 e.salary * e.months 
  , count(*) 

from 
    employee e

group by 
    e.salary * e.months

order by 
    e.salary * e.months desc;
