--MySQL  &  MS SQL Server
SELECT S.name FROM STUDENTS S
JOIN  PACKAGES P  ON S.id = P.id 
JOIN  FRIENDS  F  ON F.id = S.id 
JOIN  PACKAGES PF ON PF.id = F.friend_id 
WHERE P.salary < PF.salary 
ORDER BY PF.salary;



--MySQL  &  MS SQL Server
SELECT S.name FROM STUDENTS S , 
PACKAGES P   , FRIENDS  F    , PACKAGES PF  
WHERE P.salary < PF.salary 
AND S.id = P.id AND F.id = S.id AND PF.id = F.friend_id 
ORDER BY PF.salary;
