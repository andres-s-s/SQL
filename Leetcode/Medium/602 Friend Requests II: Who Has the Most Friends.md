### ➡️ Solution 1  

**MySQL**,  **PostgreSQL**

~~~sql
select 
    id 
  , count(*) as num

from (
        select 
            accepter_id  as id 
        
        from 
            requestaccepted
        
        union all
    
        select 
            requester_id as id 
        
        from 
            requestaccepted
     ) as t 

group by 
    id 

order by 
    count(*) desc 

limit 1 ;
~~~



~~~sql
---ms sql server
select 
    top 1 id 
  , count(*) as num

from (
        select 
            accepter_id  as id 
        
        from 
            requestaccepted
        
        union all
        
        select 
            requester_id as id 
        
        from 
            requestaccepted
) as t 

group by 
    id 

order by 
    count(*) desc;
~~~


### ➡️ Solution 2  

**MySQL**,  **PostgreSQL**, **MS SQL Server**  
This solution works in the case that some people have the same most number of friends.
The others work under the assumption there is no such case.
~~~sql
with ids as (

    select 
        r.requester_id
          as id
    from 
        RequestAccepted r
    
    union all

    select 
        r.accepter_id 
          as id 
    from 
        RequestAccepted r
)

, how_many_friends as (

    select 
        i.id
      , count(*)
          as num
    from 
        ids i
    group by 
        i.id
)



select 
    f.id
  , f.num

from 
    how_many_friends f

where num = (
                select max(num)
                from how_many_friends

)
~~~