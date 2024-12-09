--mysql  &  ms sql server
select case 
        when a = b and b = c then "Equilateral"
        when a + b <= c  then "Not A Triangle"
        when a = b or a = c then "Isosceles"
        else "Scalene" end
from triangles;



--mysql  &  ms sql server
select case 
        when a = b and b = c then "Equilateral"
        when a + b <= c or b + c <= a or a + c <= b then "Not A Triangle"
        when a = b or c = b or a = c or b = c then "Isosceles"
        else "Scalene" end
from triangles;



--mysql  &  ms sql server
select case 
        when a + b > c then
          case when a = b and b = c then "Equilateral"
               when a = b or a = c  then "Isosceles"
               else "Scalene" end
          else "Not A Triangle" end
from triangles;



--mysql 
select if(a+b <= c,"Not A Triangle",if( a=b and b=c,"Equilateral",if(a=b or a=c ,"Isosceles","Scalene") ) ) 
from triangles;
