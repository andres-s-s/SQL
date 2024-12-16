/*
  Using the transactions table, identify any payments made at the same merchant with 
  the same credit card for the same amount within 10 minutes of each other. ç
  Count such repeated payments.

  The first transaction of such payments should not be counted as a repeated payment. 
  This means, if there are two transactions performed by a merchant with the same 
  credit card and for the same amount within 10 minutes, there will only be 1 repeated payment.
*/


with repeated_payments as (
  select 
    case 
      when 
      
        extract( 
          epoch from ( 
                  t.transaction_timestamp 
                  - lag(t.transaction_timestamp) 
                      over( 
                          partition by
                              t.credit_card_id 
                            , t.merchant_id 
                            , t.amount ) 
                          ) 
                )<=600 -- 600 segundos son equivalentes a 10 minutos      
      then 1  
              /* 
                If there is past a transaction with the same credit_card_id, merchant_id and amount
                as the record being processed, and it happened no more than 600 seconds ago (10 
                minutes) then in the new column add "1", if this is not true add "null" 
                (not a string, a value)
                */

      else null 
    end as tf
    /*
      The Unix Epoch time is the number of seconds that have elapsed since January 1, 1970, 00:00:00 UTC.

      You can try this
      select extract(epoch from timestamp '1971-01-01 00:00:00');
      and the result will be 31536000.000000, a year has exactly 31,536,000 seconds

      However in this case it works slightly different, the output of 
      t.transaction_timestamp - lag(t.transaction_timestamp) looks like is "hours":1,"minutes":9
      and the epoch function will turn in into this 4140.000000
      */

  from 
    transactions t
)


select 
    count(rp.tf) /* All the repeated payments records have 1 in their tf column whereas
      the other records have a null value, therefore the count function does not count them
      */
from 
  repeated_payments rp;
