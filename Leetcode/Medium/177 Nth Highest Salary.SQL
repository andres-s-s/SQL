--mysql
create function getnthhighestsalary(n int) returns int
  begin
      return (
               select 
                   salary 
               
               from (  
                       select 
                            salary 
                          , dense_rank() 
                              over(
                                order by 
                                    salary desc
                                  ) 
                              as ind
                       
                       from 
                           employee 
                    ) as t 
               where ind = n
  );
  end




--mysql
create function getnthhighestsalary(n int) returns int
  begin
      set n = n - 1; 
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



--mysql
create function getnthhighestsalary(n int) returns int
  begin
      declare ind int;
      set ind = n-1;
      return (
                select 
                    distinct salary 
                
                from 
                    employee 
                
                order by 
                    salary desc 
                
                limit 
                    ind 
                   , 1
  );
  end




--ms sql server
create function getnthhighestsalary(@n int) returns int as
begin
    return (
              select 
                  salary 
              
              from (  
                      select 
                          salary 
                        , dense_rank() 
                            over(
                              order by 
                                  salary desc
                                ) 
                            as ind
                      
                      from 
                          employee 
                   ) as t 
              
              where 
                    ind = @n

    );
end




--ms sql server
create function getnthhighestsalary(@n int) returns int as
begin
    return (
              select 
                  distinct salary 
              
              from 
                  employee 
              
              order by 
                  salary desc
              
              offset @n - 1 rows 
              fetch next 1 row only       
    );
end
