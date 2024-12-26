/*
    Generate the following two result sets:

    1:Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by 
    the first letter of each profession as a parenthetical 

    2:Query the number of ocurrences of each occupation in OCCUPATIONS. 
    Sort the occurrences in ascending order, and output them in the following format

    The OCCUPATIONS table is described as follows:
    Name            string
    Occupation      string
  */





-- +--------------------------------------------------------------------+
-- |  solution 1: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


select 
    concat( 
              o.name 
            , "("
            , upper( 
                  left( o.occupation , 1 ) -- First letter of that profession
                   ) 
            , ")" 
          ) 

from 
    occupations o

order by 
    o.name;


select 
    concat(
              "There are a total of " 
            , count(*) -- ocurrences of each occupation
            , " " 
            , lower(o.occupation) -- getting rid of capital letters
            , "s." -- adding an "s" to make it plural
          )

from 
    occupations o

group by 
    o.occupation

order by 
    count(*) asc 
  , o.occupation;




-- +--------------------------------------------------------------------+
-- |  solution 2: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


select 
    concat( 
              o.name 
            , "("
            , upper( 
                  substring( o.occupation, 1, 1) -- First letter of that profession
                 ) 
            , ")" 
          ) 

from 
    occupations o

order by 
    o.name;


select 
    concat(
              "There are a total of " 
            , count(*) -- ocurrences of each occupation
            , " " 
            , lower(o.occupation) -- getting rid of capital letters
            , "s." -- adding an "s" to make it plural
          )

from 
    occupations o

group by 
    o.occupation

order by 
    count(*) asc 
  , o.occupation;





-- +--------------------------------------------------------------------+
-- |  solution 3: mysql   
-- +--------------------------------------------------------------------+


select 
    concat( 
              o.name 
            , "("
            , upper( 
                  substr( o.occupation, 1, 1) -- First letter of that profession
                   ) 
            , ")" 
          ) 

from 
    occupations o

order by 
    o.name;


select 
    concat(
              "There are a total of " 
            , count(*) 
            , " " 
            , lower(o.occupation) -- getting rid of capital letters
            , "s." -- adding an "s" to make it plural
          )

from 
    occupations o

group by 
    o.occupation

order by 
    count(*) asc 
  , o.occupation;
