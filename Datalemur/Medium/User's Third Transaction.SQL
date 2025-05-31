with transactions_cte as (
  select
      t.user_id
    , t.spend
    , t.transaction_date
    , row_number()
        over(
          partition by 
              t.user_id
          order by 
              t.transaction_date
            )
        as transaction_n
  from
      transactions t
)


select 
    t.user_id
  , t.spend
  , t.transaction_date

from 
    transactions_cte t

where
    transaction_n = 3