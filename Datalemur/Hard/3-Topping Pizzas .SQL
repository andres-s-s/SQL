select 
    concat(p1.topping_name , ',' , p2.topping_name , ',' , p3.topping_name)  as pizza  
  , p1.ingredient_cost + p2.ingredient_cost + p3.ingredient_cost as total_cost

from 
    pizza_toppings as p1
  , pizza_toppings as p2
  , pizza_toppings as p3

where 
      p1.topping_name < p2.topping_name
  and p2.topping_name < p3.topping_name

order by 
    total_cost desc 
  , pizza asc;
