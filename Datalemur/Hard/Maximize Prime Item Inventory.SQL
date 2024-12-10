/*
Instructions:
Amazon wants to maximize the storage capacity of its 500,000 square-foot warehouse by 
prioritizing a specific batch of prime items.

A bach is a group of items that belong to the same category either prime_eligible or not_prime
There must be at the very least one batch of not_prime products
Products must be stocked in batches
Prime_eligible products must be prioritized.
Output how many not_prime and prime_eligible items fit in the warehouse 
*/


with 
    summary as (
  select     -- When the "case when statment" does not find a match it'll put a null value
      sum(   case when item_type = 'not_prime'      then square_footage end ) as np_sf   
    , count( case when item_type = 'not_prime'      then square_footage end ) as np_cnt  
    , sum(   case when item_type = 'prime_eligible' then square_footage end ) as pe_sf  
    , count( case when item_type = 'prime_eligible' then square_footage end ) as pe_cnt
    
  from 
    inventory
) 
/*
The sum function gets the amount of space that one batch will take 
The count function gets the total numbers of item per batch 
*/



, t as (
  select 500000 - np_sf as space_left

  from summary
)
/*
  We need to know the available space after taking into account a batch of non-prime products.
  Then the remaining space can be prioritized for prime eligible products
  t is a short arbitrary name
  */


select 
    'prime_eligible' as item_type
  , floor( 
            (
              select space_left 
              from t 
            ) /pe_sf 
          ) * pe_cnt 
          as item_count
  /* The result of space_left/pe_sf gets rounded down then multiplied by pe_cnt to know the total items 
     The division gets the amount of batches that fit in   */

from 
  summary 


union all 

select 
    'not_prime' as item_type
  , floor( ( ( (select space_left from t ) % pe_sf ) + np_sf )/np_sf ) * np_cnt as item_count
  /* The order in which operations are executed is from left to right, no need to 
     worry about so many parentheses
     The % gets the space left after prime_eligible products, + np_sf represents 
     the original place we took for one batch of not_prime products and 
     the division and multiplicacion work the same as before  */

from 
  summary;





/*
Chaotic alternative
*/



select
    item_type
  , round( (500000 -  ( select sum(square_footage) from inventory where item_type != 'prime_eligible' ))/sum(square_footage) )  
  * count(*) as item_count

from 
  inventory

where 
      1=1
  and item_type = 'prime_eligible'

group by 
    item_type


union all


select 
    item_type
  , round( ( ( (500000 - (select sum(square_footage) from inventory where item_type != 'prime_eligible')) 
    % (select sum(square_footage) from inventory 
       where item_type = 'prime_eligible'))
          + (select sum(square_footage) from inventory 
             where item_type != 'prime_eligible') )
               /sum(square_footage) ) 
* count(*) as item_count

from 
  inventory 

where 
    item_type != 'prime_eligible'

group by 
    item_type;
