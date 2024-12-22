--mysql  &  ms sql server
select 
    distinct first_value(person_name) 
      over(
        order by 
            wght desc 
          )
      as person_name

from (
        select 
            person_name 
          , sum(weight) 
              over(
                order by 
                    turn asc
                  )
              as wght 

        from 
            queue
     ) as t

where 
    wght <= 1000;



--mysql  
select 
    person_name

from (  
        select 
            person_name 
          , sum(weight) 
              over(
                order by 
                    turn asc
                  )  
              as wght 
        
        from 
            queue
     ) as t

where 
    wght <= 1000

order by 
    wght desc 

limit 1 ;



--ms sql server
select 
    top 1 person_name

from (
        select 
            person_name 
          , sum(weight) 
              over(
                order by 
                    turn asc
                  )  
              as wght 
        
        from 
            queue
     ) as t

where 
    wght <= 1000

order by 
    wght desc;



--mysql  
select   
    q1.person_name 

from 
    queue q1 
    
    join queue q2 
       on q1.turn >= q2.turn 

group by 
    q1.person_name 

having   
    sum( q2.weight ) <= 1000

order by 
    sum( q2.weight ) desc 

limit 1 ;



--ms sql server
select   
    top 1 q1.person_name 

from 
    queue q1 
    
    join queue q2 
       on q1.turn >= q2.turn 

group by 
    q1.person_name 

having   
    sum( q2.weight ) <= 1000

order by 
    sum( q2.weight ) desc ;
