### ➡️ Solution 1  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
select 
    stock_name
  , sum(  case 
            when operation = 'Buy' 
            then -price
            else  price
          end )
    as capital_gain_loss

from 
    Stocks

group by 
    stock_name
~~~

### ➡️ Solution 2 

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
select 
    distinct 
    stock_name 
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
~~~