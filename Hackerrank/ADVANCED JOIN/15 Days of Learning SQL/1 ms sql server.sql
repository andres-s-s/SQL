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
-- |  solution 1: ms sql server   
-- +--------------------------------------------------------------------+

declare @date date;

set @date = 
(   select 
        min(submission_date) 
    from submissions 
);


select 
    t.submission_date 
  , t.ct 
  , t.h_id 
  , (
      select 
          h.name 
      
      from 
          hackers h  
        
      where 
            t.h_id = h.hacker_id  
    )

from (
      select 
          dt.submission_date 
        ,( 
          select 
              count(distinct hacker_id) 
          
          from 
            submissions s
         
          where 
                submission_date = dt.submission_date 
            and (
                select 
                    count(distinct submission_date) 
                
                from 
                  submissions 
                
                where 
                      dt.submission_date > submission_date 
                  and hacker_id = s.hacker_id) 
            = datediff(dd, @date , dt.submission_date ) 
         ) as ct
        ,(
            select 
                top 1 hacker_id 
            
            from 
                submissions 
           
            where 
                  submission_date = dt.submission_date 
           
            group by 
                hacker_id 
          
            order by 
                count(*) desc 
              , hacker_id  
         ) as h_id 
         /*
            I can not do the same I did in the solution 1 and query the hacker name directly
            using the new created h_id field
            */
    
    from (
          select 
              distinct submission_date 
          
          from 
            submissions 
         ) as dt
     ) as t 

order by 
    submission_date asc ;
