### ➡️ Solution 1  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
with products_and_filtered_dates as (
    
    select 
        p.product_id
      , p.new_price 
        as price 
      , p.change_date
      , max(  case 
                when p.change_date <= '2019-08-16'
                then p.change_date 
                else null
              end ) 
          over( partition by p.product_id) 
        as last_date
    
    from 
        products p
)


select 
    product_id
  , price

from 
    products_and_filtered_dates

where 
      last_date = change_date 



union all



select 
    product_id
  , 10 
    as price

from 
    products_and_filtered_dates

where 
      last_date is null 

group by 
    product_id;

~~~

**PostgreSQL**

~~~sql
with products_and_filtered_dates as (
    
    select 
        p.product_id
      , p.new_price 
        as price 
      , p.change_date
      , max(p.change_date) 
          filter(where change_date <= '2019-08-16') 
          over(partition by p.product_id) 
        as last_date
    
    from 
        products p
)


select 
    product_id
  , price

from 
    products_and_filtered_dates

where 
      last_date = change_date 



union all



select 
    product_id
  , 10 
    as price

from 
    products_and_filtered_dates

where 
      last_date is null 

group by 
    product_id;


~~~




### ➡️ Solution 2  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
with cte as (
select 
    p.product_id
  , max(  case
            when change_date <= '2019-08-16' 
            then change_date
            else null
          end)
    as max_date

from 
    Products p

group by 
    p.product_id
)

select 
    c.product_id
  , coalesce(p.new_price , 10)
    as price

from 
    cte c


    left join Products p
       on c.product_id = p.product_id
      and c.max_date = p.change_date 
~~~


### ➡️ Solution 3  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
with cte as (

    select 
        distinct 
        p.product_id
      , first_value(new_price)
          over( partition by product_id
                order by change_date desc )

        as price

    from 
        Products p

    where 
        change_date <= '2019-08-16'
)


select 
    product_id
  , price
from 
    cte

union all

select 
    distinct
    product_id
  , 10 
    as price

from 
    Products

where 
      product_id not in (
                         select 
                             product_id
                         from 
                             cte
      )
~~~

