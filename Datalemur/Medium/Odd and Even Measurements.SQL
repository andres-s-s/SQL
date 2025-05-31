/*
  Instructions:
  Assume you're given a table with measurement values obtained from a Google 
  sensor over multiple days with measurements taken multiple times within each day.

  Write a query to calculate the sum of odd-numbered and even-numbered measurements separately 
  for a particular day and display the results in two different columns. 
  Refer to the Example Output below for the desired format.

  Definition:

  Within a day, measurements taken at 1st, 3rd, and 5th times are considered 
  odd-numbered measurements, and measurements taken at 2nd, 4th, 
  and 6th times are considered even-numbered measurements.

*/



with ranked_measurements as (
  select 
      m.measurement_value 
    , m.measurement_time 
    , row_number() 
        over(
          partition by 
            date( 
              m.measurement_time 
                )
          order by 
              m.measurement_time asc
            ) 
        as ind
  from 
      measurements m
)



select 
    date(r.measurement_time ) 
  , sum(
      case 
        when 
          r.ind % 2 != 0 
        then 
          r.measurement_value 
        else 
          0 
      end 
       ) 
      as odd_sum
  , sum(
      case
        when
          r.ind % 2 = 0
        then
          r.measurement_value
        else
          0
      end
       )
      as even_sum

from 
    ranked_measurements r

group by 
    date(r.measurement_time)

order by date
    r.measurement_time asc ;
