/*
  Instructions:
  Assume you're given a table on Walmart user transactions. 
  Based on their most recent transaction date, write a query that retrieve the 
  users along with the number of products they bought.
  */



with transactions_sorted_by_date as (
  select 
      u.user_id 
    ,	u.spend  -- Amount of money spend on that specific product 
    , u.transaction_date 
    , dense_rank() -- Several products will have the exact same transaction_date
        over(
          partition by 
              u.user_id 
          order by 
              u.transaction_date desc 
        ) as ind
  
  from 
      user_transactions u
) 
/*
  The transactions made by each user get tagged with a number based on their date,
  the most recent ones get a 1 (if they have the same transaction_date and it happens
  to be the most recent date for that user)
  */



select 
    t.transaction_date 
  , t.user_id 
  , count(*) -- Amount of products with the same transaction_date and user_id

from 
    transactions_sorted_by_date t

where 
      1=1
  and t.ind = 1 -- The most recent transactions for each user

group by 
    t.transaction_date 
  , t.user_id

order by 
    t.transaction_date;

