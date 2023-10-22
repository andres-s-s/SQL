--MySQL  &  MS SQL SERVER
SELECT * FROM (
    SELECT DISTINCT FIRST_VALUE(U.name) 
    OVER( ORDER BY COUNT(*) DESC , U.name ASC )
    AS results
    FROM Users U 
    JOIN MovieRating M
    ON U.user_id = M.user_id 
    GROUP BY U.name , U.user_id
    /* LIMIT 1 or TOP 1 instead of DISTINCT */
) AS T
UNION ALL 
SELECT * FROM (
    SELECT DISTINCT FIRST_VALUE( M.title ) 
    OVER( ORDER BY SUM(rating)/CAST( COUNT(*) AS FLOAT ) DESC , M.title ASC ) 
    AS results
    FROM Movies M 
    JOIN MovieRating Mr
    ON M.movie_id = Mr.movie_id
    WHERE LEFT( created_at , 7 ) = '2020-02'
    GROUP BY M.title , M.movie_id
    /* LIMIT 1 or TOP 1 instead of DISTINCT */
) AS T2;



--MySQL  
SELECT * FROM (
    SELECT U.name AS results
    FROM Users U 
    JOIN MovieRating M
    ON U.user_id = M.user_id 
    GROUP BY U.name , U.user_id
    ORDER BY COUNT(*) DESC , U.name ASC
    LIMIT 1 
) AS T
UNION ALL 
SELECT * FROM (
    SELECT M.title AS results
    FROM Movies M 
    JOIN MovieRating Mr
    ON M.movie_id = Mr.movie_id
    WHERE LEFT( created_at , 7 ) = '2020-02'
--  WHERE DATE_FORMAT(created_at , '%Y-%m') = 
--  DATE_FORMAT( STR_TO_DATE( '2020-02' , '%Y-%m') ,'%Y-%m')
    GROUP BY M.title , M.movie_id
    ORDER BY AVG(rating) DESC , M.title ASC
    LIMIT 1 
) AS T2;



--MS SQL SERVER
SELECT * FROM (
    SELECT TOP 1 U.name AS results
    FROM Users U 
    JOIN MovieRating M
    ON U.user_id = M.user_id 
    GROUP BY U.name , U.user_id
    ORDER BY COUNT(*) DESC , U.name ASC

) AS T
UNION ALL 
SELECT * FROM (
    SELECT TOP 1 M.title AS results
    FROM Movies M 
    JOIN MovieRating Mr
    ON M.movie_id = Mr.movie_id
    WHERE LEFT( created_at , 7 ) = '2020-02'
--  WHERE CONCAT( YEAR(  created_at  ), MONTH(   created_at  )) = '20202'
    GROUP BY M.title , M.movie_id
    ORDER BY AVG( CAST( rating AS FLOAT ) ) DESC , M.title ASC
) AS T2;
