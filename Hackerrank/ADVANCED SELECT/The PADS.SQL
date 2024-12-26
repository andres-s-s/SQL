/* mysql  &  ms sql server */
select 
    concat( 
            o.name 
          , "("
          , upper( 
                left( o.occupation , 1 ) 
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
          , lower(o.occupation) 
          , "s." 
          )

from 
    occupations o

group by 
    o.occupation

order by 
    count(*) asc 
  , o.occupation;




/* mysql  &  ms sql server */
select 
    concat( 
            o.name 
          , "("
          , upper( 
                substring( o.occupation, 1, 1) 
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
          , lower(o.occupation) 
          , "s." 
          )

from 
    occupations o

group by 
    o.occupation

order by 
    count(*) asc 
  , o.occupation;



/* mysql */
select 
    concat( 
              o.name 
            , "("
            , upper( 
                  substr( o.occupation, 1, 1) 
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
            , lower(o.occupation) 
            , "s." 
          )

from 
    occupations o

group by 
    o.occupation

order by 
    count(*) asc 
  , o.occupation;
