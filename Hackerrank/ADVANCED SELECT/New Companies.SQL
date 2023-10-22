--MySQL  &  MS SQL Server
SELECT C.company_code , C.founder , 
COUNT(DISTINCT LM.lead_manager_code)  ,COUNT(DISTINCT SM.senior_manager_code)  , 
COUNT(DISTINCT M.manager_code)        ,COUNT(DISTINCT E.employee_code)
FROM COMPANY C 
JOIN LEAD_MANAGER LM ON C.company_code = LM.company_code
JOIN SENIOR_MANAGER SM ON SM.lead_manager_code = LM.lead_manager_code
JOIN MANAGER M ON M.senior_manager_code = SM.senior_manager_code
JOIN EMPLOYEE E ON E.manager_code = M.manager_code 
GROUP BY C.company_code , C.founder
ORDER BY C.company_code ASC ;



--MySQL  &  MS SQL Server
SELECT C.company_code , C.founder , 
COUNT(DISTINCT LM.lead_manager_code)  ,COUNT(DISTINCT SM.senior_manager_code)  , 
COUNT(DISTINCT M.manager_code)        ,COUNT(DISTINCT E.employee_code)
FROM COMPANY C  ,  LEAD_MANAGER LM  , 
     SENIOR_MANAGER SM  , MANAGER M  , EMPLOYEE E 
WHERE  E.manager_code = M.manager_code 
AND    M.senior_manager_code = SM.senior_manager_code 
AND    SM.lead_manager_code = LM.lead_manager_code 
AND    C.company_code = LM.company_code 
GROUP BY C.company_code , C.founder
ORDER BY C.company_code ASC ;
