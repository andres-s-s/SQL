/*
  Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically 
  and displayed underneath its corresponding Occupation. 
  The output should consist of four columns (Doctor, Professor, Singer, and Actor) 
  in that specific order, with their respective names listed alphabetically under each column.
  
  Note: Print NULL when there are no more names corresponding to an occupation.
  
  The OCCUPATIONS table 
  Name            String
  Occupation      String
  */


-- +--------------------------------------------------------------------+
-- |  solution 1: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


with names_in_alphabetical_order as (
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
                                    )
/*
  This cte partitions the table by occupation and each record gets assigned a number 
  in alphabetical order.
  
  Example
  Eve           Actor 1
  Jennifer      Actor 2
  Ketty         Actor 3
  Samantha      Actor 4
  Aamina        Doctor 1
  Julia         Doctor 2
  Priya         Doctor 3
  Ashley        Professor 1
  Belvet        Professor 2
    
  */



select  
    min( case when n.occupation = "Doctor"    then name end ) as "Doctor" 
  , max( case when n.occupation = "Professor" then name end ) as "Professor" 
  , min( case when n.occupation = "Singer"    then name end ) as "Singer"    
  , max( case when n.occupation = "Actor"     then name end ) as "Actor" 

  /*
    If the min or max function encounter a set of values which all happen to be null 
    except for one, those funcions will take that value since it's the only that 
    is not null, in this context both functions will produce the same result
    */

from
    names_in_alphabetical_order n

group by 
    n.ind;
/*
  The 4 case statements produce 4 new different columns
  Without the min and max functions and group clause the result would look like this
 
  Doctor     Professor      Singer      Actor         ind
  NULL       NULL           NULL        Eve           1
  NULL       NULL           NULL        Jennifer      2
  NULL       NULL           NULL        Ketty         3
  NULL       NULL           NULL        Samantha      4
  Aamina     NULL           NULL        NULL          1
  Julia      NULL           NULL        NULL          2
  Priya      NULL           NULL        NULL          3   
  NULL       Ashley         NULL        NULL          1
  NULL       Belvet         NULL        NULL          2
*/



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
