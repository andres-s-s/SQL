select 
    o.order_id
  , case 
      when o.order_id % 2 = 0 
      then lag(item)
             over(order by o.order_id)
      
      else coalesce(
              lead(item)
                over(order by o.order_id)
            , item 
      )
      end
      
from 
    orders o