/*
  262. Trips and Users

  The cancellation rate is computed by dividing the number of canceled (by client or driver) 
  requests with unbanned users by the total number of requests with unbanned users on that day.

  Write a solution to find the cancellation rate of requests with unbanned users (both client 
  and driver must not be banned) each day between "2013-10-01" and "2013-10-03". 
  Round Cancellation Rate to two decimal points.

  Return the result table in any order.
  
  Table: Trips
  +-------------+----------+
  | Column Name | Type     |
  +-------------+----------+
  | id          | int      |
  | client_id   | int      |
  | driver_id   | int      |
  | city_id     | int      |
  | status      | enum     |
  | request_at  | varchar  |     
  +-------------+----------+


  Table: Users
  +-------------+----------+
  | Column Name | Type     |
  +-------------+----------+
  | users_id    | int      |
  | banned      | enum     |
  | role        | enum     |
  +-------------+----------+
  */


-- +--------------------------------------------------------------------+
-- |  solution 1: mysql   
-- +--------------------------------------------------------------------+


with banned as ( 
  select 
    u.users_id 
      as id 
  
  from 
      users u
  
  where 
        u.banned = 'Yes' 
            )
-- banned users, drivers and clients



select 
    t.request_at as Day 
  , round(
        avg( 
            case 
              when t.status != 'completed' 
              then 1 
              else 0 
            end 
           )
      , 2  
         ) 
      as "Cancellation rate"
      /*
        When it gets a cancelled request it adds a 1
        When it does not get a cancelled it adds a 0
        Then taking the average out of these numbers gets us the "Cancellation rate"

        Remember there is group by clause
        */

from 
    trips t

where 
      1=1
  and t.client_id not in (select id from banned) -- makes sure the client is not banned
  and t.driver_id not in (select id from banned) -- makes sure the driver is not banned
  and str_to_date( t.request_at  , '%Y-%m-%d') -- Requested dates
         between str_to_date( '2013-10-01', '%Y-%m-%d') 
         and     str_to_date( '2013-10-03', '%Y-%m-%d')

group by 
    t.request_at; -- There are many records that share the same date so it's vital to group them




-- +--------------------------------------------------------------------+
-- |  solution 2: mysql   
-- +--------------------------------------------------------------------+


with not_banned as ( 
    select 
        u.users_id 
          as id 
    
    from 
        users u
    
    where 
          banned = 'No' 
            )



select 
    t.request_at as day 
  , round(
        avg(
            case 
          
              when t.status != 'completed' 
              then 1 
              else 0 
              
              end )
      , 2) 
      as "cancellation rate"
      /*
        When it gets a cancelled request it adds a 1
        When it does not get a cancelled request it adds a 0
        Then taking the average out of these numbers gets us the "Cancellation rate"

        Remember there is group by clause
        */

from 
    trips t

    join not_banned n
       on t.client_id = n.id

    join not_banned n2
       on t.driver_id = n2.id
    /*
      The inner joins leave out the banned users since in the not_banned table 
      there are not banned users, remember there different types of joins and these 
      are not a full out joins
      */

where 
      1=1
  and str_to_date( t.request_at  ,'%Y-%m-%d') -- Requested dates
          between str_to_date( '2013-10-01', '%Y-%m-%d')
              and str_to_date( '2013-10-03', '%Y-%m-%d')

group by 
    t.request_at; -- There are many records that share the same date so it's vital to group them




-- +--------------------------------------------------------------------+
-- |  solution 3: ms sql server   
-- +--------------------------------------------------------------------+
-- like the 1 but adapted to ms sql server

with cte as ( 
  select 
      users_id as id 
   
  from 
      users 
  
  where 
        banned = 'Yes' 
            )
-- close cte


select 
    request_at as day 
  , round(
          avg( 
            case 
            
              when status != 'completed' 
              then 1.0 
              else 0.0 
            
            end )
        , 2 ) 
      as "Cancellation rate"

from 
    trips  

where 
      1=1
  and client_id not in (select id from cte)
  and driver_id not in (select id from cte) 
  and cast( request_at  as date )
            between cast(  '2013-10-01'  as date)
                and cast(  '2013-10-03'  as date)

group by 
    request_at;




-- +--------------------------------------------------------------------+
-- |  solution 4: ms sql server   
-- +--------------------------------------------------------------------+

/* like the 3 but adapted to ms sql server */


with cte as ( 
  select 
      users_id as id 
  
  from 
      users 
      
  where 
        banned = 'No' 
            )
-- close cte

select 
    request_at as day 
  , round(
            avg( 
                case 
                
                  when status != 'completed' 
                  then 1.0 
                
                  else 0.0 
                
                end 
               )
          , 2 
         ) 
      as "Cancellation Rate"

from 
    trips t

    join cte c
       on t.client_id = c.id
    
    join cte c2
       on t.driver_id = c2.id

where 
      1=1
  and cast(    request_at  as date )
          between cast(  '2013-10-01'  as date)
              and cast(  '2013-10-03'  as date)

group by 
    request_at;