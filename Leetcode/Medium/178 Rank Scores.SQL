--MySQL  &  MS SQL SERVER
SELECT score , DENSE_RANK() OVER(ORDER BY score DESC ) AS "rank"
FROM Scores ORDER BY score DESC ;



--MySQL  &  MS SQL SERVER
SELECT S.score , COUNT(*) AS "rank"
FROM Scores AS S 
JOIN ( SELECT DISTINCT score FROM Scores ) AS S2
ON S.score <= S2.score 
GROUP BY S.id , S.score 
ORDER BY S.score DESC ;



--MySQL  &  MS SQL SERVER
SELECT score , SUM(rnk) OVER(ORDER BY score DESC) AS "rank" 
FROM (
  SELECT score ,  
  CASE WHEN LAG(score) OVER(ORDER BY score DESC) = score THEN 0 ELSE + 1 END AS "rnk" 
  FROM Scores
) AS T ;



--MySQL
SELECT score , CONVERT(rnk , SIGNED) AS "rank" FROM (
    SELECT score , 
    @rank := CASE WHEN score = @p THEN @rank ELSE @rank + 1 
    END AS "rnk" , @p := score
    FROM Scores , (SELECT @p:=-1 , @rank:=0 ) AS T
    ORDER BY score DESC
) T2;
