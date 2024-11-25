/*
Instructions:
Write a query to report the median of searches made by a user. Round the median to one decimal point.

search_frequency table example :
searches	num_users
  1	          2
  2	          2
  3	          3
  4	          1

NOW I realize the only reason this solution worked It is because the number of searches
in the data is always one digit long
But It's still interesting
*/


--This was my solution before learning about the percentile_cont function
with 
  list_of_searches as (
    select 
        repeat( 
            cast( searches as varchar ) 
          , num_users 
          ) 
        as number_of_searches
  
  from 
    search_frequency
  
  order by  
      searches asc
)
/*
This  will  turn   into    this
searches	num_users   |    number_of_searches
  4           2       |        4,4
*/


, string_of_searches as (
  select 
      string_agg(
          number_of_searches 
        , ''
                ) 
      as only_row

  from 
    list_of_searches
)
/*
This will outpout only one row turning the list we had before into one single string
*/


select 
    round(
      case 
        when length(only_row) % 2 != 0 --If the amount of elements is odd
          then  cast(  
                  substring( 
                      only_row  -- What string
                    , cast(     -- The start position. The first position in string is 1
                        ceil( 
                            length(only_row)/2 
                            ) 
                        as int ) 
                    , 1         -- The number of characters to extract 
                           ) 
                  as int )
          else (                      --If the amount of elements is even
            cast( 
              substring( 
                only_row  
              , length(only_row)/2 
              , 1 ) 
            as int ) 
            + 
            cast( 
              substring( 
                only_row  
              , length(only_row)/2 + 1 
              , 1 ) 
            as int ) 
        )
        /2.0
      end 
    , 1 ) as median 

from
  string_of_searches



/*
Alternative
*/

with 
    searches_expanded_as_list as (
    select 
        searches
      , num_users
      , generate_series(1 , num_users , 1) as gs
    --  generate_series( start , stop , step  )

    from
      search_frequency
)


select 
    round(
      percentile_cont(0.50) within group ( order by searches)::decimal 
    , 1 ) as median
  
from 
  searches_expanded_as_list;


/*
In the CTE a table like this would
searches	num_users
  1	          2
  2	          2
  3	          3
  4	          1

turn into this
searches  gs
  1       1
  1       2
  2       1
  2       2
  3       1
  3       2
  3       3
  4       1


Alternative CTE
  select 
      searches
  
  from 
    search_frequency
  
  group by  
      searches 
    , generate_series(1, num_users)
*/