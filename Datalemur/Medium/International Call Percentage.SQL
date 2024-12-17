/*
  A phone call is considered an international call when the person calling is 
  in a different country than the person receiving the call.

  What percentage of phone calls are international? Round the result to 1 decimal.
  */


select  
  round(
    (   
      avg
         ( 
        case 
          when 
            pinf.country_id = pinf2.country_id 
          then -- If there is a match that means the call is national
            0 
          else -- If there is no match that means the call is international
            1 
        end -- This will produce a list of 1s and 0s and it be handed to the avg function
         ) 
    ) * 100.00 -- Without this the result would look like 0.54545454
    , 1 ) -- Round the result to 1 decimal
    as international_calls_pct

from 
    phone_calls as pc

    join phone_info pinf
       on pc.caller_id = pinf.caller_id 

    join phone_info pinf2
       on pc.receiver_id   = pinf2.caller_id ;
/*
  The phone table contains caller_id, receiver_id	and call_time
  The phone_info table contains caller_id,	country_id,	network	and phone_number

  The joins are to get the country of the caller_id	and receiver_id to know 
  if the call is international so We can get the average
  */