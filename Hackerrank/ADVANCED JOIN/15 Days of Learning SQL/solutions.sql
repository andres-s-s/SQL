
/* 📝 📝  */

select 
    r.submission_date
  , r.cnt
  , r.h_id
  , h.name

from (

    select 
        d.submission_date
      , d.cnt
      , (
            select 
                s.hacker_id
            from 
                Submissions s
            where 
                s.submission_date = d.submission_date
            group by 
                s.hacker_id
            order by 
                count(*) desc
              , s.hacker_id asc
            limit 1  
        )
          as h_id
    from 
            (
            select 
                s.submission_date
              , count(distinct s.hacker_id)
                  as cnt

            from 
                Submissions s

            where 
                ( -- section t
                    select 
                        count(distinct sub.submission_date)
                    from 
                        Submissions sub
                    where 
                        sub.submission_date < s.submission_date
                ) -- section t end
                 =
                 (
                    select 
                        count(distinct sub.submission_date)
                    from 
                        Submissions sub
                    where
                          1=1
                      and sub.submission_date < s.submission_date
                      and sub.hacker_id = s.hacker_id
                 )

            group by 
                s.submission_date
            ) as d -- dates
) as r -- result, almost

    join Hackers h
       on h.hacker_id = r.h_id 

order by 
    r.submission_date asc





/*
You can replace limit 1 with 
    top 1 for ms sql
for ms sql server
*/



/*
You can replace section t with 

    datediff( s.submission_date , '2016-03-01' ) 


You can use a variable instead of writing '2016-03-01' in the datediff function

For mysql

    set @date = (   
      select 
          min(s.submission_date) 
      from 
          submissions s
                );


For ms sql server

    declare @date date;

    set @date = 
    (   select 
            min(submission_date) 
        from submissions 
    );

*/