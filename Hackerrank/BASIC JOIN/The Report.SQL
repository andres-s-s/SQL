--MySQL  &  MS SQL Server
SELECT CASE WHEN grade > 7 THEN name END , grade , marks 
FROM STUDENTS JOIN GRADES ON marks BETWEEN min_mark AND max_mark ORDER BY grade DESC , name ;



--MySQL  &  MS SQL Server
SELECT 
    (SELECT name 
      FROM STUDENTS 
      WHERE marks >= 70 AND St.name = name) 
  , grade 
  , marks 

FROM STUDENTS St 
    JOIN GRADES ON marks BETWEEN min_mark AND max_mark 

ORDER BY grade DESC , name ;



--MySQL
SELECT IF(grade >=8 , name , NULL ), grade , marks 
FROM STUDENTS JOIN GRADES ON marks BETWEEN min_mark AND max_mark ORDER BY grade DESC , name ;
