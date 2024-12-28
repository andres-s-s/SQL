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
-- |  solution 2: mysql
-- +--------------------------------------------------------------------+


set @date = (
  select 
      min(submission_date) 
    
  from 
    submissions );
/* This gets the date of the first day of the contest */


select  
    mt.submission_date 
  , mt.ct /* Total number of unique hackers who made at least one submission each day*/
  , h.hacker_id /*Hacker id who made the most number of submissions per day*/
  , h.name        /*Hacker name who made the most number of submissions per day*/
from  (
        select 
            submission_date 
          , count(*) 
              as ct 
        
        from  (
              select 
                  submission_date 
                , hacker_id 
                
                from 
                  submissions 
              
              group by 
                  submission_date 
                , hacker_id   ) 
                as t 
              /*
                A hacker can make several submissions the same day so this table gets a list
                of hackers and the day the made at least one submission
                So this table gets rid of extra submissions made by a hacker on the same day
                */
        where (
              select 
                  count(distinct submission_date) 
              
              from 
                submissions 
              
              where 
                    hacker_id = t.hacker_id  
                and submission_date < t.submission_date )  
              =  datediff( t.submission_date , @date )
        group by t.submission_date
              /*
                This where condicion from the first subquery summons a table, this is how it works
                We have the table t with 2 columns,submission_date and hacker_id, remember it
                Imagine this
                For the first day It gets a hacker_id from a hacker who made a submission that day
                Then it looks for the amount of records before that day for that hacker_id
                After that it compares that amount of records for that hacker with the amount of days
                  before that submission_date
                In this case it will be 0 because it's the first day and the count function will return 0
                  datediff(t.submission_date , @date ) will also return 0 
                  That is because all the hackers who made a submission the first day meet the requirement
                  of having made a submission since the first day 
                I know this might be confusion but bear with me 

                For the second day It gets a hacker_id from a hacker who made a submission that day
                Then it looks for the amount of records before that day for that hacker_id
                After that it compares that amount of records for that hacker with the amount of days
                  before that submission_date
                If the hacker made a submission the first day the count function will return 1 
                  and the datediff(t.submission_date , @date ) will return 1 but if that hacker
                  did not make a submission that day there is no match 

                Look at this example

                Record being analized
                2016-03-06 49 84307 Evelyn

                Evelyn's records from previous days
                2016-03-01 112 84307 Evelyn
                2016-03-02 59 84307 Evelyn
                2016-03-05 49 84307 Evelyn

                From 2016-03-01 to 2016-03-06 There are 5 days but the previos records are not 5
                  therefore Evelyn didn't make submissions each day 
                
                After filtering those records They are grouped by submission_date
                That's how we get total number of unique hackers who made at least 
                  submission each day

                */
          ) as mt

    join  
      submissions s 
      on mt.submission_date = s.submission_date
      /*
        From the subquery called mt we get the day of the contest and number of hackers
        but it's necessary to obtain the hacker_id and the name, the submissions table
        has that information thus the join uses submission_date field, because it is found
        in both tables (submissions and mt subquery)
        */

    join  
      hackers h     
      on s.hacker_id = h.hacker_id 
      /*
        This join is to get the hacker names, this information is not found in the submissions
        table but this last table has a hacker_id that is linked to a name
        */

where 
      s.hacker_id = ( select 
                          s.hacker_id

                      from 
                        submissions s

                      where s.submission_date = mt.submission_date

                      group by 
                          s.hacker_id 

                      order by 
                        count(*) desc  
                      , s.hacker_id asc 

                      limit 1 
                     )
      /*
        Now It's vital to get rid of the IDs and names, the query without this where condition
        and the group clause would look like the submission table plus the hacker names and
        the total number of unique hackers who made at least one submission each day
        */

group by 
    mt.submission_date 
  , mt.ct 
  , h.hacker_id 
  , h.name 

order by 
    mt.submission_date asc;