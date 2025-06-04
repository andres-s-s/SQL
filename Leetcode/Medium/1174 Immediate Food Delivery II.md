### ➡️ Solution 1  

**MySQL**

~~~sql
with dates as (

    select 
        order_date
      , customer_pref_delivery_date
      , min(order_date)
          over( partition by customer_id )
        as min_date

    from 
        Delivery
)

select 
    round(
        avg(
                case
                  when order_date = customer_pref_delivery_date
                  then 1 
                  else 0
                end
        )
        * 100
      , 2
    ) 
    as immediate_percentage

from 
    dates

where min_date = order_date

~~~

**MS SQL Server**

~~~sql
with dates as (

    select 
        order_date
      , customer_pref_delivery_date
      , min(order_date)
          over( partition by customer_id )
        as min_date

    from 
        Delivery
)

select 
    round(
        avg(
                case
                  when order_date = customer_pref_delivery_date
                  then cast( 1.0 as decimal(10,2) )
                  else 0.0
                end
        )
        * 100
      , 2
    ) 
    as immediate_percentage

from 
    dates

where min_date = order_date
~~~

**PostgreSQL**

~~~sql
with dates as (

    select 
        order_date
    , customer_pref_delivery_date
    , min(order_date)
        over( partition by customer_id )
      as min_date

    from 
        Delivery
)

select 
    round(
        count(*)
          filter(where order_date = customer_pref_delivery_date)
        /
        count(*)::numeric 
        * 100
      , 2
    ) 
    as immediate_percentage

from 
    dates

where min_date = order_date
~~~




