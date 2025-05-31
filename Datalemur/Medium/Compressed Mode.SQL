/*
You're given a table containing the item count for each order on Alibaba, along 
with the frequency of orders that have the same item count. Write a query to retrieve 
the mode of the order occurrences. Additionally, if there are multiple item counts
with the same mode, the results should be sorted in ascending order.

*/

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
