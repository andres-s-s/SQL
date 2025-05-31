/*
  Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically 
  and displayed underneath its corresponding Occupation. 
  The output should consist of four columns (Doctor, Professor, Singer, and Actor) 
  in that specific order, with their respective names listed alphabetically under each column.
  
  Note: Print NULL when there are no more names corresponding to an occupation.
  
  The OCCUPATIONS table 
  Column          Type
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

    The case statement will return null 3 out of 4 times for each row and the 
    the value that is not null will depend on the occupation for that line of code 
    */

from
    names_in_alphabetical_order n

group by 
    n.ind;

order by 
    n.ind
/*
  The 4 case statements produce 4 new different columns
  Without the min and max functions and group clause the result would look like this
  plus the ind column 
  Notice that in each row 3 out of 4 occupations have a null value

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

  Now what is happening in the query is that the rows get group by ind
  and there is a min or max function for each of the 4 occupations 
  and inside all of them there is a case statement, every case statement will return
  a null value except when with there is a match with that specific occupation, 
  in that situation, the case statements will return the name of the person from that row

  */





-- +--------------------------------------------------------------------+
-- |  solution 2: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


with names_in_order_and_occupations as (
  select 
      row_number() 
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
      end 
        as "Doctor"

    , case 
          when o.occupation = "Professor" 
          then o.name 
      end 
        as "Professor"  
    
    , case 
          when o.occupation = "Singer"
          then o.name 
      end 
        as "Singer"
    
    , case 
          when o.occupation = "Actor"
          then o.name 
      end 
        as "Actor"
  
  from 
      occupations o
                                      ) 
/*
  The case statements create 4 new columns, the name of these new columns are the 4 occupations
  When a row is being processed and there is a match between the occupation and the case 
  statement, this last one takes the name of that person instead of a null value

  And the row_number function gets every record (in alphabetical order) a number 
  partitioning by occupation

  Example
  name         occupation    ind   Doctor   Professor   Singer    Actor
  Eve          Actor         1     NULL     NULL        NULL      Eve
  Jennifer     Actor         2     NULL     NULL        NULL      Jennifer
  Ketty        Actor         3     NULL     NULL        NULL      Ketty
  Samantha     Actor         4     NULL     NULL        NULL      Samantha
  */


select  
    min(n.doctor)      as "Doctor"
  , max(n.professor)   as "Professor"  
  , min(n.singer)      as "Singer"
  , max(n.actor)       as "Actor" 
  /*
    If the min or max function encounter a set of values which all happen to be null 
    except for one, those funcions will take that value since it's the only that 
    is not null, in this context both functions will produce the same result
    */

from 
    names_in_order_and_occupations n

group by 
    n.ind

order by 
    n.ind;





-- +--------------------------------------------------------------------+
-- |  solution 3: mysql
-- +--------------------------------------------------------------------+


/* 
  This one is similar to the previous one but instead of using a row_number function
  i'm using variables and 1 case statement more than before
  */


set 
    @d := 0
  , @p := 0
  , @s := 0
  , @a := 0;



with names_in_order_and_occupations as  (
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
      o.name 
                                         )




select  
    min(n.doctor)    as "Doctor"
  , max(n.professor) as "Professor"  
  , min(n.singer)    as "Singer"
  , max(n.actor)     as "Actor" 

from 
    names_in_order_and_occupations n

group by 
    n.ind;