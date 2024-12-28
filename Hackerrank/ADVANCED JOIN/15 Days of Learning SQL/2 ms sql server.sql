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
-- |  solution 2: ms sql server   
-- +--------------------------------------------------------------------+

declare @date date;

set @date = 
(   select 
        min(submission_date) 
    from 
      submissions 
);

select 
    mt.submission_date 
  , mt.ct 
  , h.hacker_id 
  , name 

from (
      select 
          submission_date 
        , count(*) as ct 
        
        from (
              select 
                  submission_date 
                , hacker_id 
              
              from submissions 
              
              group by 
                  submission_date 
                , hacker_id   
             ) as t 
      
      where (
              select 
                  count(distinct submission_date) 
              
              from submissions 
              
              where 
                    hacker_id = t.hacker_id  
                and submission_date < t.submission_date 
            )  
            =  datediff(dd, @date , t.submission_date )
      
      group by 
          t.submission_date
     ) as mt
  
  join submissions s 
    on mt.submission_date = s.submission_date

  join hackers h
    on s.hacker_id = h.hacker_id 

where 
      s.hacker_id = (
                      select 
                          top 1 hacker_id 
                      
                      from 
                        submissions 
                      
                      where 
                            submission_date = mt.submission_date
                     
                      group by 
                          hacker_id 
                      
                      order by 
                          count(*) desc 
                        , hacker_id asc 
                    )

group by 
    mt.submission_date 
  , mt.ct 
  , h.hacker_id 
  , name 

order by 
    mt.submission_date asc;
