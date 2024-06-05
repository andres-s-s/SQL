-- 1 
select 
round(
  case when length(d_set) % 2 != 0 
    then  CAST( SUBSTRING( d_set , CAST(CEIL(length(d_set)/2 ) as int ) , 1 ) as int )
    else (CAST( SUBSTRING( d_set , length(d_set)/2 , 1 )     as int ) +
          CAST( SUBSTRING( d_set , length(d_set)/2 + 1 , 1 ) as int ) )/2.0
  end , 1 ) as median
from (
    select STRING_AGG(numb , '') as d_set
    from (
        select REPEAT( CAST( searches as VARCHAR ) , num_users ) as numb
        from  search_frequency
        ORDER BY searches ASC
    ) as T 
) as T2;



-- 2
WITH T as (
  select searches , GENERATE_SERIES(1 , num_users , 1)
  from search_frequency
)
select 
  round(PERCENTILE_CONT(0.50) 
    WITHIN GROUP ( ORDER BY searches )::DECIMAL , 1 ) 
  as median
from T;
