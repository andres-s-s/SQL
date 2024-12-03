--mysql  &  ms sql server
select 
    f.x 
  , f.y 

from 
  functions f 

    join functions fl
      on  f.x = fl.y 
      and f.y = fl.x 
      and f.x < f.y

union 

select 
    x 
  , y 

from 
  functions f 

group by 
    x 
  , y 

having count(*) > 1 

order by x;



--mysql  &  ms sql server
select 
    f.x 
  , f.y 

from 
  functions f 

where exists(
        select * 
        
        from  functions fl 
        
        where 
              1=1
          and f.x = fl.y 
          and f.y = fl.x 
          and f.x < f.y 
        
        group by 
            fl.x 
          , fl.y  
            )
or    exists(
        select * 
        
        from  functions fl 
        
        where
              1=1
          and f.x = fl.x 
          and fl.y = f.y 
        
        group by 
            x 
          , y 
        
        having count(*)> 1  )

group by 
    x 
  , y

order by 
    x; 



--mysql  &  ms sql server
select 
    f.x 
  , f.y 

from 
  functions f 

where exists(select * from  functions fl 
             where f.x = fl.y and f.y = fl.x  
             group by fl.x , fl.y
             having count(*) > 1 or  f.x < f.y )

group by 
    x 
  , y

order by x; 
