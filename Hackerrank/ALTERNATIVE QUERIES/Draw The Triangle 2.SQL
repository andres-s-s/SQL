--MySQL
SELECT REPEAT( "* ", @num := @num + 1 ) FROM 
INFORMATION_SCHEMA.TABLES AS T1 , (SELECT @num := 0 ) AS T2
WHERE @num < 20;



--MS SQL Server
DECLARE @num INT;
SET @num = 0;
WHILE @num < 20
    BEGIN
    SET @num = @num + 1;
    PRINT( REPLICATE("* " , @num) )
    END
