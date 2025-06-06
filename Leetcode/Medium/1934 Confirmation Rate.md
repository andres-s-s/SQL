### ➡️ Solution 1  

**MySQL**, **MS SQL Server**

~~~sql
select 
    c.user_id
  , round(
        count(
                case 
                    when action = 'confirmed' 
                    then 1 
                    
                    else null 
                end 
        )
        /
        cast( count(*) as decimal)
      , 2
    )
    as confirmation_rate


from 
    Confirmations c

group by 
    c.user_id


union all


select 
    user_id
  , 0
    as confirmation_rate

from 
    Signups

where 
    user_id not in (
                        select 
                            user_id
                        from 
                            Confirmations

    )
~~~




**PostgreSQL**

~~~sql
select 
    c.user_id
  , round(
        count(c.action)
            filter(where c.action = 'confirmed' )
        /
        count(*)::numeric
      , 2
    )
    as confirmation_rate


from 
    Confirmations c

group by 
    c.user_id


union all


select 
    user_id
  , 0
    as confirmation_rate

from 
    Signups

where 
    user_id not in (
                        select 
                            user_id
                        from 
                            Confirmations

    )

~~~



### ➡️ Solution 2  

**MySQL**,  **MS SQL Server**

~~~sql
select 
    s.user_id 
  , coalesce(
              round(
                    count(
                          case 
                          
                              when c.action = 'confirmed' 
                              then 1 
                              
                              else null 
                          
                          end 
                         )
                  / 
                    cast( 
                          count(c.action) as float 
                        ) 
                , 2 ) 
      , 0.00 
            ) 

      as confirmation_rate

from 
    signups s 
    
    left join confirmations c
       on s.user_id = c.user_id 

group by 
    user_id ;
~~~