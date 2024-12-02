select 
    category 
  , product 
  , sp as total_spend 

from (
    select 
        * 
      , row_number() 
            over(
                partition by 
                    category 
                order by 
                    sp desc
                    ) 
            as ind
    from (
        select 
            category 
          , product 
          , sum(spend) 
                as sp
        
        from 
            product_spend
        
        where 
            extract( year from transaction_date ) = '2022'
        
        group by 
            category 
          , product 
    ) as t 
) as t2
where ind in ( 1 , 2 );
