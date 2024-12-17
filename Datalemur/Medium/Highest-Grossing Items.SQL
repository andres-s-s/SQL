/*
    Assume you're given a table containing data on Amazon customers and their 
    pending on products in different category, write a query to identify the top 
    two highest-grossing products within each category in the year 2022. 
    The output should include the category, product, and total spend.

*/



with spend_by_product_in_2022 as (
  select 
      p.category 
    , p.product 
    , sum(p.spend) 
        as sp

  from 
      product_spend p

  where 
      extract( year from p.transaction_date ) = '2022'

  group by 
      p.category 
    , p.product 
                               )
 
/*
  This cte gets the total spend of each product in the year 2022
  */


, products_orderd_by_spend as (
  select 
      s.category
    , s.product
    , s.sp
    , row_number() 
        over(
          partition by 
              s.category 
          order by 
              s.sp desc
            ) 
        as ind

    from 
        spend_by_product_in_2022 s
                            ) 
/*
  This cte numbers the products depending on their category and spend
  The product with the larger spend from each category gets a 1
  */


select 
    p.category 
  , p.product 
  , p.sp as total_spend 

from 
    products_orderd_by_spend p

where 
     p.ind in 
        (  1    -- The 2 products from each category with bigger spend
         , 2 );
