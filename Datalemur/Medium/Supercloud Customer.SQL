select 
    c.customer_id

from 
    customer_contracts c 

    join products p
       on c.product_id = p.product_id


group by 
    c.customer_id

having 
    (select 
        count(distinct product_category) 
     from 
        products )
    =
    count(distinct p.product_category)
;
