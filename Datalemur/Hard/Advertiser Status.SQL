/*
daily_pay table contains the current payment information for advertisers, and it 
only includes advertisers who have made payments.

advertiser table contains information about advertisers and their respective 
current payment status


New:       Advertisers who are new and made their first payment.
Existing:  Advertisers who made payments and recently made a current payment.
Churn:     Advertisers who made payments but not any recent payment.
Resurrect: Advertisers who have not made a recent payment but may have made a previous payment 
and have made a payment again recently.


Example of an expected output
#	Current Status	  Updated Status	  Payment on Day T
1	NEW	              EXISTING	        Paid
2	NEW	              CHURN	            Not paid
3	EXISTING	        EXISTING	        Paid
4	EXISTING	        CHURN	            Not paid
5	CHURN             RESURRECT	        Paid
6	CHURN	            CHURN	            Not paid
*/



select 
    coalesce(a.user_id , d.user_id ) 
      as user_id_coalesce
  , case 
      when d.user_id is null then 'CHURN' 
      /*
        If the Advertiser didn't pay its user_id won't be in the daily_pay table
        Regardless if it is New, Existing or Churn it will turn into Churn

        Therefore the rest of Advertisers have made at least one payment
        That is why we have a nested case statement
        */
      else                                

        case -- All of them made a payment and their status will be updated based on the previous one
          when a.status = 'CHURN'  then 'RESURRECT' 
          when a.user_id  is null  then 'NEW' /*An advertiser might not be in the advertiser table but 
                                                it migt be in the daily_pay table then it status is new  */
          else 'EXISTING'
        end
    end 
      as new_status
/*
  Remember if an advertiser is not in the advertiser table but it is in the daily_pay that means
  they are new
  If they are not in the daily_pay that means they made a payment before but they have not made
  another again
  The rest of advertisers are in both tables and their status is updated based on the 
  previous one
  */

from 
  advertiser a
  
  full outer join daily_pay d
    on d.user_id = a.user_id

order by 
    user_id_coalesce;
