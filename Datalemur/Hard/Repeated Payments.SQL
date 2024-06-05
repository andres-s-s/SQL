with T as (
    select 
      case 
        when extract( epoch from ( transaction_timestamp - lag(transaction_timestamp) 
        over(partition by credit_card_id , merchant_id ,  amount ) ) ) <=600
        then 1 else null 
      end as tf

    from 
      transactions
)


select 
    COUNT(tf) 

from 
  T;
