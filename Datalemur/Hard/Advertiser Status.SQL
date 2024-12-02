/*
daily_pay table contains the current payment information for advertisers, and it 
only includes advertisers who have made payments.

advertiser table contains information about advertisers and their respective 
payment status


New:       Advertisers who are new and made their first payment.
Existing:  Advertisers who made payments and recently made a current payment.
Churn:     Advertisers who made payments but not any recent payment.
Resurrect: Advertisers who have not made a recent payment but may have made a previous payment 
and have made a payment again recently.



Example of an expected output
#	Current Status	  Updated Status	  Payment on Day T
1	NEW	              EXISTING	        Paid
2	NEW	              CHURN	Not         Not paid
3	EXISTING	        EXISTING	        Paid
4	EXISTING	        CHURN	Not         Not paid
5	CHURN             RESURRECT	        Paid
6	CHURN	            CHURN	            Not paid
*/



select 
    coalesce(a.user_id , d.user_id ) 
      as user_id_coalesce
  , case 
      when d.user_id is null then 'CHURN'
      else 

        case
          when a.status = 'CHURN'  then 'RESURRECT'
          when a.user_id  is null  then 'NEW' 
          else  'EXISTING'
        end
    end 
      as new_status
/*
When an advertisers is new there is no record of it in the advertiser
*/


from 
  advertiser a
  
  full outer join daily_pay d
    on d.user_id = a.user_id

order by 
    user_id_coalesce;
