-- 1
SELECT card_name , issued_amount 
  FROM (
    SELECT 
    card_name , 
    issued_amount , 
    RANK() OVER(PARTITION BY card_name 
      ORDER BY issue_year , issue_month )
    AS rnk
    FROM monthly_cards_issued
) AS T
WHERE rnk = 1 
ORDER BY issued_amount DESC ;


-- 2
SELECT card_name , issued_amount 
FROM (
    SELECT card_name , issued_amount ,
    MAKE_DATE(issue_year , issue_month , 1)
      AS issue_date ,
    MIN( MAKE_DATE(issue_year , issue_month , 1) )
      OVER(PARTITION BY card_name)
      AS launch_date 
    FROM monthly_cards_issued
) AS T
WHERE launch_date = issue_date 
ORDER BY issued_amount DESC;
