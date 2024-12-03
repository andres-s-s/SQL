--mysql 
select start_date , 
    (select end_date from projects 
     where end_date not in (select start_date from projects)  
     and end_date > t.start_date 
     order by end_date limit 1 ) as end_date
from 
    (select start_date from projects 
     where start_date not in (select end_date from projects )  ) as t
order by end_date - start_date , start_date;



--mysql
select start_date , 
    (select min(end_date) from projects 
     where end_date not in (select start_date from projects)  
     and end_date > t.start_date 
    ) as end_date
from 
    (select start_date from projects 
     where start_date not in (select end_date from projects )  ) as t
order by end_date - start_date , start_date;



--mysql
select start_date , end_date from
    (select start_date , row_number() over(order by start_date ) as ind 
     from projects where start_date not in (select end_date from projects )  
    ) as t1
join 
    (select end_date   , row_number() over(order by end_date )   as ind 
     from projects where end_date not in (select start_date from projects)   
    ) as t2
on t1.ind = t2.ind 
order by datediff(  end_date , start_date ), start_date;



--mysql
select t1.start_date , t2.end_date from
    (select start_date , @num := @num + 1 as ind 
     from projects , (select @num := 0) as nt
     where start_date not in (select end_date from projects ) 
     order by start_date
    ) as t1
join 
    (select end_date  , @numb := @numb + 1 as ind  
     from projects , (select @numb := 0) as nt 
     where end_date not in (select start_date from projects)   
     order by end_date
    ) as t2
on t1.ind = t2.ind 
order by datediff(  end_date , start_date ), start_date;



--mysql
select min(start_date) , max(end_date) from (
    select start_date , end_date , sum(tf) over(order by start_date) as p
    from (
        select start_date , end_date ,  
            case when lag(end_date) over(order by start_date) = start_date
            then 0 else 1 end as tf
        from projects
         ) t
                ) as t2
group by p
order by datediff( max(end_date) , min(start_date)), min(start_date);



--mysql
select min(start_date) , max(end_date) from (
    select start_date , end_date , sum(tf) over(order by start_date) as p
    from (
        select start_date , end_date ,  
        if( lag(end_date) over(order by start_date) = start_date ,  0 , 1 )  as tf
        from projects
         ) t
                ) as t2
group by p
order by datediff( max(end_date) , min(start_date)), min(start_date);



--ms sql server
select start_date , end_date from (
    select start_date , 
       (select top 1 end_date from projects 
        where end_date not in (select start_date from projects)  
        and end_date > t.start_date 
        order by end_date ) as end_date
    from 
       (select start_date from projects 
        where start_date not in (select end_date from projects )  ) as t  ) t1
order by datediff(dd, start_date, end_date), start_date;



--ms sql server
select start_date , end_date from
    (select start_date , row_number() over(order by start_date ) as ind 
     from projects where start_date not in (select end_date from projects )  
    ) as t1
join 
    (select end_date   , row_number() over(order by end_date )   as ind 
     from projects where end_date not in (select start_date from projects)   
    ) as t2
on t1.ind = t2.ind 
order by datediff(dd, start_date, end_date), start_date;



--ms sql server
select min(start_date) , max(end_date) from (
    select start_date , end_date , sum(tf) over(order by start_date) as p
    from (
        select start_date , end_date ,  
            case when lag(end_date) over(order by start_date) = start_date
            then 0 else 1 end as tf
        from projects
         ) t
                ) as t2
group by p
order by datediff( dd, min(start_date) , max(end_date) ), min(start_date);
