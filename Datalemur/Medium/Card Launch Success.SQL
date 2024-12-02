-- 1
with t as (
  select 
      card_name 
    , issued_amount 
    , rank() over(
        partition by 
            card_name 
        order by 
            issue_year 
          , issue_month )
        as rnk
  
  from 
    monthly_cards_issued

)

select 
    card_name 
  , issued_amount 

from
  t

where 
      1=1
  and rnk = 1 

order by 
    issued_amount desc ;


-- 2
with t as (
  select 
      card_name 
    , issued_amount 
    , make_date(
            issue_year 
          , issue_month 
          , 1)
        as issue_date 
    , min( 
        make_date(
            issue_year 
          , issue_month 
          , 1) )
        over(
          partition by 
              card_name
              )
        as launch_date 
  from monthly_cards_issued

)

select 
    card_name 
  , issued_amount 

from 
  t

where 
  launch_date = issue_date 

order by 
  issued_amount desc;
