/*
  Write a query identifying the type of each record in the TRIANGLES table using 
  its three side lengths. Output one of the following statements for each record in the table:

  Equilateral: It's a triangle with 3 sides of equal length.
  Isosceles: It's a triangle with 2 sides of equal length.
  Scalene: It's a triangle with 3 sides of differing lengths.
  Not A Triangle: The given values of A, B, and C don't form a triangle.

  The TRIANGLES table is described as follows:
  Column          Type
  A               Integer
  B               Integer
  C               Integer
  */





-- +--------------------------------------------------------------------+
-- |  solution 1: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


select 
    case 

      when t.a = t.b 
       and t.b = t.c 
      then "Equilateral"
  
      when t.a + t.b <= t.c  
      then "Not A Triangle"
  
      when t.a = t.b 
        or t.a = t.c 
      then "Isosceles"
  
      else "Scalene" 
    
    end

from 
    triangles t;




-- +--------------------------------------------------------------------+
-- |  solution 2: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


select 
    case 
    
      when t.a = t.b 
       and t.b = t.c 
      then "Equilateral"
      
      when t.a + t.b <= t.c 
        or t.b + t.c <= t.a 
        or t.a + t.c <= t.b 
      then "Not A Triangle"
  
      when t.a = t.b 
        or t.c = t.b 
        or t.a = t.c 
        or t.b = t.c 
      then "Isosceles"
  
    else "Scalene" 
    
    end

from 
    triangles t;




-- +--------------------------------------------------------------------+
-- |  solution 3: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


select 
    case 

      when t.a + t.b > t.c 
      then
          case 
          
          when t.a = t.b 
           and t.b = t.c 
          then "Equilateral"
               
          when t.a = t.b 
            or t.a = t.c  
          then "Isosceles"
               
          else "Scalene" 
          
      end
      
      else "Not A Triangle" 
    
    end

from 
    triangles t;




-- +--------------------------------------------------------------------+
-- |  solution 4: mysql   
-- +--------------------------------------------------------------------+


select 
    if(
          t.a+t.b <= t.c
        , "Not A Triangle"
        , if( 
                t.a=t.b and t.b=t.c
              , "Equilateral"
              , if(
                    t.a=t.b or t.a=t.c 
                  , "Isosceles"
                  , "Scalene") 
            ) 
      ) 

from 
    triangles t;
