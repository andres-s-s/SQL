--MySQL  &  MS SQL SERVER
WITH CTE AS (SELECT DISTINCT p_id FROM Tree)

SELECT id , 
CASE WHEN p_id IS  NULL THEN 'Root' 
     WHEN   id IN (SELECT p_id FROM CTE ) THEN 'Inner'  
     ELSE 'Leaf'
END AS 'type'
FROM Tree ; 



--MySQL  &  MS SQL SERVER
WITH CTE AS (SELECT DISTINCT p_id FROM Tree)

SELECT id , 
CASE WHEN T.p_id IS  NULL THEN 'Root' 
     WHEN C.p_id IS  NULL THEN 'Leaf'  
     ELSE 'Inner'
END AS 'type'
FROM Tree T LEFT JOIN CTE C ON T.id = C.p_id ; 



--MySQL
WITH CTE AS (SELECT DISTINCT p_id FROM Tree)

SELECT id , 
IF(p_id IS NULL , "Root" , 
    IF(id IN (SELECT p_id FROM CTE ) , "Inner" , "Leaf") 
) AS type
FROM Tree ; 
