--mysql  &  ms sql server
select 
    case 
        when lead(id) 
               over(
                 order by 
                     id 
                   ) is null 
         and id % 2 != 0
        then  id 
        
        else 
            case  
                when id % 2 = 0 
                then id - 1 
                
                else id + 1 
            end 
    end 
      as id 
  , student 

from 
    seat 

order by 
    id asc;



--mysql  &  ms sql server
  select id , 
  coalesce( 
  case when id % 2 != 0 then lead(student) over(order by id asc ) 
  else lag(student) over(order by id asc ) end , 
  student
  ) as student 
  from seat ; 



--mysql  &  ms sql server
select 
    row_number() 
      over(
        order by 
            id asc 
          ) 
      as id 
  , student 

from (
        select 
            student 
          , case 
                when id % 2 = 0 
                then id - 1 
                
                else id + 1 
            end 
              as id 
    
        from 
            seat
     ) as t ;



--mysql  &  ms sql server
select 
    row_number() 
      over(
        order by 
            (
                case 
                    when id % 2 = 0 
                    then id - 1 
                    
                    else id + 1 
                end 
            ) asc 
          ) 

      as id
 , student 

from 
    seat;



--mysql  &  ms sql server
with cte as ( 
  select 
      id 
    , student    

from 
    seat    

where 
      1=1
  and id % 2 != 0 
  and id = (select count(*) from seat )

union all 
  
select 
    s1.id 
  , s2.student 

from 
    seat s1 
    
    join seat s2 
       on s1.id - 1 = s2.id 

where 
    s1.id % 2  = 0 
  
union all 
  
select 
    s1.id 
  , s2.student 

from 
    seat s1 
    
    join seat s2 
       on s1.id + 1 = s2.id 

where 
      s1.id % 2 != 0 
)
select * from cte order by id asc ; 



--mysql  
select 
    if( 
          lead(id) 
            over(
              order by 
                  id 
                ) is null 
          and id % 2 != 0 
        , id  
        , if( 
                id % 2 = 0 
              , id - 1 
              , id + 1 
            ) 
      ) 
      as id 
  , student 

from 
    seat 

order by 
    id asc;
