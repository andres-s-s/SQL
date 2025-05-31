select 
    distinct
    s.ticker

  , first_value( to_char(s.date , 'Mon-YYYY') )  
      over( partition by s.ticker
            order by s.open desc) 
      as highest_mth

  , first_value(s.open)  
      over( partition by s.ticker
            order by s.open desc)
      as highest_open

  , first_value( to_char(s.date , 'Mon-YYYY') )  
      over( partition by s.ticker
            order by s.open asc)
      as lowest_mth

  , first_value(s.open)  
      over( partition by s.ticker
            order by s.open asc)
      as lowest_open

from 
    stock_prices s

order by 
    s.ticker 