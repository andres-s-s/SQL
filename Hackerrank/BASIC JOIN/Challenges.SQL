--MySQL  &  MS SQL Server 
WITH TL AS (SELECT H.hacker_id , name , COUNT(*) AS c ,
                     ROW_NUMBER() OVER(PARTITION BY COUNT(*) ORDER BY H.hacker_id) AS counter
                     FROM HACKERS AS H JOIN CHALLENGES AS C 
                     ON H.hacker_id = C.hacker_id GROUP BY  H.hacker_id , name )
                     
SELECT hacker_id , name , c FROM TL 
WHERE c  = (SELECT MAX(c) FROM TL ) 
OR  c NOT IN(SELECT c FROM TL WHERE counter = 2)
ORDER BY c DESC , hacker_id;



--MySQL  &  MS SQL Server 
SELECT H.hacker_id , name , COUNT(*) 
FROM HACKERS AS H JOIN CHALLENGES AS C ON H.hacker_id = C.hacker_id
GROUP BY  H.hacker_id , name 
HAVING  COUNT(*) = (SELECT MAX(co) FROM (SELECT COUNT(*) AS co FROM CHALLENGES GROUP BY hacker_id) AS T )
OR  COUNT(*) IN    (SELECT coun FROM (SELECT COUNT(*) AS coun FROM CHALLENGES GROUP BY hacker_id) AS T
                    GROUP BY coun HAVING COUNT(*) = 1)
ORDER BY COUNT(*) DESC ,  H.hacker_id;



--MS SQL Server
SELECT hacker_id , name , cnt FROM (
    SELECT hacker_id , name , cnt , COUNT(*) OVER(PARTITION BY cnt) AS s_cnt , 
    MAX(cnt) OVER() AS ma FROM (
        SELECT H.hacker_id , name , COUNT(*) AS cnt
        FROM HACKERS AS H JOIN CHALLENGES AS C ON H.hacker_id = C.hacker_id
        GROUP BY  H.hacker_id , name  ) AS T  ) T2
WHERE cnt = ma OR s_cnt = 1 
ORDER BY cnt DESC , hacker_id
