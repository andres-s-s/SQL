
### ➡️ Solution 1  


**MySQL**, **MS SQL Server**
~~~sql
with cte (tiv_2016 , tiv_2015c , latlonc ) as (
  select 
      tiv_2016 
    , count(*) 
        over( partition by 
                  tiv_2015 ) 
    , count(*) 
        over( partition by 
                  lat 
                , lon
            )
  
  from 
      insurance 
)

select 
    round( 
            sum( tiv_2016 ) 
          , 2 
         ) 
      as tiv_2016 
      
from 
    cte 

where 
      1=1
  and tiv_2015c > 1 
  and latlonc = 1 ; 
~~~


**PostgreSQL**  
~~~sql
with cte (tiv_2016 , tiv_2015c , latlonc ) as (
  select 
      tiv_2016 
    , count(*) 
        over( partition by 
                  tiv_2015 ) 
    , count(*) 
        over( partition by 
                  lat 
                , lon
            )
  
  from 
      insurance 
)

select 
    round( 
            sum( tiv_2016 )::numeric
          , 2 
         ) 
      as tiv_2016 
      
from 
    cte 

where 
      1=1
  and tiv_2015c > 1 
  and latlonc = 1 ; 

~~~


### ➡️ Solution 2  

**MySQL**, **MS SQL Server** 

~~~sql
with inves_2015 as (
    select 
        i.tiv_2015

    from 
        Insurance i

    group by
        i.tiv_2015

    having 
        count(*) >= 2
)

, city as (

    select 
        i.lat
      , i.lon

    from 
        Insurance i

    group by
        i.lat
      , i.lon

    having 
        count(*) = 1
)


select 
    round(
        sum(i.tiv_2016)
      , 2
    )
      as "tiv_2016"

from 
    Insurance i

    join city c
       on c.lat = i.lat
      and c.lon = i.lon 

where 
    i.tiv_2015 in (
                    select 
                        tiv_2015
                    from 
                        inves_2015
    )
~~~

**PostgreSQL** 

~~~sql
with inves_2015 as (
    select 
        i.tiv_2015

    from 
        Insurance i

    group by
        i.tiv_2015

    having 
        count(*) >= 2
)

, city as (

    select 
        i.lat
      , i.lon

    from 
        Insurance i

    group by
        i.lat
      , i.lon

    having 
        count(*) = 1
)


select 
    round(
        sum(i.tiv_2016)::numeric
      , 2
    )
      as "tiv_2016"

from 
    Insurance i

    join city c
       on c.lat = i.lat
      and c.lon = i.lon 

where 
    i.tiv_2015 in (
                    select 
                        tiv_2015
                    from 
                        inves_2015
    )
~~~
