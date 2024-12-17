-- 1
select 
    item_count 
      as mode

from 
    items_per_order

where 
      1=1
  and order_occurrences = 
        (select 
            max(order_occurrences) 
         
         from 
          items_per_order)

order by 
    item_count asc ;


-- 2
select 
    item_count 
      as mode

from 
  items_per_order

where 
  order_occurrences = 
      ( select 
            mode() within group (order by order_occurrences desc) 

        from 
          items_per_order)

order by 
  item_count asc ;
