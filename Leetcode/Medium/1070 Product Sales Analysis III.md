### ➡️ Solution 1  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
select 
    product_id 
  , year 
    as first_year 
  , quantity 
  , price 

from   
    sales

where concat(product_id , year ) in 
                               (select 
                                    concat( product_id , min(year) ) 
                                from 
                                    sales 
                                group by 
                                    product_id ); 
~~~ 


### ➡️ Solution 2  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql 
with sales_and_min_date as (

    select 
        s.product_id
      , min(s.year)
        over( partition by 
                s.product_id
              order by 
                s.year asc)
        as first_year
      , s.year
      , s.quantity
      , s.price

    from 
        Sales s
)


select
    product_id
  , first_year
  , quantity
  , price

from 
    sales_and_min_date

where 
    year = first_year
~~~ 



# 📖 Extra solutions 📖  

### ➡️ Solution 3  

**MySQL**,  **PostgreSQL**, **MS SQL Server**  
Testcases passed, but took too long. 

~~~sql  

select 
    product_id 
  , year as first_year 
  , quantity 
  , price 

from (
        select 
            dense_rank() 
              over(partition by product_id order by year asc ) 
            as ind
          , product_id 
          , year 
          , quantity 
          , price 
        
        from 
            sales
) as t 

where 
      ind = 1 ; 
~~~ 