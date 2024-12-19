/* mysql  &  ms sql serve */
select (select id from wands where code = t.code and t.power = power and coins_needed = min_c) , 
age , min_c , power from 
(select w.code , power , age , min(coins_needed) as min_c from wands as w join wands_property as wp
 on w.code = wp.code where is_evil = 0
 group by  w.code , power , age) as t
order by power desc , age desc;



/* mysql  &  ms sql server */
select id , t.age , t.min_c , t.power from 
    (select w.code , power , age , min(coins_needed) as min_c from wands as w join wands_property as wp
    on w.code = wp.code where is_evil = 0
    group by  w.code , power , age) as t 
join wands as w on t.code = w.code and w.coins_needed = min_c and w.power = t.power
order by power desc , age desc;



/* mysql  &  ms sql server */
select (select id from wands w2 join wands_property wp2  on w2.code = wp2.code 
        where wp.age = wp2.age and w.power = w2.power and  coins_needed = min(w.coins_needed)
        and is_evil = 0 ) , 
age , min(coins_needed) as min_c , power 
from wands as w join wands_property as wp on w.code = wp.code 
where is_evil = 0
group by power , age 
order by power desc , age desc;



/* mysql  &  ms sql server */
select id , age , coins_needed , power 
from wands as w join wands_property as wp on w.code = wp.code 
where is_evil = 0 
and coins_needed = (select min(coins_needed) from wands as w2 join wands_property as wp2 on w2.code = wp2.code
                    where wp2.age = wp.age and w.power = w2.power )
order by power desc , age desc;



/* ms sql server */
select id , age ,coins_needed , power from (
    select id , power , age , coins_needed ,
    row_number() over(partition by power , age order by coins_needed asc ) as coun 
    from wands as w join wands_property as wp on w.code = wp.code where is_evil = 0 ) as t
where coun = 1 
order by power desc , age desc;



/* ms sql server */
select id , age ,coins_needed , power from (
    select id , power , age , coins_needed ,
    min(coins_needed) over(partition by power , age ) as min_c
    from wands as w join wands_property as wp on w.code = wp.code where is_evil = 0 ) as t
where min_c = coins_needed
order by power desc , age desc;