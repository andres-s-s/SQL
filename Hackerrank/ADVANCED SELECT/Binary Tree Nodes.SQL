/* mysql  &  ms sql server */
select 
    b.n 
  , case 

      when b.p is null 
      then "Root"
         
      when b.n in (select distinct p from bst) 
      then "Inner"
         
      else "Leaf" 
    
    end

from 
    bst b 

order by 
    b.n;




/* mysql  &  ms sql server */
select 
    b.n 
  , case 
      
      when n.p is null 
      then "Root"
         
      when exists(select p from bst s where b.n = s.p ) 
      then "Inner"
         
      when (select count(p) from bst s where b.n = s.p ) = 0 
      then "Leaf" 
    
    end

from 
    bst b 

order by 
    b.n;



/* mysql */
with distinct_p as (
  select 
      distinct b.p 
  
  from 
      bst b)


select 
    b.n 
  , if( 
        b.p is null 
      , "Root" 
      , (
          if(
               b.n in (select p from distinct_p ) 
            , "Inner" 
            , "Leaf"
            ) 
        )
      ) 

from 
    bst b

order by 
    b.n; 
