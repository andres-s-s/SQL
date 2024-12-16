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




/* Mysql */
set @date = (
  select 
      min(submission_date) 
  
  from 
    submissions )
;
/* This gets the date of the first day of the contest */


select 
    mt.submission_date 
  , mt.ct /*Total number of unique hackers who made at least one submission each day*/
  , ( 
       select 
            s.hacker_id 
       
       from 
       submissions s 

       where 
              s.submission_date = mt.submission_date

       group by 
            s.hacker_id 
       
       order by 
            count(*) desc , 
            s.hacker_id asc 
       
       limit 1 
    ) as h_id /*Hacker id who made the most number of submissions per day*/
      
  , ( 
       select 
           name 
       
       from hackers h

       where 
          h.hacker_id = h_id 
      ) as h_name /*Hacker name who made maximum number of submissions per day*/

from  (

          select 
              t.submission_date 
            , count(*) 
                as ct 

          from  (
                          select 
                              s.submission_date 
                            , s.hacker_id 
                      
                          from 
                            submissions s
                          
                          group by 
                              s.submission_date 
                            , s.hacker_id   

              ) as t 
              /*
                A hacker can make several submissions the same day so this table gets a list
                of hackers and the day the made at least one submission
                So this table gets rid of extra submissions made by a hacker on the same day
                */
          where (
                          select 
                              count(distinct s.submission_date) 
                          
                          from submissions s
                          
                          where 
                                s.hacker_id = t.hacker_id  
                            and s.submission_date < t.submission_date 
                )  
            =  datediff(t.submission_date , @date )
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

          group by t.submission_date
          ) as mt

order by 
    mt.submission_date asc;



--mysql
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



--mysql
select 
    mt.submission_date 
  , count(*) 
  , h_idt.hacker_id 
  , h.name 

from (
    select 
        submission_date 
      , hacker_id 
      , if(hacker_id != @hv , @csct := 1 ,  @csct := @csct + 1 ) 
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
          select @csct := 1,@hv := 0 
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
          select @d := 0
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



--mysql favorite solution
set @date = 
(   select 
        min(submission_date) 
    from submissions 
);

select 
    dt.submission_date 
    ,(
      select 
          count(distinct hacker_id) 
      
      from 
        submissions as s
    
      where 
            submission_date = dt.submission_date 
        and ( 
              select 
                  count(distinct submission_date) 
                    
              from 
                submissions 
                    
              where 
                    s.submission_date > submission_date 
                and hacker_id = s.hacker_id
            ) 
        = datediff( dt.submission_date , @date )  
     ) 
  , (   
    select hacker_id 
      
    from 
      submissions 
      
    where 
          submission_date = dt.submission_date 
      
    group by 
        hacker_id 
      
    order by 
        count(*) desc 
      , hacker_id 
      
      limit 1 
    ) as h_id 
  , (
    select 
        name 
    
    from 
      hackers  
      
    where 
          h_id = hacker_id  )

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



--ms sql server
declare @date date;

set @date = 
(   select 
        min(submission_date) 
    from submissions 
);

select 
    submission_date 
  , ct 
  , h_id 
  , name 

from (
      select 
          mt.submission_date 
        , mt.ct 
        ,( 
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
         
         ) as h_id 
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
      ) xt 
  join hackers h 
    on xt.h_id = h.hacker_id 
 
order by 
    submission_date asc ;



--ms sql server
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



--ms sql server
select 
    mt.submission_date 
  , count(*) 
  , hid_t.hacker_id 
  , h.name

from (
      select 
          submission_date 
        , hacker_id 
        , row_number() 
            over(
              partition by 
                  hacker_id 
              
              order by 
                  hacker_id 
                , submission_date
                ) as ct
 
      from 
          submissions 
      
      group by 
          submission_date 
        , hacker_id
      
      ) as mt
 
  join (
        select 
            submission_date 
          , row_number() 
              over(
                order by 
                    submission_date
                  ) as ct
 
        from 
            submissions 
        
        group by 
            submission_date 
       ) as dt 
    on mt.ct = dt.ct and mt.submission_date = dt.submission_date

join (
      select 
          hacker_id 
        , submission_date 
        , row_number() 
            over(
              partition by 
                  submission_date 
              
              order by  
                  count(*) desc 
                , hacker_id 
                ) as ct 
      
      from 
        submissions 
      
      group by 
          submission_date 
        , hacker_id 
      ) as hid_t

  join hackers h 
     on h.hacker_id = hid_t.hacker_id                 /**/ 
     on hid_t.submission_date = mt.submission_date 
    and hid_t.ct = 1  /**/

group by 
    mt.submission_date 
  , hid_t.hacker_id 
  , h.name

order by 
    mt.submission_date asc



--ms sql server
declare @date date;

set @date = 
(   select 
        min(submission_date) 
    from submissions 
);

select 
    submission_date 
  , ct 
  , h_id 
  , name 

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
    
    from (
          select 
              distinct submission_date 
          
          from 
            submissions 
         ) as dt
     ) as t 

  join hackers h 
    on h.hacker_id = h_id

order by 
    submission_date asc ;
