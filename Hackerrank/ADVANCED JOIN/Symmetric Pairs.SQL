--MySQL  &  MS SQL Server
SELECT 
    F.x 
  , F.y 

FROM 
  FUNCTIONS F 

    JOIN FUNCTIONS Fl
      ON  F.x = Fl.y 
      AND F.y = Fl.x 
      AND F.x < F.y

UNION 

SELECT 
    x 
  , y 

FROM 
  FUNCTIONS F 

GROUP BY 
    x 
  , y 

HAVING COUNT(*) > 1 

ORDER BY x;



--MySQL  &  MS SQL Server
SELECT 
    F.x 
  , F.y 

FROM 
  FUNCTIONS F 

WHERE EXISTS(
                SELECT * 
                
                FROM  FUNCTIONS Fl 
                
                WHERE 
                      1=1
                  and F.x = Fl.y 
                  AND F.y = Fl.x 
                  AND F.x < F.y 
                
                GROUP BY 
                    Fl.x 
                  , Fl.y  
            )
OR    EXISTS(
                SELECT * 
                
                FROM  FUNCTIONS Fl 
                
                WHERE
                      1=1
                  and F.x = Fl.x 
                  AND Fl.y = F.y 
                
                GROUP BY 
                    x 
                  , y 
                
                HAVING COUNT(*)> 1  )

GROUP BY 
    x 
  , y

ORDER BY 
    x; 



--MySQL  &  MS SQL Server
SELECT 
    F.x 
  , F.y 

FROM 
  FUNCTIONS F 

WHERE EXISTS(SELECT * FROM  FUNCTIONS Fl 
             WHERE F.x = Fl.y AND F.y = Fl.x  
             GROUP BY Fl.x , Fl.y
             HAVING COUNT(*) > 1 OR  F.x < F.y )

GROUP BY 
    x 
  , y

ORDER BY x; 
