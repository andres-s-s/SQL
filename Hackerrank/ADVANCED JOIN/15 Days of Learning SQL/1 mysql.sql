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
-- |  solution 1: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


set @date = (   
  select 
      min(s.submission_date) 
  from 
      submissions s
            );


select 
    dt.submission_date 
    ,( 
        select 
            count(distinct s.hacker_id) 
        
        from 
          submissions s
      
        where 
              submission_date = dt.submission_date 
          and ( 
                select 
                    count(distinct u.submission_date) 
                      
                from 
                  submissions u
                      
                where 
                      s.submission_date > u.submission_date 
                  and u.hacker_id = s.hacker_id
              ) = datediff( dt.submission_date , @date )  
                    /*
                        Alternative for the datediff line of code
                        (
                        select 
                            count(distinct b.submission_date )
                        from 
                            submissions b
                        where 
                              s.submission_date > b.submission_date
                        )
                      */
     ) /* Total number of unique hackers who made at least one submission each day */
  , (   
      select 
          s.hacker_id 
        
      from 
          submissions s
        
      where 
            s.submission_date = dt.submission_date 
        
      group by 
          s.hacker_id 
        
      order by 
          count(*) desc 
        , s.hacker_id 
        
        limit 1 
    ) as h_id  /*  Hacker id who made the most submissions per day  */
  , (
      select 
          h.name 
      
      from 
          hackers h  
        
      where 
            h_id = h.hacker_id  
    )  /*  Hacker name who made the most number of submissions per day  */

from (  
        select 
            distinct submission_date 
        
        from 
          submissions 
        
        order by 
            submission_date asc  
      ) as dt

order by 
    dt.submission_date asc;
