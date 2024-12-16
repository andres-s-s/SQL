/*
  Write a query that outputs the name of the credit card, and how many cards were issued 
  in its launch month. The launch month is the earliest record in the monthly_cards_issued 
  table for a given card. Order the results starting from the biggest issued amount.

  Column Name	    Type
  issue_month	    integer
  issue_year	    integer
  card_name	      string
  issued_amount	  integer
  */


/*
  I create a cte and I add a new column with the rank window function ordering by issue_year
  and issue_month and partitioning by card name, therefore the record of the lanch month of each 
  card will have the number 1 in this new column
  */
 

with cards_issued_by_month as (
  select 
      m.card_name 
    , m.issued_amount 
    , rank() 
        over(
          partition by 
              m.card_name 
          order by 
              m.issue_year 
            , m.issue_month )
        as rnk
  
  from 
      monthly_cards_issued m
)



select 
    c.card_name 
  , c.issued_amount 

from
    cards_issued_by_month c

where 
      1=1
  and c.rnk = 1 -- 1 represents the first record for each card

order by 
    c.issued_amount desc ;


/*


  */



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
          , 1) 
         )
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
