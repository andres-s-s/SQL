select  
  round(
    ( avg( 
        case 
          when 
            pinf.country_id = pinf2.country_id 
        
          then 
            0 
          else 
            1 
        end
         ) 
    )* 100.00 
    , 1 )
    as international_calls_pct

from 
  phone_calls as pc

    join phone_info as pinf
      on pc.caller_id = pinf.caller_id 

    join phone_info as pinf2
      on pc.receiver_id   = pinf2.caller_id ;
