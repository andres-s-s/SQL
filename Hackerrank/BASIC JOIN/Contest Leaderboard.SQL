/* mysql  &  ms sql server */
select 
    t.hacker_id 
  , t.name 
  , sum(t.m) 

from (
        select 
            h.hacker_id 
          , h.name 
          , max(score) as m  
        
        from 
            hackers h 
            
            join submissions s
               on h.hacker_id = s.hacker_id 
        
        group by 
            h.hacker_id 
          , h.name 
          , s.challenge_id
     ) as t

group by 
    t.hacker_id 
  , t.name 

having  
    sum(t.m) > 0

order by 
    sum(t.m) desc 
  , t.hacker_id;
