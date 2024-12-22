--mysql  &  ms sql server
select 
    left( trans_date , 7 ) 
      as month 
  , country 
  , count(*)  
      as trans_count 
  , count( 
          case 
              when state = 'approved' 
              then amount 
          end  
         ) 
      as approved_count 
  , sum( amount ) 
      as trans_total_amount 
  , sum( 
        case 
            when state = 'approved' 
            then amount 
            
            else 0 
        end ) 
      as approved_total_amount

from 
    transactions 

group by 
    country 
  , left( trans_date , 7 ) ; 



--mysql
select 
    date_format(trans_date, '%y-%m') as month 
  , country 
  , count(*) 
      as trans_count 
  , count( 
            if( 
                  state = 'approved' 
                , amount 
                , null
              )  
         ) 
      as approved_count 
  , sum( amount ) 
      as trans_total_amount 
  , sum(   
            if( 
                  state = 'approved' 
                , amount 
                , 0   
              )  
       ) 
      as approved_total_amount

from 
    transactions 

group by 
    country 
  , date_format(trans_date, '%y-%m') ; 



  --ms sql server
select 
    format( trans_date , 'yyyy-mm' ) as month 
  , country 
  , count(*)  
      as trans_count 
  , count(  
            case 
                when state = 'approved' 
                then amount 
            end  
         ) 
      as approved_count 
  , sum( amount ) 
      as trans_total_amount 
  , sum(    
            case 
                when state = 'approved' 
                then amount 
                
                else 0 
            end 
       ) 
      as approved_total_amount

from 
    transactions 
  
group by 
    country 
  , format( trans_date , 'yyyy-mm' ) ; 
  