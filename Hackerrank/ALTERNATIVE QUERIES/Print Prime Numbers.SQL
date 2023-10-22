--MySQL
SELECT GROUP_CONCAT(num SEPARATOR "&" ) FROM (
SELECT (@num := @num + 1 ) AS num 
FROM INFORMATION_SCHEMA.TABLES T1 , INFORMATION_SCHEMA.TABLES T2 , (SELECT @num := 1 ) AS T3 
WHERE @num <= 1000     )  T 
WHERE NOT EXISTS( SELECT * FROM (SELECT (@nd := @nd + 1 ) AS nd  FROM INFORMATION_SCHEMA.TABLES T1 , 
                                 INFORMATION_SCHEMA.TABLES T2, (SELECT @nd := 1 ) AS T3 WHERE @nd < 1001 ) T4
                  WHERE  num % nd = 0 AND nd < num );



--MS SQL Server
CREATE TABLE prime_num(num INT);
DECLARE @num INT, @div INT, @tf INT;
SET @num = 1;
WHILE @num < 1001
    BEGIN
    SELECT @num = @num + 1 , @div = @num/2 , @tf = 1;
    WHILE @div > 1
        BEGIN
        IF @num % @div = 0
            SELECT @tf = 0 , @div = 1;
        SET @div = @div - 1;
        END
        IF @tf = 1 
            INSERT INTO prime_num(num) VALUES(@num) ; 
    END
SELECT STRING_AGG(num , "&") FROM prime_num;



--MS SQL Server
DECLARE @num INT, @div INT, @tf INT , @prime_numbers VARCHAR(650);
SELECT @num = 1, @prime_numbers = '';
WHILE @num < 1001
    BEGIN
    SELECT @num = @num + 1 , @div = @num/2 , @tf = 1;
    WHILE @div > 1
        BEGIN
        IF @num % @div = 0
            SELECT @tf = 0 , @div = 1;
        SET @div = @div - 1;
        END
        IF @tf = 1 
            SET @prime_numbers = @prime_numbers + CAST(@num AS VARCHAR(4)) + "&" ; 
    END
SET @prime_numbers = SUBSTRING(@prime_numbers , 1 , LEN(@prime_numbers) - 1 );
PRINT @prime_numbers;
