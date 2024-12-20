/* 
  Mysql version: 5.7.27-0ubuntu0.18.04.1 
  CTEs are not supported
  */



/*
  Instructions:

  The best way to choose a new wand is by determining the minimum number 
  of gold galleons needed to buy each non-evil wand of the same power and age. 

  Write a query to print the id, age, coins_needed, and power of the wands that 
  Ron's interested in, sorted in order of descending power. 
  
  If more than one wand has same power, sort the result in order of descending age.

  Wands table:
    id              integer
    code            integer
    coins_needed    integer
    power           integer

  Wands_Property table:
    code            integer
    age             integer
    is_evil         integer

  */



/* mysql  &  ms sql serve */
select 
    (
      select 
          w.id 
      
      from 
          wands w
      
      where 
            1=1
        and w.code = t.code 
        and t.power = w.power 
        and w.coins_needed = t.min_c 
    ) /*id field, there is no more than one wand with the same code, power and coins_needed
          therefore those fields can be used to get that specific id */
  , t.age 
  , t.min_c 
  , t.power 

from (
      select 
          w.code 
        , w.power 
        , wp.age 
        , min(w.coins_needed) 
            as min_c 
        
      from 
          wands as w 
          
          join wands_property as wp
             on w.code = wp.code 
      
      where 
            wp.is_evil = 0
      
      group by  
          w.code 
        , w.power 
        , wp.age
     ) as t
      /*This subquery joins both tables and then it groups the records by code, power
          and age and It gets rid of the evil ones and It get the minimum amount for 
          the coins_needed field from each set of records that are grouped*/

order by 
    t.power desc 
  , t.age desc;




/* mysql  &  ms sql server */
select 
    w.id 
  , t.age 
  , t.min_c 
  , t.power 

from (
      select 
          w.code 
        , w.power 
        , wp.age 
        , min(w.coins_needed) 
            as min_c 
        
      from 
          wands as w 
          
          join wands_property as wp
             on w.code = wp.code 
      
      where 
            wp.is_evil = 0
      
      group by  
          w.code 
        , w.power 
        , wp.age
     ) as t

    join wands as w 
       on t.code = w.code 
      and w.coins_needed = min_c 
      and w.power = t.power

order by 
    power desc 
  , age desc;




/* mysql  &  ms sql server */
select 
    (
      select 
          id 
      
      from 
          wands w2 
          
          join wands_property wp2  
             on w2.code = wp2.code 
      
      where 
            1=1
        and wp.age = wp2.age 
        and w.power = w2.power 
        and  coins_needed = min(w.coins_needed)
        and is_evil = 0 
    ) 
  , age 
  , min(coins_needed) 
      as min_c 
  , power 

from 
    wands as w 
    
    join wands_property as wp 
       on w.code = wp.code 

where 
      is_evil = 0

group by 
    power 
  , age 

order by 
    power desc 
  , age desc;



/* mysql  &  ms sql server */
select 
    id 
  , age 
  , coins_needed 
  , power 

from 
    wands as w 
    
    join wands_property as wp 
       on w.code = wp.code 

where 
      1=1
  and is_evil = 0 
  and coins_needed = (
                      select 
                          min(coins_needed) 
                      
                      from 
                          wands as w2 
                          
                          join wands_property as wp2 
                             on w2.code = wp2.code
                      
                      where 
                            1=1
                        and wp2.age = wp.age 
                        and w.power = w2.power 
                     )

order by 
    power desc 
  , age desc;




/* ms sql server */
select 
    id 
  , age 
  , coins_needed 
  , power 

from (
      select 
          id 
        , power 
        , age 
        , coins_needed 
        , row_number() 
            over(
              partition by 
                  power 
                , age 
              
              order by 
                  coins_needed asc 
                ) 
            as coun 
      
      from 
          wands as w 
          
          join wands_property as wp 
             on w.code = wp.code 
      
      where 
            is_evil = 0 
     ) as t

where 
      coun = 1 

order by 
    power desc 
  , age desc;




/* ms sql server */
select 
    id 
  , age 
  , coins_needed 
  , power 

from (
      select 
          id 
        , power 
        , age 
        , coins_needed 
        , min(coins_needed) 
            over(
              partition by 
                  power 
                , age 
                ) 
            as min_c
      
      from 
          wands as w 
          
          join wands_property as wp 
             on w.code = wp.code 
          
          where 
               is_evil = 0 
     ) as t

where 
    min_c = coins_needed

order by 
    power desc 
  , age desc;