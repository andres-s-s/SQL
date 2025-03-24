with server_utilization_time as (

    select 
        case 
            when session_status = 'stop'
              then status_time - lag(status_time) 
                                   over(
                                          partition by 
                                              server_id 
                                          order by 
                                            status_time 
                                          , session_status
                                       )
        end
          as number_of_days
    from 
        server_utilization
)


 , total_utilization_time as (

    select 
        sum(number_of_days) 
          as total_time
    from 
        server_utilization_time
)



select        
    extract(day from total_time ) 
        + floor(extract(hour from total_time ) / 24) 
      as total_days

from 
    total_utilization_time