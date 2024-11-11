--MySQL  &  MS SQL Server 
SELECT 
    hacker_id 
  , name 
  , SUM(m) 

FROM 
    (SELECT H.hacker_id , name , MAX(score) AS m  FROM HACKERS H JOIN SUBMISSIONS S
     ON H.hacker_id = S.hacker_id GROUP BY H.hacker_id , name , S.challenge_id) AS T

GROUP BY hacker_id , name 

HAVING  SUM(m) > 0

ORDER BY SUM(m) DESC , hacker_id;
