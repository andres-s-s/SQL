/*
Instructions:
Given a list of pizza toppings, consider all the possible 3-topping pizzas, and print out the total cost of those 3 toppings.
Sort the results with the highest total cost on the top followed by pizza toppings in ascending order
*/


select
    concat( p1.topping_name ,  ','  , p2.topping_name ,  ','  , p3.topping_name ) as pizza
  , p1.ingredient_cost + p2.ingredient_cost + p3.ingredient_cost as total_cost

from 
    pizza_toppings as p1
  , pizza_toppings as p2
  , pizza_toppings as p3

where 
      1=1
  and p1.topping_name < p2.topping_name --This will be a match      Jalapenos < Onions
  and p2.topping_name < p3.topping_name --This will not be a match  Onions    < Jalapenos
  /*
  Remember that a < z 
  Making these joins using these conditions will also allow us not to repeat a list of ingredients 
  in different order, each row is unique
  */

order by
    total_cost desc
  , pizza asc;
