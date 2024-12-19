/* mysql  &  ms sql server */
select 
    case 
      when g.grade > 7 
      then s.name 
    end 
  , g.grade 
  , s.marks 

from 
    students s
    
    join grades g
       on s.marks between g.min_mark and g.max_mark 

order by 
    g.grade desc 
  , s.name ;




/* mysql  &  ms sql server */
select 
    (
      select 
          s.name 
      from 
          students s
      where 
            s.marks >= 70 
        and st.name = s.name) 
  , g.grade 
  , st.marks 

from students st 
    join grades g 
       on marks between min_mark and max_mark 

order by 
    g.grade desc 
  , st.name ;




/* mysql */
select 
    if(g.grade >=8 , name , null )
  , g.grade 
  , s.marks 

from 
    students s
    
    join grades g
       on s.marks between g.min_mark and g.max_mark 

order by 
    g.grade desc
  , s.name ;
