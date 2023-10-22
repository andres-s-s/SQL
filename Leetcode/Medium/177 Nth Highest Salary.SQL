--MySQL
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
        SELECT salary 
        FROM (  SELECT salary , DENSE_RANK() OVER(ORDER BY salary DESC) AS ind
                FROM Employee 
             ) AS T 
        WHERE ind = N
  );
END



--MySQL
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  SET N = N - 1; 
  RETURN (
        SELECT DISTINCT salary FROM Employee 
        ORDER BY salary DESC LIMIT  N , 1
  );
END  



--MySQL
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
DECLARE Ind INT;
SET Ind = N-1;
  RETURN (
        SELECT DISTINCT salary FROM Employee 
        ORDER BY salary DESC LIMIT  Ind , 1
  );
END



--MS SQL SERVER
CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    RETURN (
        SELECT  salary 
        FROM (  SELECT salary , DENSE_RANK() OVER(ORDER BY salary DESC) AS ind
                FROM Employee 
             ) AS T 
        WHERE ind = @N

    );
END



--MS SQL SERVER
CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    RETURN (
          SELECT DISTINCT Salary FROM Employee ORDER BY Salary DESC
          OFFSET @N - 1 ROWS FETCH NEXT 1 ROW ONLY       
    );
END
