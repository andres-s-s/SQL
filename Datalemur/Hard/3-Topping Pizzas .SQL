/*
  Instructions:
  Given a list of pizza toppings, consider all the possible 3-topping pizzas, and print 
  out the total cost of those 3 toppings.

  Sort the results with the highest total cost on the top followed by pizza topping names 
  in ascending order

  There is only one table called pizza_toppings
*/


/*
  Cross joins will allow having all the possible combinations and the conditions in the 
  where statement make sure each row is unique
*/

select
    concat(   
              p1.topping_name 
            ,  ','  
            , p2.topping_name 
            ,  ','  
            , p3.topping_name 
          ) 
      as pizza
  , p1.ingredient_cost  +  p2.ingredient_cost  +  p3.ingredient_cost 
      as total_cost

from 
    pizza_toppings p1
  , pizza_toppings p2
  , pizza_toppings p3

where 
      1=1
  and p1.topping_name < p2.topping_name --This will be a match      Jalapenos < Onions
  and p2.topping_name < p3.topping_name --This will NOT be a match  Onions    < Jalapenos
  /*
    Remember that a < z 
    Using these conditions will also allow us not to repeat a list of ingredients 
    in different order, each row is unique


    Using < allows to get the pizza toppings in alphabetical order in the concat funtion
    Well as shown in the next piece of code this is not technically true but in order not 
    to over complicate things I did it this way.
    */

order by
    total_cost desc -- Sum of the cost of the ingredients
  , pizza asc; -- Concat function





/*
  Alternative
  Just for practice, I replace < with > and the logic of the where conditions is now in 
  the join statements

  In the select statement the order of the topping_names is the opposite as before
  Now you can see it starts with p3.topping_name because of the > change
*/

select
    (
           p3.topping_name
        ||  ','  
        || p2.topping_name 
        ||  ','  
        || p1.topping_name 
     )
      as pizza
  , p1.ingredient_cost  +  p2.ingredient_cost  +  p3.ingredient_cost 
      as total_cost

from 
    pizza_toppings p1

    join pizza_toppings p2
       on p1.topping_name > p2.topping_name
    
    join pizza_toppings p3
       on p2.topping_name > p3.topping_name

order by
    total_cost desc -- Sum of the cost of the ingredients
  , pizza asc; -- Concat function



