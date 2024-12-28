/*
  Problem definition:
  Julia conducted a  days of learning SQL contest. The start date of the contest 
  was March 01, 2016 and the end date was March 15, 2016.

  Write a query to print total number of unique hackers who made at least 
  submission each day (starting on the first day of the contest), and find the 
  hacker_id and name of the hacker who made maximum number of submissions each day. 
  If more than one such hacker has a maximum number of submissions, print the lowest hacker_id. 
  The query should print this information for each day of the contest, sorted by the date.

  Output's example
  Date        Number of hackers   Hacker id and name
  2016-03-01      112             81314 Denise 
  2016-03-02      59              39091 Ruby 
  2016-03-03      51              18105 Roy 
  2016-03-04      49              533   Patrick 
  2016-03-05      49              7891  Stephanie 
  2016-03-06      49              84307 Evelyn 
  2016-03-07      35              80682 Deborah 
  2016-03-08      35              10985 Timothy 
  2016-03-09      35              31221 Susan 
  2016-03-10      35              43192 Bobby 
  2016-03-11      35              3178  Melissa 
  2016-03-12      35              54967 Kenneth 
  2016-03-13      35              30061 Julia 
  2016-03-14      35              32353 Rose 
  2016-03-15      35              27789 Helen 

  Of course I tried to use CTEs but the version they use does not support this feature

*/





-- +--------------------------------------------------------------------+
-- |  solution 3: mysql
-- +--------------------------------------------------------------------+


select 
    mt.submission_date 
  , count(*) 
  , h_idt.hacker_id 
  , h.name 

from (
    select 
        submission_date 
      , hacker_id 
      , if(   
              hacker_id != @hv 
            , @csct := 1 
            , @csct := @csct + 1 ) 
          as h_rank 
      , @hv := hacker_id  
    
    from (
            select 
                distinct submission_date 
              , hacker_id  
            
            from 
              submissions 
            
            order by 
                hacker_id 
              , submission_date  
          ) as sd 
        ,(
            select 
                @csct := 1
              , @hv := 0 
          ) as et 
) as mt


    join (
          select 
              submission_date 
            , @d := @d + 1 
                as d_rank

          from (
                select 
                    distinct submission_date 
      
                from 
                  submissions 
                
                order by 
                    submission_date asc ) 
                  as idt
              , (
                  select 
                      @d := 0
                ) as dv 
      ) as dt
    on dt.submission_date = mt.submission_date and mt.h_rank = dt.d_rank

  join (
      select 
          submission_date 
        , hacker_id 
        , @mc := 
            case 
              when submission_date = @ahv 
              then @mc + 1 
              else 1 
            end as mch 
        , @ahv := submission_date
      
    from (
        select 
            submission_date 
          , hacker_id 
        
        from 
          submissions 
        
        group by 
            submission_date 
          , hacker_id 
        
        order by 
            submission_date 
          , count(*) desc
          , hacker_id) m 
          , (select @mc := 0,@ahv := 0) et2
       
       ) as h_idt
    on h_idt.submission_date = mt.submission_date and h_idt.mch = 1

  join hackers h 
    on h_idt.hacker_id = h.hacker_id

group by 
    mt.submission_date 
  , h_idt.hacker_id 
  , h.name

order by 
    mt.submission_date asc;
