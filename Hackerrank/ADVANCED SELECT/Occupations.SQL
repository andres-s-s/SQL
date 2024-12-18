/* mysql  &  ms sql server */
select  
    min(case when t.occupation = "Doctor"    then name end) as "Doctor" 
  , max(case when t.occupation = "Professor" then name end) as "Professor" 
  , min(case when t.occupation = "Singer"    then name end) as "Singer"    
  , max(case when t.occupation = "Actor"     then name end) as "Actor" 

from (
        select 
            o.name 
          , o.occupation 
          , row_number() 
              over(
                partition by 
                    o.occupation 
                order by 
                    o.name
                  ) 
              as ind
        
        from 
            occupations o
     ) as t 

group by 
    t.ind;




/* mysql  &  ms sql server */
select  
    min(t.doctor)    as "Doctor"
  , max(t.professor) as "Professor"  
  , min(t.singer)    as "Singer"
  , max(t.actor)     as "Actor" 

from (
      select 
          o.name 
        , o.occupation 
        , row_number() 
            over(
              partition by 
                  o.occupation 
              order by 
                  o.name
                ) 
            as ind 
        , case 
            when o.occupation = "Doctor" 
            then o.name 
            end as "Doctor"

        , case 
            when o.occupation = "Professor" 
            then o.name 
            end as "Professor"  
        
        , case 
            when o.occupation = "Singer"
            then o.name 
            end as "Singer"
        
        , case 
            when o.occupation = "Actor"
            then o.name 
            end as "Actor"
      
      from 
          occupations o
     ) as t 

group by 
    t.ind;



/* mysql */
set 
    @d := 0
  , @p := 0
  , @s := 0
  , @a := 0;



select  
    min(t.doctor)    as "Doctor"
  , max(t.professor) as "Professor"  
  , min(t.singer)    as "Singer"
  , max(t.actor)     as "Actor" 

from (
      select 
          o.name 
        , o.occupation 
        , case 
            when o.occupation = "Doctor" 
            then (@d := @d + 1) 
            
            when o.occupation = "Professor" 
            then (@p := @p + 1)
            
            when o.occupation = "Singer" 
            then (@s := @s + 1)
            
            when o.occupation = "Actor" 
             then (@a := @a + 1) 
          
          end as ind 
        
        , case 
            when o.occupation = "Doctor"    
            then o.name 
            end as "Doctor"
        
        , case 
            when o.occupation = "Professor" 
            then o.name 
            end as "Professor"
        
        , case when o.occupation = "Singer"
          then o.name 
          end as "Singer"
        
        , case when o.occupation = "Actor"
          then o.name 
          end as "Actor"
      
      from 
          occupations o
      
      order by 
          name 
     ) as t 

group by 
    t.ind;
