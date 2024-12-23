--mysql  &  ms sql server
select 
    score 
  , dense_rank() 
      over(
        order by 
            score desc 
          ) 
      as "rank"

from 
    scores 

order by 
    score desc ;



--mysql  &  ms sql server
select 
    s.score 
  , count(*) as "rank"

from 
    scores as s 

    join ( 
          select 
              distinct score 
          
          from 
              scores 
         ) as s2
       on s.score <= s2.score 

group by 
    s.id 
  , s.score 

order by 
    s.score desc ;




--mysql  &  ms sql server
select 
    score 
  , sum(rnk) 
      over(
        order by 
            score desc
          ) 
      as "rank" 

from (
        select 
            score 
          , case 
            
                when lag(score) 
                       over(
                         order by 
                             score desc
                           ) = score 
                
                then 0 
              
                else + 1 
              
              end as "rnk" 
        
      from 
        scores
     ) as t ;



--mysql
select 
    score 
  , convert(rnk , signed) as "rank" 

from (
        select 
            score 
          , @rank := 
                    case 
                        when score = @p 
                        then @rank 
                        
                        else @rank + 1 
              end as "rnk" 
          , @p := score
        
        from 
            scores 
          , (select @p:=-1 , @rank:=0 ) as t
    
        order by 
            score desc
) t2;
