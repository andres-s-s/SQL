with ranked_measurements as (
  select 
      measurement_value 
    , measurement_time 
    , row_number() 
        over(
          partition by date( measurement_time )
          order by 
              measurement_time asc) 
        as ind
  from 
    measurements
)

select 
    date(measurement_time ) 
  , sum(
      case 
        when 
          ind % 2 != 0 
        then 
          measurement_value 
        else 
          0 
      end 
       ) 
      as odd_sum 
  , sum(
      case 
        when 
          ind % 2 = 0 
        then 
          measurement_value 
        else 
          0 
      end ) 
      as even_sum

from 
  ranked_measurements 

group by 
    date( measurement_time )

order by date
    ( measurement_time ) asc ;
