--MySQL  &  MS SQL SERVER
SELECT  E.name FROM Employee E JOIN Employee E2
ON E.id = E2.managerId 
GROUP BY E.name , E.id
HAVING COUNT(*) >= 5;



--MySQL  &  MS SQL SERVER
SELECT name FROM Employee 
WHERE id IN (SELECT managerId FROM Employee GROUP BY managerId 
             HAVING COUNT(*) >= 5  );
