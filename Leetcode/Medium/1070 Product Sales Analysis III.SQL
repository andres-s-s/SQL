--mysql  &  ms sql server
select product_id , year as first_year , quantity , price 
from   sales
where  concat(product_id , year ) in 
      (select concat( product_id , min(year) ) from sales 
       group by product_id ); 



--mysql  &  ms sql server 
with cte as (
    select product_id , min(year) as year 
    from sales group by product_id
)

select product_id , year as first_year , quantity , price 
from sales s
where year = (select year from cte c 
              where s.product_id = c.product_id  )  ;



--mysql
select product_id , year as first_year , quantity , price 
from sales
where (product_id , year ) in 
      (select product_id , min(year) from sales 
       group by product_id ); 



--mysql  &  ms sql server ---testcases passed, but took too long.
select product_id , year as first_year , quantity , price 
from (
    select dense_rank() 
    over(partition by product_id order by year asc ) as ind , 
    product_id , year , quantity , price 
    from sales
) as t 
where ind = 1 ; 
