with t as (
  select 
      a.artist_name 
    , count(*) 
      as cnt
  
  from   
    artists a
  
    join  songs s
      on  s.artist_id = a.artist_id 
  
    join global_song_rank g
      on g.song_id = s.song_id
  
  where  
        1=1
    and g.rank <= 10 
  
  group by  
      a.artist_id 
    , a.artist_name
)

, t2 as (
  select 
      artist_name 
    , dense_rank() over(order by cnt desc ) 
      as artist_rank
  
  from 
    t

)


select 
    * 
from 
  t2

where artist_rank <= 5;
