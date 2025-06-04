### ➡️ Solution 1  

**MySQL**, **MS SQL Server**

~~~sql
select 
    substr(trans_date, 1,7)
      as month  -- left( trans_date , 7 ) 

  , country

  , count(*)
    as trans_count

  , sum(
            case
              when state = 'approved'
              then 1 
              else 0
            end
    )
    as approved_count

  , sum(amount)
    as trans_total_amount

  , sum(
            case
              when state = 'approved'
              then amount
              else 0
            end
    )
    as approved_total_amount

from 
    Transactions 

group by
    substr(trans_date, 1,7) -- left( trans_date , 7 ) 
  , country

/*
    Alternative
    MySQL 
    date_format(trans_date, '%Y-%m') 

    MS SQL Server 
    format( trans_date , 'yyyy-mm' ) 
*/
~~~

**PostgreSQL**

~~~sql
select 
    to_char(trans_date, 'YYYY-MM')
      as month 

  , country

  , count(*)
    as trans_count

  , count(*)
      filter(where state = 'approved')
    as approved_count

  , sum(amount)
    as trans_total_amount

  , coalesce(
        sum(amount)
          filter(where state = 'approved') 
      , 0)
    as approved_total_amount

from 
    Transactions 

group by
    to_char(trans_date, 'YYYY-MM')
  , country

/*
  It seems like count never return null but 0 instead
  whereas sum can return null therefore coalesce is needed in the second
  sum because if all transactions are denied there will be nothin to sum 
*/
~~~


