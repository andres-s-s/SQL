SELECT * FROM (
    SELECT artist_name , 
    DENSE_RANK() OVER(ORDER BY cnt DESC ) AS artist_rank
    FROM (
        SELECT A.artist_name , COUNT(*) AS cnt
        FROM   artists A
        JOIN   songs S
          ON   S.artist_id = A.artist_id 
        JOIN   global_song_rank G
          ON   G.song_id = S.song_id
        WHERE  G.rank <= 10 
        GROUP BY  A.artist_id , A.artist_name
    ) AS T
) AS T2
WHERE artist_rank <= 5;
