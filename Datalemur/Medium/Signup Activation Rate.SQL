select 
    round( 
        count(t.email_id)/count(*)::decimal 
      , 2 )
      as activation_rate

from 
  emails e

    left join texts t
      on t.email_id = e.email_id 
     and t.signup_action = 'confirmed';
