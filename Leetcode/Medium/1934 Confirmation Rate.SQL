--mysql  &  ms sql server
select 
    user_id 
  , round(  
            count(
                case 
                    when action = 'confirmed' 
                    then 1 
                    
                    else null 
                end 
                 )
        / 
            cast( 
                  count(*) as float 
                ) 
      , 2 ) 
      as confirmation_rate

from 
    confirmations

group by 
    user_id 

union all

select 
    user_id 
  , 00.00 
      as confirmation_rate 

from 
    signups 

where 
      user_id not in (
                        select 
                            distinct user_id 
                        
                        from 
                            confirmations
                     );




--mysql  &  ms sql server
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
