--MySQL  &  MS SQL Server
SELECT  MIN(CASE WHEN occupation = "Doctor"    THEN name END) AS "Doctor"    ,
        MAX(CASE WHEN occupation = "Professor" THEN name END) AS "Professor" , 
        MIN(CASE WHEN occupation = "Singer"    THEN name END) AS "Singer"    ,
        MAX(CASE WHEN occupation = "Actor"     THEN name END) AS "Actor" 
FROM (SELECT name , occupation , 
      ROW_NUMBER() OVER(PARTITION BY occupation ORDER BY name) AS ind
      FROM OCCUPATIONS ) AS T 
GROUP BY ind;



--MySQL  &  MS SQL Server
SELECT  MIN(Doctor)    AS "Doctor"     ,
        MAX(Professor) AS "Professor"  , 
        MIN(Singer)    AS "Singer"     ,
        MAX(Actor)     AS "Actor" 
FROM (SELECT name , occupation , 
      ROW_NUMBER() OVER(PARTITION BY occupation ORDER BY name) AS ind ,
      CASE WHEN occupation = "Doctor"    THEN name END AS "Doctor"     ,
      CASE WHEN occupation = "Professor" THEN name END AS "Professor"  , 
      CASE WHEN occupation = "Singer"    THEN name END AS "Singer"     , 
      CASE WHEN occupation = "Actor"     THEN name END AS "Actor"
      FROM OCCUPATIONS ) AS T 
GROUP BY ind;



--MySQL
SET @d := 0,@p := 0,@s := 0,@a := 0;
SELECT  MIN(Doctor)    AS "Doctor"     ,
        MAX(Professor) AS "Professor"  , 
        MIN(Singer)    AS "Singer"     ,
        MAX(Actor)     AS "Actor" 
FROM (SELECT name , occupation , 
      CASE WHEN occupation = "Doctor" THEN (@d := @d + 1) 
           WHEN occupation = "Professor" THEN (@p := @p + 1)
           WHEN occupation = "Singer" THEN (@s := @s + 1)
           WHEN occupation = "Actor" THEN (@a := @a + 1) 
      END AS ind ,
      CASE WHEN occupation = "Doctor"    THEN name END AS "Doctor"     ,
      CASE WHEN occupation = "Professor" THEN name END AS "Professor"  , 
      CASE WHEN occupation = "Singer"    THEN name END AS "Singer"     , 
      CASE WHEN occupation = "Actor"     THEN name END AS "Actor"
      FROM OCCUPATIONS ORDER BY name ) AS T 
GROUP BY ind;
