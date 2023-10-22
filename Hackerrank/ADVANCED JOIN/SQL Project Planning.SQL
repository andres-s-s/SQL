--MySQL 
SELECT start_date , 
    (SELECT end_date FROM PROJECTS 
     WHERE end_date NOT IN (SELECT start_date FROM PROJECTS)  
     AND end_date > T.start_date 
     ORDER BY end_date LIMIT 1 ) AS end_date
FROM 
    (SELECT start_date FROM PROJECTS 
     WHERE start_date NOT IN (SELECT end_date FROM PROJECTS )  ) AS T
ORDER BY end_date - start_date , start_date;



--MySQL
SELECT start_date , 
    (SELECT MIN(end_date) FROM PROJECTS 
     WHERE end_date NOT IN (SELECT start_date FROM PROJECTS)  
     AND end_date > T.start_date 
    ) AS end_date
FROM 
    (SELECT start_date FROM PROJECTS 
     WHERE start_date NOT IN (SELECT end_date FROM PROJECTS )  ) AS T
ORDER BY end_date - start_date , start_date;



--MySQL
SELECT start_date , end_date FROM
    (SELECT start_date , ROW_NUMBER() OVER(ORDER BY start_date ) AS ind 
     FROM PROJECTS WHERE start_date NOT IN (SELECT end_date FROM PROJECTS )  
    ) AS T1
JOIN 
    (SELECT end_date   , ROW_NUMBER() OVER(ORDER BY end_date )   AS ind 
     FROM PROJECTS WHERE end_date NOT IN (SELECT start_date FROM PROJECTS)   
    ) AS T2
ON T1.ind = T2.ind 
ORDER BY DATEDIFF(  end_date , start_date ), start_date;



--MySQL
SELECT T1.start_date , T2.end_date FROM
    (SELECT start_date , @num := @num + 1 AS ind 
     FROM PROJECTS , (SELECT @num := 0) AS Nt
     WHERE start_date NOT IN (SELECT end_date FROM PROJECTS ) 
     ORDER BY start_date
    ) AS T1
JOIN 
    (SELECT end_date  , @numb := @numb + 1 AS ind  
     FROM PROJECTS , (SELECT @numb := 0) AS Nt 
     WHERE end_date NOT IN (SELECT start_date FROM PROJECTS)   
     ORDER BY end_date
    ) AS T2
ON T1.ind = T2.ind 
ORDER BY DATEDIFF(  end_date , start_date ), start_date;



--MySQL
SELECT MIN(start_date) , MAX(end_date) FROM (
    SELECT start_date , end_date , SUM(tf) OVER(ORDER BY start_date) AS p
    FROM (
        SELECT start_date , end_date ,  
            CASE WHEN LAG(end_date) OVER(ORDER BY start_date) = start_date
            THEN 0 ELSE 1 END AS tf
        FROM PROJECTS
         ) T
                ) AS T2
GROUP BY p
ORDER BY DATEDIFF( MAX(end_date) , MIN(start_date)), MIN(start_date);



--MySQL
SELECT MIN(start_date) , MAX(end_date) FROM (
    SELECT start_date , end_date , SUM(tf) OVER(ORDER BY start_date) AS p
    FROM (
        SELECT start_date , end_date ,  
        IF( LAG(end_date) OVER(ORDER BY start_date) = start_date ,  0 , 1 )  AS tf
        FROM PROJECTS
         ) T
                ) AS T2
GROUP BY p
ORDER BY DATEDIFF( MAX(end_date) , MIN(start_date)), MIN(start_date);



--MS SQL Server
SELECT start_date , end_date FROM (
    SELECT start_date , 
       (SELECT TOP 1 end_date FROM PROJECTS 
        WHERE end_date NOT IN (SELECT start_date FROM PROJECTS)  
        AND end_date > T.start_date 
        ORDER BY end_date ) AS end_date
    FROM 
       (SELECT start_date FROM PROJECTS 
        WHERE start_date NOT IN (SELECT end_date FROM PROJECTS )  ) AS T  ) T1
ORDER BY DATEDIFF(dd, start_date, end_date), start_date;



--MS SQL Server
SELECT start_date , end_date FROM
    (SELECT start_date , ROW_NUMBER() OVER(ORDER BY start_date ) AS ind 
     FROM PROJECTS WHERE start_date NOT IN (SELECT end_date FROM PROJECTS )  
    ) AS T1
JOIN 
    (SELECT end_date   , ROW_NUMBER() OVER(ORDER BY end_date )   AS ind 
     FROM PROJECTS WHERE end_date NOT IN (SELECT start_date FROM PROJECTS)   
    ) AS T2
ON T1.ind = T2.ind 
ORDER BY DATEDIFF(dd, start_date, end_date), start_date;



--MS SQL Server
SELECT MIN(start_date) , MAX(end_date) FROM (
    SELECT start_date , end_date , SUM(tf) OVER(ORDER BY start_date) AS p
    FROM (
        SELECT start_date , end_date ,  
            CASE WHEN LAG(end_date) OVER(ORDER BY start_date) = start_date
            THEN 0 ELSE 1 END AS tf
        FROM PROJECTS
         ) T
                ) AS T2
GROUP BY p
ORDER BY DATEDIFF( dd, MIN(start_date) , MAX(end_date) ), MIN(start_date);
