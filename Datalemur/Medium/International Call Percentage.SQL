SELECT  
ROUND(
  AVG( CASE WHEN Pinf.country_id = Pinf2.country_id 
    THEN 0 ELSE 1 END ) * 100.00 , 1 )
  AS international_calls_pct
FROM phone_calls AS Pc
JOIN phone_info AS Pinf
  ON Pc.caller_id   = Pinf.caller_id 
JOIN phone_info AS Pinf2
  ON Pc.receiver_id   = Pinf2.caller_id ;
