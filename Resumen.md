## 601. Human Traffic of Stadium  

**MySQL**,  **PostgreSQL**, **MS SQL Server**
~~~sql
with consecutive_ids as (
  select 
      s.id
    , s.visit_date
    , s.people
    , id
      -
      row_number()
        over(order by s.id)
      as grp

  from 
      Stadium s

  where
      s.people >= 100
)

, amount_of_c_ids as (
  select 
      c.id
    , c.visit_date
    , c.people
    , count(*) over(partition by c.grp)
        as cnt

  from 
      consecutive_ids c
)

select 
    a.id
  , a.visit_date
  , a.people

from 
    amount_of_c_ids a

where 
    a.cnt >=3
~~~


**MySQL**,  **PostgreSQL**, **MS SQL Server**
~~~sql
with filtered_visits as (

  select 
      s.id
    , s.visit_date
    , s.people
    , case
        when
          lag(id) over(order by id ) + 1 
          =
          id
        then
          0
        else
          1
      end
        as t_f


  from 
      Stadium s

  where
      s.people >= 100
)

, grouped_sequences as (

  select
      f.id
    , f.visit_date
    , f.people
    , sum(t_f) over(order by f.id)
        as sm

  from 
      filtered_visits f
)


, filtered_sequences as (

  select 
      id
    , visit_date
    , people
    , count(*) over(partition by sm)
        as cnt

  from 
      grouped_sequences 
)


select 
    id
  , visit_date
  , people

from 
    filtered_sequences

where
    cnt >=3
~~~


**MySQL**,  **PostgreSQL**, **MS SQL Server**
~~~sql
with greater_than_99 as (                               
  select 
      s.id
    , s.visit_date
    , s.people
  from 
      stadium s
  where 
        s.people >= 100
                        )
-- records with people larger or equeal to 100



, consecutive_ids_t_or_f as (
  select 
      g.id 
    , g.visit_date 
    , g.people 
    , case 
        when 
              lead(g.id)   over(order by g.id ) - 1 = g.id 
          and lead(g.id,2) over(order by g.id ) - 2 = g.id
          -- Are the current and 2 following ids consecutive?
           
           or lead(g.id)   over(order by g.id ) - 1 = g.id 
          and lag(g.id)    over(order by g.id ) + 1 = g.id
          -- Are the current and the following and the previous ids consecutive?
           
           or lag(g.id)    over(order by g.id ) + 1 = g.id 
          and lag(g.id,2)  over(order by g.id ) + 2 = g.id
          -- Are the current and the 2 previous ids consecutive?
        
        then 1 
        else null 

      end as tf 
    
  from 
      greater_than_99 g       )
/* 
  If that id does not have 2 previous consecutive ids 
  or 2 following consecutive ids 
  or 1 following and 1 following consecutive ids
  it gets a null value in the column created by the case statement 
 */



select 
    c.id 
  , c.visit_date 
  , c.people 

from 
    consecutive_ids_t_or_f c 

where 
      1=1
  and c.tf is not null -- The rows that don't meet the requirements get a null value
  

order by 
    id asc;
~~~


## 262 Trips and Users

**PostgreSQL**

~~~sql
select 
    distinct
    t.request_at
      as "Day"
  , round(
        count(*) filter(where t.status like 'cancelled%')
            over(partition by t.request_at)::decimal
        /
        count(*) 
            over(partition by t.request_at)::decimal
      , 2)
      as "Cancellation Rate"

from 
    Trips t

    left join Users u
       on u.users_id = t.client_id
    
    left join Users s
       on s.users_id = t.driver_id

where 
        1=1
    and u.banned = 'No'
    and s.banned = 'No'
    and request_at in (   '2013-10-01' 
                        , '2013-10-02' 
                        , '2013-10-03' )

~~~

**MySQL**

~~~sql
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
~~~

~~~sql
~~~

## 185 Department Top Three Salaries

**MySQL**,  **PostgreSQL**, **MS SQL Server**  


~~~sql
select 
    d.name as department -- department name
  , e.name as employee   -- employee   name
  , e.salary 

from 
    employee e

    join department d
       on e.departmentid = d.id

where 3 > (
            select 
                count(distinct m.salary) 
            
            from 
                employee m
            
            where 
                  d.id = m.departmentid 
              and m.salary > e.salary 
         );
/*
  Example:


  employee e:                              
  | department | employee | salary |       
  | ---------- | -------- | ------ |
  | IT         | Joe      | 85000  |        
  | IT         | Max      | 90000  |
  | IT         | Randy    | 85000  |
  | IT         | Will     | 70000  |  Record being processed in the first select

  Now in the subquery thanks to the where clause, employees from the same department get
  selected and the second filter, unique salaries above 70000 get counted (85000, 90000) 
  and since in this case 3 > 2 is true, this record gets selected

  If there were three unique salarys bigger than that one
  this salary would be in the top four and since 3 (number used to filter) > 3 (amount of salaries
  bigger than that one) is not true
  this would not be selected
  */
~~~

## 15 Days of Learning SQL

**MySQL**

~~~sql
-- Hacker rank
select 
    r.submission_date
  , r.cnt
  , r.h_id
  , (select h.name from Hackers h where h.hacker_id = r.h_id )

from (

    select 
        d.submission_date
      , d.cnt
      , (
            select 
                s.hacker_id
            from 
                Submissions s
            where 
                s.submission_date = d.submission_date
            group by 
                s.hacker_id
            order by 
                count(*) desc
              , s.hacker_id asc
            limit 1  
        )
          as h_id
    from 
            (
            select 
                s.submission_date
              , count(distinct s.hacker_id)
                  as cnt

            from 
                Submissions s

            where 
                ( -- section t
                    select 
                        count(distinct sub.submission_date)
                    from 
                        Submissions sub
                    where 
                        sub.submission_date < s.submission_date
                ) -- section t end
                 =
                 (
                    select 
                        count(distinct sub.submission_date)
                    from 
                        Submissions sub
                    where
                          1=1
                      and sub.submission_date < s.submission_date
                      and sub.hacker_id = s.hacker_id
                 )

            group by 
                s.submission_date
            ) as d -- dates
) as r -- result, almost

order by 
    r.submission_date asc
/*
  You can replace limit 1 with 
      top 1 for ms sql
  for ms sql server
*/



/*
  You can replace section t with 
  
      datediff( s.submission_date , '2016-03-01' ) 
  
  
  You can use a variable instead of writing '2016-03-01' in the datediff function
  
  For mysql
  
      set @date = (   
        select 
            min(s.submission_date) 
        from 
            submissions s
                  );
  
  
  For ms sql server
  
      declare @date date;
  
      set @date = 
      (   select 
              min(submission_date) 
          from submissions 
      );
  
*/
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~

## 

~~~sql
~~~