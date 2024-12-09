--mysql
select ceil( avg(salary) - avg( replace(salary , 0 , "") ) ) from employees;



--mysql  &  ms sql server
select ceiling( avg( cast( salary as decimal) ) - 
                avg( cast( replace(salary , 0 , "") as decimal) ) ) 
from employees;
