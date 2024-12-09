--mysql  &  ms sql server
select concat( name ,"(", upper( left(occupation , 1 ) ) , ")" ) from occupations order by name;
select concat("There are a total of " , count(*) ," " ,  lower(occupation) , "s." )
from occupations group by occupation
order by count(*) asc , occupation;



--mysql  &  ms sql server
select concat( name ,"(", upper( substring(occupation,1,1) ) , ")" ) from occupations order by name;
select concat("There are a total of " , count(*) ," " ,  lower(occupation) , "s." )
from occupations group by occupation
order by count(*) asc , occupation;



--mysql
select concat( name ,"(", upper( substr(occupation,1,1) ) , ")" ) from occupations order by name;
select concat("There are a total of " , count(*) ," " ,  lower(occupation) , "s." )
from occupations group by occupation
order by count(*) asc , occupation;
