--mysql  &  ms sql server
select c.contest_id , hacker_id , name ,
sum(ts) , sum(tas) , sum(tv) , sum(tuv)
from contests   c 
join colleges   cl on c.contest_id  = cl.contest_id
join challenges ch on cl.college_id = ch.college_id
left join (select challenge_id , sum(total_submissions) as ts , 
          sum(total_accepted_submissions) as tas from submission_stats 
          group by challenge_id ) as t1  
on ch.challenge_id = t1.challenge_id 
left join (select challenge_id , sum(total_views) as tv , 
          sum(total_unique_views) as tuv from view_stats 
          group by challenge_id ) as t2
on ch.challenge_id = t2.challenge_id 
group by c.contest_id , hacker_id , name 
having sum(ts)+sum(tas)+sum(tv)+sum(tuv)>0 
order by c.contest_id;



--mysql  &  ms sql server
select c.contest_id , hacker_id , name ,
sum(ts) , sum(tas) , sum(tv) , sum(tuv)
from contests   c 
join colleges   cl on c.contest_id  = cl.contest_id
join (select max(college_id) as college_id , challenge_id from challenges
      group by challenge_id) as ch 
on cl.college_id = ch.college_id
left join (select challenge_id , sum(total_submissions) as ts , 
          sum(total_accepted_submissions) as tas from submission_stats 
          group by challenge_id ) as t1  
on ch.challenge_id = t1.challenge_id 
left join (select challenge_id , sum(total_views) as tv , 
          sum(total_unique_views) as tuv from view_stats 
          group by challenge_id ) as t2
on ch.challenge_id = t2.challenge_id 
group by c.contest_id , hacker_id , name 
having sum(ts)+sum(tas)+sum(tv)+sum(tuv)>0
order by c.contest_id;



--ms sql server
with sst as (select challenge_id , sum(total_submissions) as ts , 
           sum(total_accepted_submissions) as tas from submission_stats 
           group by challenge_id ),
    vst as (select challenge_id , sum(total_views) as tv , 
           sum(total_unique_views) as tuv from view_stats 
           group by challenge_id )
select c.contest_id , hacker_id , name ,
sum(ts) , sum(tas) , sum(tv) , sum(tuv)
from contests   c 
join colleges   cl on c.contest_id  = cl.contest_id
join challenges ch on cl.college_id = ch.college_id
left join  sst on ch.challenge_id = sst.challenge_id 
left join  vst on ch.challenge_id = vst.challenge_id 
group by c.contest_id , hacker_id , name 
having sum(ts)+sum(tas)+sum(tv)+sum(tuv)>0
order by c.contest_id;
