--mysql  &  ms sql server 
with tl as (select h.hacker_id , name , count(*) as c ,
                     row_number() over(partition by count(*) order by h.hacker_id) as counter
                     from hackers as h join challenges as c 
                     on h.hacker_id = c.hacker_id group by  h.hacker_id , name )
                     
select hacker_id , name , c from tl 
where c  = (select max(c) from tl ) 
or  c not in(select c from tl where counter = 2)
order by c desc , hacker_id;



--mysql  &  ms sql server 
select h.hacker_id , name , count(*) 
from hackers as h join challenges as c on h.hacker_id = c.hacker_id
group by  h.hacker_id , name 
having  count(*) = (select max(co) from (select count(*) as co from challenges group by hacker_id) as t )
or  count(*) in    (select coun from (select count(*) as coun from challenges group by hacker_id) as t
                    group by coun having count(*) = 1)
order by count(*) desc ,  h.hacker_id;



--ms sql server
select hacker_id , name , cnt from (
    select hacker_id , name , cnt , count(*) over(partition by cnt) as s_cnt , 
    max(cnt) over() as ma from (
        select h.hacker_id , name , count(*) as cnt
        from hackers as h join challenges as c on h.hacker_id = c.hacker_id
        group by  h.hacker_id , name  ) as t  ) t2
where cnt = ma or s_cnt = 1 
order by cnt desc , hacker_id
