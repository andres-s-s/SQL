--mysql
set @date = (select min(submission_date) from submissions );

select 
    mt.submission_date 
  , mt.ct 
  , 
      (select hacker_id from submissions where submission_date = mt.submission_date
       group by hacker_id order by count(*) desc , hacker_id asc limit 1 ) as h_id 
  , (select name from hackers where hacker_id = h_id )

from  (
       select t.submission_date , count(*) as ct from  (
          select submission_date , hacker_id from submissions 
          group by submission_date , hacker_id   ) as t 
          where (select count(distinct submission_date) from submissions 
                 where hacker_id = t.hacker_id  and submission_date < t.submission_date )  
          =  datediff(t.submission_date , @date )
       group by t.submission_date
      ) as mt
order by 
    mt.submission_date asc;



--mysql
set @date = (select min(submission_date) from submissions );

select  
    mt.submission_date 
  , mt.ct 
  , h.hacker_id 
  , name 
from  (
    select submission_date , count(*) as ct from  (
           select submission_date , hacker_id from submissions 
           group by submission_date , hacker_id   ) as t 
    where (select count(distinct submission_date) from submissions 
           where hacker_id = t.hacker_id  and
           submission_date < t.submission_date )  
    =  datediff( t.submission_date , @date )
    group by t.submission_date
      ) as mt
join  submissions s on mt.submission_date = s.submission_date
join  hackers h     on s.hacker_id = h.hacker_id 
where s.hacker_id = (select hacker_id from submissions where submission_date = mt.submission_date
                     group by hacker_id order by count(*) desc , hacker_id asc limit 1
                     )
group by mt.submission_date , mt.ct , h.hacker_id , name 
order by mt.submission_date asc;



--mysql
select 
    mt.submission_date 
  , count(*) 
  , h_idt.hacker_id 
  , h.name 

from (
     select submission_date , hacker_id , 
     if(hacker_id != @hv , @csct := 1 ,  @csct := @csct + 1 ) as h_rank , @hv := hacker_id  
     from (select distinct submission_date , hacker_id  from submissions 
           order by hacker_id , submission_date  ) sd , (select @csct := 1,@hv := 0 ) et 
) as mt
join (
     select submission_date , @d := @d + 1 as d_rank
     from (select distinct submission_date from submissions order by submission_date asc ) idt,
          (select @d := 0) dv 
) as dt
on dt.submission_date = mt.submission_date and mt.h_rank = dt.d_rank
join (
     select submission_date , hacker_id ,
     @mc := case when submission_date = @ahv then @mc + 1 else 1 end as mch , @ahv := submission_date
     from (select submission_date , hacker_id from submissions group by submission_date , hacker_id 
           order by submission_date , count(*) desc, hacker_id) m , (select @mc := 0,@ahv := 0) et2
) as h_idt
on h_idt.submission_date = mt.submission_date and h_idt.mch = 1
join hackers h on  h_idt.hacker_id = h.hacker_id
group by mt.submission_date , h_idt.hacker_id , h.name
order by mt.submission_date asc;



--mysql
set @date = (select min(submission_date) from submissions );

select 
    dt.submission_date 
  , (select count(distinct hacker_id) from submissions as s
     where submission_date = dt.submission_date 
     and   (select count(distinct submission_date) from submissions 
            where s.submission_date > submission_date 
            and hacker_id = s.hacker_id) = 
    datediff( dt.submission_date , @date )  ) 
  , (select hacker_id from submissions 
     where submission_date = dt.submission_date 
     group by hacker_id 
     order by count(*) desc , hacker_id limit 1  ) as h_id 
  , (select name from hackers  where h_id = hacker_id  )

from (select distinct submission_date 
      from submissions 
      order by submission_date asc  ) as dt
order by dt.submission_date asc;



--ms sql server
declare @date date;
set @date = (select min(submission_date) from submissions );

select submission_date , ct , h_id , name from (
select mt.submission_date , mt.ct , 
      (select top 1 hacker_id from submissions where submission_date = mt.submission_date
       group by hacker_id order by count(*) desc , hacker_id asc ) as h_id 
from  (
select submission_date , count(*) as ct from  (
       select submission_date , hacker_id from submissions 
       group by submission_date , hacker_id   ) as t 
where (select count(distinct submission_date) from submissions 
       where hacker_id = t.hacker_id  and
       submission_date < t.submission_date )  
    =  datediff(dd, @date , t.submission_date )
group by t.submission_date
      ) as mt
 ) xt 
 join hackers h on xt.h_id = h.hacker_id 
 order by submission_date asc ;



--ms sql server
declare @date date;
set @date = (select min(submission_date) from submissions );
select mt.submission_date , mt.ct , h.hacker_id , name 
from  (
select submission_date , count(*) as ct from  (
       select submission_date , hacker_id from submissions 
       group by submission_date , hacker_id   ) as t 
where (select count(distinct submission_date) from submissions 
       where hacker_id = t.hacker_id  and
       submission_date < t.submission_date )  
    =  datediff(dd, @date , t.submission_date )
group by t.submission_date
      ) as mt
join  submissions s on mt.submission_date = s.submission_date
join  hackers h     on s.hacker_id = h.hacker_id 
where s.hacker_id = (select top 1 hacker_id from submissions where submission_date = mt.submission_date
                     group by hacker_id order by count(*) desc , hacker_id asc 
                     )
group by mt.submission_date , mt.ct , h.hacker_id , name 
order by mt.submission_date asc;



--ms sql server
select mt.submission_date , count(*) , hid_t.hacker_id , h.name
from
(select submission_date , hacker_id , 
 row_number() over(partition by hacker_id order by hacker_id ,submission_date) as ct
 from submissions group by submission_date , hacker_id) as mt
 join 
(select submission_date , row_number() over(order by submission_date) as ct
 from submissions group by submission_date ) as dt 
on mt.ct = dt.ct and mt.submission_date = dt.submission_date
join 
(select hacker_id , submission_date ,
 row_number() over(partition by submission_date order by  count(*) desc , hacker_id )
 as ct from submissions group by submission_date , hacker_id ) as hid_t
join hackers h on h.hacker_id = hid_t.hacker_id                 /**/ 
on hid_t.submission_date = mt.submission_date and hid_t.ct = 1  /**/
group by mt.submission_date , hid_t.hacker_id , h.name
order by mt.submission_date asc



--ms sql server
declare @date date;
set @date = (select min(submission_date) from submissions );
select submission_date , ct , h_id , name from (
    select dt.submission_date , 
        (select count(distinct hacker_id) from submissions as s
         where submission_date = dt.submission_date 
         and   (select count(distinct submission_date) from submissions 
                where dt.submission_date > submission_date 
                and hacker_id = s.hacker_id) = 
        datediff(dd, @date , dt.submission_date )  ) as ct,
    
        (select top 1 hacker_id from submissions 
         where submission_date = dt.submission_date 
         group by hacker_id 
         order by count(*) desc , hacker_id  ) as h_id 
    from (select distinct submission_date 
          from submissions 
         ) as dt
    ) as t 
join hackers h on h.hacker_id = h_id
order by submission_date asc ;
