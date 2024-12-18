/* mysql  &  ms sql server */
select  
    min(case when occupation = "Doctor"    then name end) as "Doctor" 
  , max(case when occupation = "Professor" then name end) as "Professor" 
  , min(case when occupation = "Singer"    then name end) as "Singer"    
  , max(case when occupation = "Actor"     then name end) as "Actor" 

from (
        select 
            name 
          , occupation 
          , row_number() 
              over(
                partition by 
                    occupation 
                order by 
                    name
                  ) 
              as ind
        
        from 
            occupations 
     ) as t 

group by 
    ind;



--mysql  &  ms sql server
select  
    min(doctor)    as "Doctor"
  , max(professor) as "Professor"  
  , min(singer)    as "Singer"
  , max(actor)     as "Actor" 

from (
      select 
          name 
        , occupation 
        , row_number() 
            over(
              partition by 
                  occupation 
              order by 
                  name
                ) 
            as ind 
        , case 
            when occupation = "Doctor" 
            then name end as "Doctor"

        , case 
            when occupation = "Professor" 
            then name end as "Professor"  
        
        , case 
            when occupation = "Singer"
            then name end as "Singer"
        
        , case 
            when occupation = "Actor"
            then name end as "Actor"
      
      from 
          occupations 
     ) as t 

group by 
    ind;



/* mysql */
set 
    @d := 0
  , @p := 0
  , @s := 0
  , @a := 0;



select  
    min(doctor) as "Doctor"
  , max(professor) as "Professor"  
  , min(singer)    as "Singer"
  , max(actor)     as "Actor" 

from (
      select 
          name 
        , occupation 
        , case 
            when occupation = "Doctor" 
            then (@d := @d + 1) 
            
            when occupation = "Professor" 
            then (@p := @p + 1)
            
            when occupation = "Singer" 
            then (@s := @s + 1)
            
            when occupation = "Actor" 
             then (@a := @a + 1) 
          
          end as ind 
        
        , case 
            when occupation = "Doctor"    
            then name end as "Doctor"
        
        , case 
            when occupation = "Professor" 
            then name end as "Professor"
        
        , case when occupation = "Singer"
          then name end as "Singer"
        
        , case when occupation = "Actor"
          then name end as "Actor"
      
      from 
          occupations 
      
      order by 
          name 
     ) as t 

group by 
    ind;
