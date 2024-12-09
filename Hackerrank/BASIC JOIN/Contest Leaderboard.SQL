--mysql  &  ms sql server 
select 
    hacker_id 
  , name 
  , sum(m) 

from 
    (select h.hacker_id , name , max(score) as m  from hackers h join submissions s
     on h.hacker_id = s.hacker_id group by h.hacker_id , name , s.challenge_id) as t

group by hacker_id , name 

having  sum(m) > 0

order by sum(m) desc , hacker_id;
