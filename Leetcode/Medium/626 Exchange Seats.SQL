--MySQL  &  MS SQL SERVER
SELECT 
CASE WHEN  LEAD(id) OVER(ORDER BY id ) IS NULL AND id % 2 != 0
     THEN  id ELSE 
     CASE  WHEN id % 2 = 0 THEN id - 1 ELSE id + 1 END 
END AS id , student 
FROM Seat 
ORDER BY id ASC;



--MySQL  &  MS SQL SERVER
SELECT id , 
COALESCE( 
    CASE WHEN id % 2 != 0 THEN LEAD(student) OVER(ORDER BY id ASC ) 
    ELSE LAG(student) OVER(ORDER BY id ASC ) END , 
    student
) AS student 
FROM Seat ; 



--MySQL  &  MS SQL SERVER
SELECT ROW_NUMBER() OVER(ORDER BY id ASC ) AS id , student FROM (
    SELECT student , 
        CASE WHEN id % 2 = 0 THEN id - 1 ELSE id + 1 END AS id 
    FROM Seat
) AS T ;



--MySQL  &  MS SQL SERVER
SELECT ROW_NUMBER() 
       OVER(ORDER BY (CASE WHEN id % 2 = 0 THEN id - 1 ELSE id + 1 END ) ASC ) AS id
 , student FROM Seat;



--MySQL  &  MS SQL SERVER
WITH CTE AS ( 
  SELECT    id , student    FROM Seat    WHERE id % 2 != 0 AND id = (SELECT COUNT(*) FROM Seat )
  UNION ALL 
  SELECT S1.id , S2.student FROM Seat S1 JOIN Seat S2 ON S1.id - 1 = S2.id WHERE S1.id % 2  = 0 
  UNION ALL 
  SELECT S1.id , S2.student FROM Seat S1 JOIN Seat S2 ON S1.id + 1 = S2.id WHERE S1.id % 2 != 0 
)
SELECT * FROM CTE ORDER BY id ASC ; 



--MySQL  
SELECT 
IF(  LEAD(id) OVER(ORDER BY id ) IS NULL AND id % 2 != 0 , id  ,
     IF( id % 2 = 0 , id - 1 , id + 1 ) 
) AS id , student 
FROM Seat 
ORDER BY id ASC;
