### ➡️ Solution 1  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
select 
    c.customer_id

from 
    Customer c

group by 
    c.customer_id

having 
    count(distinct product_key)
    =
    (select 
        count(p.product_key)
    from 
        Product p)
~~~sql