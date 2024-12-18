/* mysql  &  ms sql server */
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




/* mysql  &  ms sql server */
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




/* mysql  &  ms sql server */
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




/* mysql */
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
from triangles t;
