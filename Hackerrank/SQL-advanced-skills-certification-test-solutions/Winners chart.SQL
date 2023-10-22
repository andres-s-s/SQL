--MySQL 
SELECT
CONCAT ( id , " " ,  
GROUP_CONCAT((CASE WHEN pl = 1 THEN participant_name END) ORDER BY  participant_name) , "   " ,
GROUP_CONCAT((CASE WHEN pl = 2 THEN participant_name END) ORDER BY  participant_name) , "   " ,
GROUP_CONCAT((CASE WHEN pl = 3 THEN participant_name END) ORDER BY  participant_name) )
 FROM (
    SELECT id , participant_name , sc ,
    @rown := CASE WHEN id = @idvar THEN
                CASE WHEN @pvar = sc THEN @rown
                ELSE @rown + 1 END
            ELSE 1  END  AS pl ,
    @idvar := id ,
    @pvar := sc
FROM (
    SELECT event_id AS id , participant_name , MAX(score) AS sc
    FROM SCORETABLE
    GROUP BY id , participant_name
    ORDER BY id , sc DESC
     ) AS T ,
    (SELECT @rown := 0 , @idvar := 0 , @pvar := 0) AS T2
    ORDER BY id , sc DESC
) AS MT
WHERE pl IN (1,2,3)
GROUP BY id
ORDER BY id;



--MS SQL SERVER
SELECT id , STRING_AGG(names , "    ") WITHIN GROUP (ORDER BY rnk ASC) 
FROM (
    SELECT id , rnk , STRING_AGG( nam , "," ) WITHIN GROUP (ORDER BY nam) AS names
    FROM (
        SELECT id , nam ,
        DENSE_RANK() OVER(PARTITION BY id ORDER BY  sc DESC) AS rnk
        FROM (
            SELECT event_id AS id , participant_name AS nam , MAX(score) AS sc
            FROM SCORETABLE
            GROUP BY event_id , participant_name
            ) AS T
        ) AS MT
    WHERE rnk IN (1 , 2 , 3)
    GROUP BY id , rnk
) AS T2 
GROUP BY id
ORDER BY id ;
