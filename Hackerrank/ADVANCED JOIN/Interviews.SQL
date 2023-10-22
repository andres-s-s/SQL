--MySQL  &  MS SQL Server
SELECT C.contest_id , hacker_id , name ,
SUM(ts) , SUM(tas) , SUM(tv) , SUM(tuv)
FROM CONTESTS   C 
JOIN COLLEGES   Cl ON C.contest_id  = Cl.contest_id
JOIN CHALLENGES Ch ON Cl.college_id = Ch.college_id
LEFT JOIN (SELECT challenge_id , SUM(total_submissions) AS ts , 
          SUM(total_accepted_submissions) AS tas FROM SUBMISSION_STATS 
          GROUP BY challenge_id ) AS T1  
ON Ch.challenge_id = T1.challenge_id 
LEFT JOIN (SELECT challenge_id , SUM(total_views) AS tv , 
          SUM(total_unique_views) AS tuv FROM VIEW_STATS 
          GROUP BY challenge_id ) AS T2
ON Ch.challenge_id = T2.challenge_id 
GROUP BY C.contest_id , hacker_id , name 
HAVING SUM(ts)+SUM(tas)+SUM(tv)+SUM(tuv)>0 
ORDER BY C.contest_id;



--MySQL  &  MS SQL Server
SELECT C.contest_id , hacker_id , name ,
SUM(ts) , SUM(tas) , SUM(tv) , SUM(tuv)
FROM CONTESTS   C 
JOIN COLLEGES   Cl ON C.contest_id  = Cl.contest_id
JOIN (SELECT MAX(college_id) AS college_id , challenge_id FROM CHALLENGES
      GROUP BY challenge_id) AS Ch 
ON Cl.college_id = Ch.college_id
LEFT JOIN (SELECT challenge_id , SUM(total_submissions) AS ts , 
          SUM(total_accepted_submissions) AS tas FROM SUBMISSION_STATS 
          GROUP BY challenge_id ) AS T1  
ON Ch.challenge_id = T1.challenge_id 
LEFT JOIN (SELECT challenge_id , SUM(total_views) AS tv , 
          SUM(total_unique_views) AS tuv FROM VIEW_STATS 
          GROUP BY challenge_id ) AS T2
ON Ch.challenge_id = T2.challenge_id 
GROUP BY C.contest_id , hacker_id , name 
HAVING SUM(ts)+SUM(tas)+SUM(tv)+SUM(tuv)>0
ORDER BY C.contest_id;



--MS SQL Server
WITH SST AS (SELECT challenge_id , SUM(total_submissions) AS ts , 
           SUM(total_accepted_submissions) AS tas FROM SUBMISSION_STATS 
           GROUP BY challenge_id ),
    VST AS (SELECT challenge_id , SUM(total_views) AS tv , 
           SUM(total_unique_views) AS tuv FROM VIEW_STATS 
           GROUP BY challenge_id )
SELECT C.contest_id , hacker_id , name ,
SUM(ts) , SUM(tas) , SUM(tv) , SUM(tuv)
FROM CONTESTS   C 
JOIN COLLEGES   Cl ON C.contest_id  = Cl.contest_id
JOIN CHALLENGES Ch ON Cl.college_id = Ch.college_id
LEFT JOIN  SST ON Ch.challenge_id = SST.challenge_id 
LEFT JOIN  VST ON Ch.challenge_id = VST.challenge_id 
GROUP BY C.contest_id , hacker_id , name 
HAVING SUM(ts)+SUM(tas)+SUM(tv)+SUM(tuv)>0
ORDER BY C.contest_id;
