select 
    coalesce(a.user_id , d.user_id ) as user_id_coalesce
  , case 
      when d.user_id is null then 'CHURN'
      else 

        case
          when a.status = 'CHURN'  then 'RESURRECT'
          when a.user_id  is null  then 'NEW' 
          else  'EXISTING'
        end

    end as new_status

from 
  advertiser a
  
  full outer join daily_pay d
    on d.user_id = a.user_id

order by 
    user_id_coalesce;
