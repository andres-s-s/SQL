--MySQL
SELECT REPEAT( "* ", @num := @num - 1 ) FROM 
INFORMATION_SCHEMA.TABLES AS T1 , (SELECT @num := 21 ) AS T2
WHERE @num > 1;



--MS SQL Server
DECLARE @num INT;
SET @num = 21;
WHILE @num > 1
    BEGIN
    SET @num = @num - 1;
    PRINT( REPLICATE("* " , @num) )
    END
