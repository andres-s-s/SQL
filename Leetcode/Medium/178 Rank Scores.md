### ➡️ Solution 1  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
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
~~~



### ➡️ Solution 2  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql
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
~~~


# 📖 Extra solutions 📖  

### ➡️ Solution 3  

~~~sql
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
~~~