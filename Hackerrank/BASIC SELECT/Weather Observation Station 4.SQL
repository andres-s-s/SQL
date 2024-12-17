/* mysql  &  ms sql server */
select 
    count(s.city) - count(distinct s.city ) 

from 
    station s;
