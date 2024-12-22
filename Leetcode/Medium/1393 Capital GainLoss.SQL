--mysql  &  ms sql server
with cte as (
  select 
      stock_name 
    , case 
          when operation = 'buy' 
          then lead(price) 
                 over(
                   order by 
                       stock_name 
                     , operation_day asc
                     ) - price 
          
          else 0 
      end 
        as gl 
  
  from 
      stocks
            )


select 
    stock_name 
  , sum(gl) 
      as capital_gain_loss 

from 
    cte 

group by 
    stock_name;



--mysql  &  ms sql server
select 
    stock_name 
  , sum(gl) 
      as capital_gain_loss

from (
        select 
            stock_name 
          , case 
                when operation = 'buy' 
                then -price 
                
                else price 
            end 
              as gl 
        
        from 
            stocks
     ) as t 

group by 
    stock_name;



--mysql  &  ms sql server
select 
    distinct stock_name 
  , sum( 
          case 
              when operation = 'buy' 
              then -price 
              
              else price 
          end 
       )
      over(
        partition by 
            stock_name
          ) 
      as capital_gain_loss

from 
    stocks;
