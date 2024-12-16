/*
Assume you're given a table containing information about Wayfair user transactions 
for different products. Write a query to calculate the year-on-year growth rate 
for the total spend of each product, grouping the results by product ID.


user_transactions Example Input:
transaction_id	product_id	spend	      transaction_date
1341	          123424	    1500.60	    12/31/2019 12:00:00
1423	          123424	    1000.20	    12/31/2020 12:00:00
1623	          123424	    1246.44	    12/31/2021 12:00:00
1322	          123424	    2145.32	    12/31/2022 12:00:00

Note that each product_id has only one transaction_date per year
*/

with curr_year_spend_vs_prev_year_spend as (
  select
      us.product_id
    , us.spend as curr_year_spend -- Amount spent current year on that product
    , us.transaction_date 
    , lag(us.spend) -- Amount spent last year on that product
        over(
          partition by 
              us.product_id 
          order by 
              us.transaction_date) 
      as prev_year_spend
  
  from user_transactions us
)
/*
  Example Output of curr_year_spend_vs_prev_year_spend:

  product_id	spend	    transaction_date	    pys
  123424	    1500.60	  12/31/2019 12:00:00	  NULL
  123424	    1000.20	  12/31/2020 12:00:00	  1500.60
  123424	    1246.44	  12/31/2021 12:00:00	  1000.20
  123424	    2145.32	  12/31/2022 12:00:00	  1246.44

  We are making a new table like the original but getting rid of the transaction_id
  because it's not necessary and adding a new column with the amount spent last year
  according to each product_id
  */

select 
    extract(year from cvs.transaction_date) as yr -- Year from a timestamp field
  , cvs.product_id
  , cvs.curr_year_spend 
  , cvs.prev_year_spend
  , round( ( ( cvs.curr_year_spend - cvs.prev_year_spend ) *100.0 )/cvs.prev_year_spend 
             , 2 ) as yoy_rate
    /*
      Year-on-year growth rate
      The order of the operations work from left to right, first it goes the subtraction
        then the multiplication and the division
      The ", 2" is a parameter for the round function
      */
from 
  curr_year_spend_vs_prev_year_spend cvs

order by 
    cvs.product_id
  , cvs.transaction_date asc;
