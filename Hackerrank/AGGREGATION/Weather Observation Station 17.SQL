/* mysql  &  ms sql server */
select 
    cast( s.long_w as decimal(12,4) ) 

from 
    station s 

where
      1=1
  and s.lat_n = (
                    select 
                        min(t.lat_n) 
                    from 
                        station t 
                    where 
                        t.lat_n > 38.7780 
                );




/* mysql */
select 
    round( s.long_w , 4 ) 

from 
    station s 

where
      1=1
  and s.lat_n > 38.7780 

order by 
    s.lat_n asc 

limit 1;




/* ms sql server */
select 
    top 1 cast( s.long_w as decimal(8,4) ) 

from 
    station s 

where 
    s.lat_n > 38.7780 

order by 
    s.lat_n asc ;
