--mysql  &  ms sql server
select case when grade > 7 then name end , grade , marks 
from students join grades on marks between min_mark and max_mark order by grade desc , name ;



--mysql  &  ms sql server
select 
    (select name 
      from students 
      where marks >= 70 and st.name = name) 
  , grade 
  , marks 

from students st 
    join grades on marks between min_mark and max_mark 

order by grade desc , name ;



--mysql
select if(grade >=8 , name , null ), grade , marks 
from students join grades on marks between min_mark and max_mark order by grade desc , name ;
