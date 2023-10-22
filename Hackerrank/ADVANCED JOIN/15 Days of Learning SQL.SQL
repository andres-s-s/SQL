--MySQL
SET @date = (SELECT MIN(submission_date) FROM SUBMISSIONS );
SELECT Mt.submission_date , Mt.ct , 
      (SELECT hacker_id FROM SUBMISSIONS WHERE submission_date = Mt.submission_date
       GROUP BY hacker_id ORDER BY COUNT(*) DESC , hacker_id ASC LIMIT 1 ) AS h_id , 
      (SELECT name FROM HACKERS WHERE hacker_id = h_id )
FROM  (
       SELECT T.submission_date , COUNT(*) AS ct FROM  (
          SELECT submission_date , hacker_id FROM SUBMISSIONS 
          GROUP BY submission_date , hacker_id   ) AS T 
          WHERE (SELECT COUNT(DISTINCT submission_date) FROM SUBMISSIONS 
                 WHERE hacker_id = T.hacker_id  AND submission_date < T.submission_date )  
          =  DATEDIFF(T.submission_date , @date )
       GROUP BY T.submission_date
      ) AS Mt
ORDER BY Mt.submission_date ASC;



--MySQL
SET @date = (SELECT MIN(submission_date) FROM SUBMISSIONS );
SELECT Mt.submission_date , Mt.ct , H.hacker_id , name 
FROM  (
    SELECT submission_date , COUNT(*) AS ct FROM  (
           SELECT submission_date , hacker_id FROM SUBMISSIONS 
           GROUP BY submission_date , hacker_id   ) AS T 
    WHERE (SELECT COUNT(DISTINCT submission_date) FROM SUBMISSIONS 
           WHERE hacker_id = T.hacker_id  AND
           submission_date < T.submission_date )  
    =  DATEDIFF( T.submission_date , @date )
    GROUP BY T.submission_date
      ) AS Mt
JOIN  SUBMISSIONS S ON Mt.submission_date = S.submission_date
JOIN  HACKERS H     ON S.hacker_id = H.hacker_id 
WHERE S.hacker_id = (SELECT hacker_id FROM SUBMISSIONS WHERE submission_date = Mt.submission_date
                     GROUP BY hacker_id ORDER BY COUNT(*) DESC , hacker_id ASC LIMIT 1
                     )
GROUP BY Mt.submission_date , Mt.ct , H.hacker_id , name 
ORDER BY Mt.submission_date ASC;



--MySQL
SELECT Mt.submission_date , COUNT(*) , H_idt.hacker_id , H.name 
FROM (
     SELECT submission_date , hacker_id , 
     IF(hacker_id != @hv , @csct := 1 ,  @csct := @csct + 1 ) AS h_rank , @hv := hacker_id  
     FROM (SELECT DISTINCT submission_date , hacker_id  FROM SUBMISSIONS 
           ORDER BY hacker_id , submission_date  ) Sd , (SELECT @csct := 1,@hv := 0 ) Et 
) AS Mt
JOIN (
     SELECT submission_date , @d := @d + 1 AS d_rank
     FROM (SELECT DISTINCT submission_date FROM SUBMISSIONS ORDER BY submission_date ASC ) Idt,
          (SELECT @d := 0) Dv 
) AS Dt
ON Dt.submission_date = Mt.submission_date AND Mt.h_rank = Dt.d_rank
JOIN (
     SELECT submission_date , hacker_id ,
     @mc := CASE WHEN submission_date = @ahv THEN @mc + 1 ELSE 1 END AS mch , @ahv := submission_date
     FROM (SELECT submission_date , hacker_id FROM SUBMISSIONS GROUP BY submission_date , hacker_id 
           ORDER BY submission_date , COUNT(*) DESC, hacker_id) M , (SELECT @mc := 0,@ahv := 0) Et2
) AS H_idt
ON H_idt.submission_date = Mt.submission_date AND H_idt.mch = 1
JOIN HACKERS H ON  H_idt.hacker_id = H.hacker_id
GROUP BY Mt.submission_date , H_idt.hacker_id , H.name
ORDER BY Mt.submission_date ASC;



--MySQL
SET @date = (SELECT MIN(submission_date) FROM SUBMISSIONS );
SELECT Dt.submission_date , 
    (SELECT COUNT(DISTINCT hacker_id) FROM SUBMISSIONS AS S
     WHERE submission_date = Dt.submission_date 
     AND   (SELECT COUNT(DISTINCT submission_date) FROM SUBMISSIONS 
            WHERE S.submission_date > submission_date 
            AND hacker_id = S.hacker_id) = 
    DATEDIFF( Dt.submission_date , @date )  ) ,
    
    (SELECT hacker_id FROM SUBMISSIONS 
     WHERE submission_date = Dt.submission_date 
     GROUP BY hacker_id 
     ORDER BY COUNT(*) DESC , hacker_id LIMIT 1  ) AS H_id ,
    (SELECT name FROM HACKERS  WHERE H_id = hacker_id  )

FROM (SELECT DISTINCT submission_date 
      FROM SUBMISSIONS 
      ORDER BY submission_date ASC  ) AS Dt
ORDER BY Dt.submission_date ASC;



--MS SQL Server
DECLARE @date DATE;
SET @date = (SELECT MIN(submission_date) FROM SUBMISSIONS );
SELECT submission_date , ct , h_id , name FROM (
SELECT Mt.submission_date , Mt.ct , 
      (SELECT TOP 1 hacker_id FROM SUBMISSIONS WHERE submission_date = Mt.submission_date
       GROUP BY hacker_id ORDER BY COUNT(*) DESC , hacker_id ASC ) AS h_id 
FROM  (
SELECT submission_date , COUNT(*) AS ct FROM  (
       SELECT submission_date , hacker_id FROM SUBMISSIONS 
       GROUP BY submission_date , hacker_id   ) AS T 
WHERE (SELECT COUNT(DISTINCT submission_date) FROM SUBMISSIONS 
       WHERE hacker_id = T.hacker_id  AND
       submission_date < T.submission_date )  
    =  DATEDIFF(dd, @date , T.submission_date )
GROUP BY T.submission_date
      ) AS Mt
 ) Xt 
 JOIN HACKERS H ON Xt.h_id = H.hacker_id 
 ORDER BY submission_date ASC ;



--MS SQL Server
DECLARE @date DATE;
SET @date = (SELECT MIN(submission_date) FROM SUBMISSIONS );
SELECT Mt.submission_date , Mt.ct , H.hacker_id , name 
FROM  (
SELECT submission_date , COUNT(*) AS ct FROM  (
       SELECT submission_date , hacker_id FROM SUBMISSIONS 
       GROUP BY submission_date , hacker_id   ) AS T 
WHERE (SELECT COUNT(DISTINCT submission_date) FROM SUBMISSIONS 
       WHERE hacker_id = T.hacker_id  AND
       submission_date < T.submission_date )  
    =  DATEDIFF(dd, @date , T.submission_date )
GROUP BY T.submission_date
      ) AS Mt
JOIN  SUBMISSIONS S ON Mt.submission_date = S.submission_date
JOIN  HACKERS H     ON S.hacker_id = H.hacker_id 
WHERE S.hacker_id = (SELECT TOP 1 hacker_id FROM SUBMISSIONS WHERE submission_date = Mt.submission_date
                     GROUP BY hacker_id ORDER BY COUNT(*) DESC , hacker_id ASC 
                     )
GROUP BY Mt.submission_date , Mt.ct , H.hacker_id , name 
ORDER BY Mt.submission_date ASC;



--MS SQL Server
SELECT Mt.submission_date , COUNT(*) , Hid_t.hacker_id , H.name
FROM
(SELECT submission_date , hacker_id , 
 ROW_NUMBER() OVER(PARTITION BY hacker_id ORDER BY hacker_id ,submission_date) AS ct
 FROM SUBMISSIONS GROUP BY submission_date , hacker_id) AS Mt
 JOIN 
(SELECT submission_date , ROW_NUMBER() OVER(ORDER BY submission_date) AS ct
 FROM SUBMISSIONS GROUP BY submission_date ) AS Dt 
ON Mt.ct = Dt.ct AND Mt.submission_date = Dt.submission_date
JOIN 
(SELECT hacker_id , submission_date ,
 ROW_NUMBER() OVER(PARTITION BY submission_date ORDER BY  COUNT(*) DESC , hacker_id )
 AS ct FROM SUBMISSIONS GROUP BY submission_date , hacker_id ) AS Hid_t
JOIN HACKERS H ON H.hacker_id = Hid_t.hacker_id                 /**/
ON Hid_t.submission_date = Mt.submission_date AND Hid_t.ct = 1  /**/
GROUP BY Mt.submission_date , Hid_t.hacker_id , H.name
ORDER BY Mt.submission_date ASC



--MS SQL Server
DECLARE @date DATE;
SET @date = (SELECT MIN(submission_date) FROM SUBMISSIONS );
SELECT submission_date , ct , h_id , name FROM (
    SELECT Dt.submission_date , 
        (SELECT COUNT(DISTINCT hacker_id) FROM SUBMISSIONS AS S
         WHERE submission_date = Dt.submission_date 
         AND   (SELECT COUNT(DISTINCT submission_date) FROM SUBMISSIONS 
                WHERE Dt.submission_date > submission_date 
                AND hacker_id = S.hacker_id) = 
        DATEDIFF(dd, @date , Dt.submission_date )  ) AS ct,
    
        (SELECT TOP 1 hacker_id FROM SUBMISSIONS 
         WHERE submission_date = Dt.submission_date 
         GROUP BY hacker_id 
         ORDER BY COUNT(*) DESC , hacker_id  ) AS h_id 
    FROM (SELECT DISTINCT submission_date 
          FROM SUBMISSIONS 
         ) AS Dt
    ) AS T 
JOIN HACKERS H ON H.hacker_id = h_id
ORDER BY submission_date ASC ;
