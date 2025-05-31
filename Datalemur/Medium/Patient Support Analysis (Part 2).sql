select 
    round(
      count(*) 
        filter(where call_category = 'n/a' or call_category is NULL)
      /
      count(*)::decimal  * 100
      , 1)

from 
    callers;






/*count(call_category)  -- This excludes NULLs!
  therefore you can not use it in none of the counts functions
  because you get an error in the calculation and that is for sure
*/