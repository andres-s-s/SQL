/* mysql */
select 
    ceil( 
            avg(e.salary) - avg(replace( e.salary , 0 , "")) 
        ) 

from 
    employees e;




/* mysql  &  ms sql server */
select 
    ceiling( 
                avg( cast( salary as decimal) ) 
              - avg( cast( replace(salary , 0 , "") as decimal) ) 
           ) 

from 
    employees e;
