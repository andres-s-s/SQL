--MySQL  &  MS SQL Server
SELECT 
    H.hacker_id 
  , name 

FROM 
    HACKERS AS H 
  
    JOIN SUBMISSIONS AS S 
    ON H.hacker_id = S.hacker_id

    JOIN CHALLENGES AS C 
    ON S.challenge_id = C.challenge_id 

    JOIN DIFFICULTY AS D 
    ON C.difficulty_level = D.difficulty_level

WHERE 
    D.score = S.score /*we can replace this where with AND*/

GROUP BY H.hacker_id , name 
HAVING COUNT(*) > 1

ORDER BY COUNT(*) DESC ,  H.hacker_id ;
