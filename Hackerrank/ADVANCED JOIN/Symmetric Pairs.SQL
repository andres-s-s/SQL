/*
  You are given a table, Functions, containing two columns: X and Y.
  Column      Type
  X           Integer
  Y           Integer

  Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and Y1 = X2.

  Write a query to output all such symmetric pairs in ascending order by the value of X. 
  List the rows such that X1 ≤ Y1.
  
  */



-- +--------------------------------------------------------------------+
-- |  solution 1: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


select 
    a.x
  , a.y

from 
    Functions a
    
    join Functions b
       on a.x < b.x
      and a.x = b.y
      and a.y = b.x
      
union all

select  
    a.x
  , a.y

from 
    Functions a
    
where 
      a.x = a.y
      
group by 
    a.x
  , a.y

having count(*) > 1


order by 
    x
  , y


-- +--------------------------------------------------------------------+
-- |  solution 2: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


select 
    f.x 
  , f.y 

from 
    functions f 

where exists(
        select 
            * 
        
        from
            functions fl 
        
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
        select 
            * 
        
        from 
            functions fl 
        
        where
              1=1
          and f.x = fl.x 
          and fl.y = f.y 
        
        group by 
            fl.x 
          , fl.y 
        
        having 
            count(*)> 1  )

group by 
    f.x 
  , f.y

order by 
    f.x; 




-- +--------------------------------------------------------------------+
-- |  solution 3: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


select 
    f.x 
  , f.y 

from 
  functions f 

where 
    exists (
            select 
                * 
            
            from  
                functions fl 
            
            where 
                  1=1
              and f.x = fl.y 
              and f.y = fl.x  
            
            group by 
                fl.x , fl.y
            
            having 
                  count(*) > 1 
               or f.x < f.y )

group by 
    f.x 
  , f.y

order by 
    f.x; 