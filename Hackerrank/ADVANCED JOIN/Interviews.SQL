/*
  Samantha interviews many candidates from different colleges using coding challenges 
  and contests. 

  Write a query to print the contest_id, hacker_id, name, and the 
  sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views 
  for each contest sorted by contest_id. Exclude the contest from the result if 
  all four sums are 0.
  
  Note: A specific contest can be used to screen candidates at more than one 
  college, but each college only holds 1 screening contest.

  Contests                    Colleges                      Challenges
  contest_id    integer       college_id    integer         challenge_id      integer
  hacker_id     integer       contest_id    integer         college_id        integer
  name          string


  View_Stats                            Submission_Stats
  challenge_id          integer         challenge_id                  integer
  total_views           integer         total_submissions             integer
  total_unique_views    integer         total_accepted_submission     integer
  */



-- Version 5.7.27-0ubuntu0.18.04.1 , not possible to use CTEs



/*
  This problem is a tiny bit confusing so here there are some things you need to know

  In the View_Stats and Submission_Stats tables you can find the same challenge id 
  several times so it's necessary to group by challenge_id and there are some
  challenge_id records lacking in those tables

  In the Challenges table each challenge_id is unique

  Even though the same contest can be used to screen candidates at more than one 
  college, every college relates to unique challenge ids
  */





-- +--------------------------------------------------------------------+
-- |  solution 1: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


select 
    c.contest_id 
  , c.hacker_id 
  , c.name        -- hacker name
  , sum(s.ts)     -- total_submissions
  , sum(s.tas)    -- total_accepted_submissions
  , sum(v.tv)     -- total_views
  , sum(v.tuv)    -- total_unique_views

from 
    contests c 

    join colleges cl 
       on c.contest_id  = cl.contest_id

    join challenges ch 
       on cl.college_id = ch.college_id

    left join ( -- not every challenge_id is in this table, that's why left join
                  select 
                      challenge_id 
                    , sum(total_submissions) 
                        as ts 
                    , sum(total_accepted_submissions) 
                        as tas 

                  from 
                      submission_stats 

                  group by 
                      challenge_id 
              )
       as s
       on ch.challenge_id = s.challenge_id 

    left join ( -- not every challenge_id is in this table, that's why left join
                    select 
                        challenge_id 
                      , sum(total_views) 
                          as tv
                      , sum(total_unique_views) 
                          as tuv 

                    from 
                        view_stats 

                    group by 
                        challenge_id 
              )
       as v 
       on ch.challenge_id = v.challenge_id 

group by 
    c.contest_id 
  , c.hacker_id 
  , c.name 

having ( 
           sum(s.ts)
         + sum(s.tas)  
         + sum(v.tv)  
         + sum(v.tuv) 
       ) > 0

order by 
    c.contest_id;





-- +--------------------------------------------------------------------+
-- |  solution 2: ms sql server   
-- +--------------------------------------------------------------------+


with sst as (
  select 
      challenge_id 
    , sum(total_submissions) 
        as ts 
    , sum(total_accepted_submissions) 
        as tas 
    
  from 
    submission_stats 

  group by 
    challenge_id  
            )



, vst as (
  select 
      challenge_id 
    , sum(total_views) 
        as tv 
    , sum(total_unique_views) 
        as tuv 
   
  from 
    view_stats 

  group by 
      challenge_id )



select 
    c.contest_id 
  , c.hacker_id 
  , c.name            -- hacker name
  , sum(sst.ts)       -- total_submissions
  , sum(sst.tas)      -- total_accepted_submissions
  , sum(vst.tv)       -- total_views
  , sum(vst.tuv)      -- total_unique_views

from 
  contests c 

  join colleges cl 
     on c.contest_id  = cl.contest_id

  join challenges ch 
     on cl.college_id = ch.college_id

  left join sst -- not every challenge_id is in this table, that's why left join
     on ch.challenge_id = sst.challenge_id 

  left join vst -- not every challenge_id is in this table, that's why left join
     on ch.challenge_id = vst.challenge_id 

group by 
    c.contest_id 
  , c.hacker_id 
  , c.name 

having ( 
            sum(sst.ts)       -- total_submissions
          + sum(sst.tas)      -- total_accepted_submissions
          + sum(vst.tv)       -- total_views
          + sum(vst.tuv)      -- total_unique_views
       ) > 0

order by 
    c.contest_id;