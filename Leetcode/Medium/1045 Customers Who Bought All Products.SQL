--mysql  &  ms sql server
with amt as ( 
  select 
      count(*) as cnt 
  
  from 
      product 
)


, customers as (
  select 
      distinct customer_id 
    , product_key 
  
  from 
      customer 
) 


select 
    customer_id 

from 
    customers 

group by 
    customer_id 

having 
    count(*) = (select cnt from amt );



--mysql  &  ms sql server
select 
    customer_id 

from 
    customer 

group by 
    customer_id 

having 
    count(distinct product_key) = ( select 
                                        count(*) 
                                    from 
                                        product);
