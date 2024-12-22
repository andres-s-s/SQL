--mysql  &  ms sql server
select 
    round(count(*) 
        / cast( 
                (
                  select 
                      count(distinct customer_id) 
                  
                  from 
                      delivery  
                ) 
            as float 
              ) * 100 
        , 2 
         )
      as immediate_percentage

from (
  select 
      customer_id 
    , min(order_date) 
        as dt 
    , min(customer_pref_delivery_date) 
        as cpddt
  
  from 
      delivery
  
  group by 
      customer_id
     ) as t

where 
    cpddt =  dt ;



--mysql  &  ms sql server
select 
  round( 
          count(*) 
        / cast( 
                (
                    select 
                        count(distinct customer_id) 
                    
                    from 
                        delivery  
                ) as float 
              ) * 100 
      , 2 )
    as immediate_percentage

from 
    delivery

where 
      1=1
  and order_date = customer_pref_delivery_date 
  and concat( customer_id,order_date ) in (
                                              select 
                                                  concat( 
                                                            customer_id
                                                          , min(order_date) 
                                                        )
                                              
                                              from 
                                                  delivery
                                              
                                              group by 
                                                  customer_id 
                                          ) ;




--mysql  &  ms sql server
select 
    round( 
            avg( 
                  case 
                      when order_date = customer_pref_delivery_date 
                      then 1.0 
                      
                      else 0.0 
                  end
               ) * 100.00 
          , 2 
         ) 
      as immediate_percentage

from (
        select 
            customer_id 
          , order_date 
          , customer_pref_delivery_date 
          , row_number() 
              over(
                partition by 
                    customer_id 
                order by 
                    order_date asc
                  ) 
              as ind
        
        from 
            delivery
     ) as t

where 
    ind = 1 ;
