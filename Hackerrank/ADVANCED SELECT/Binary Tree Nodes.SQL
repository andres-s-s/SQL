--mysql  &  ms sql server
select n , 
    case when p is null then "Root"
         when n in (select distinct p from bst) then "Inner"
         else "Leaf" end
from bst order by n;



--mysql  &  ms sql server
select n , 
    case when p is null then "Root"
         when exists(select p from bst where b.n = p ) then "Inner"
         when (select count(p) from bst where b.n = p ) = 0 then "Leaf" end
from bst b order by n;



--mysql 
with cte as (select distinct p from bst)

select n , 
if(p is null , "Root" , 
    if(n in (select p from cte ) , "Inner" , "Leaf") 
) 
from bst 
order by n; 
