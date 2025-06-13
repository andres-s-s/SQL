### ➡️ Solution 1  

**MySQL**

~~~sql
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      with ranked_salaries as (
        select 
            e.salary
          , dense_rank()
              over(order by e.salary )
            as ranked  
        from 
            Employee e    
      )

    select 
        distinct 
        salary
    from 
        ranked_salaries
    where
        ranked = N
    


  );
END
~~~

**MS SQL Server**  
~~~sql
create function getnthhighestsalary(@n int) returns int as
begin
    return (
              select 
                  distinct
                  salary 
              
              from (  
                      select -- No cte allowed
                          salary 
                        , dense_rank() 
                            over(order by salary desc) 
                          as ind
                      
                      from 
                          employee 
                   ) as t 
              
              where 
                    ind = @n

    );
end
~~~

**PostgreSQL**
~~~sql
CREATE OR REPLACE FUNCTION NthHighestSalary(N INT) RETURNS TABLE (nth_salary INT) AS $$ 
-- "TABLE (Salary INT)" was change because it produced an error
BEGIN

  RETURN QUERY (
              select 
                  distinct
                  t.salary 
              
              from (  
                      select -- No cte allowed
                          salary 
                          as sl
                        , dense_rank() 
                            over(order by salary desc) 
                          as ind
                      
                      from 
                          employee 
                   ) as t 
              
              where 
                    ind = N
  );
END;
$$ LANGUAGE plpgsql;
~~~


### ➡️ Solution 2  

**MySQL**
~~~sql
create function getnthhighestsalary(n int) returns int
  begin
      set n = n - 1; -- Not possible to do limit  n - 1, 1
      -- You can do: declare seq int; set seq = n-1;
      return (
               select 
                   distinct salary 
               
               from 
                   employee 
               
               order by 
                   salary desc 
               
               limit  n , 1
  );
  end  
~~~


**PostgreSQL**
~~~sql
CREATE OR REPLACE FUNCTION NthHighestSalary(N INT) 
RETURNS TABLE (nth_salary INT) AS $$
-- "TABLE (Salary INT)" was change because it produced an error
BEGIN

  if N < 1 then
    return QUERY select null::int;
    
    return;
  end if;

  RETURN QUERY (
        select 
            distinct salary 
        
        from 
            employee 
        
        order by 
            salary desc 
        
        offset  N - 1 limit 1

      
  );
END;
$$ LANGUAGE plpgsql;
~~~



**MS SQL Server**
~~~sql
CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN

        declare @result INT;

        if @N < 1
        return null;

        with salaries as (
            select 
                distinct salary 
            from 
                employee         
        )

    select 
        @result = salary
    from 
        salaries
    order by 
        salary desc
    offset (@N - 1) rows
    fetch next 1 rows only;

    return @result;
END
~~~