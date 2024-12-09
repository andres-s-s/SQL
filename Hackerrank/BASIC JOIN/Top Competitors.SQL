--mysql  &  ms sql server
select 
    h.hacker_id 
  , name 

from 
    hackers as h 
  
    join submissions as s 
    on h.hacker_id = s.hacker_id

    join challenges as c 
    on s.challenge_id = c.challenge_id 

    join difficulty as d 
    on c.difficulty_level = d.difficulty_level

where 
    d.score = s.score /*we can replace this where with and*/

group by h.hacker_id , name 
having count(*) > 1

order by count(*) desc ,  h.hacker_id ;
