# 1
SELECT
  item_type ,
  ROUND( (500000 -  (SELECT SUM(square_footage) FROM inventory 
                     WHERE item_type != 'prime_eligible'))/SUM(square_footage) )  
  * COUNT(*) AS item_count
FROM inventory
WHERE item_type = 'prime_eligible'
GROUP BY item_type
UNION ALL 
SELECT item_type ,   
ROUND( ( ( (500000 - (SELECT SUM(square_footage) FROM inventory WHERE item_type != 'prime_eligible')) 
    % (SELECT SUM(square_footage) FROM inventory 
       WHERE item_type = 'prime_eligible'))
          + (SELECT SUM(square_footage) FROM inventory 
             WHERE item_type != 'prime_eligible') )
               /SUM(square_footage) ) 
* COUNT(*) AS item_count
FROM inventory 
WHERE item_type != 'prime_eligible'
GROUP BY item_type;



# 2
WITH Summary AS (
  SELECT 
    SUM(CASE WHEN item_type = 'not_prime' THEN square_footage END ) 
      AS np_sf  , 
    COUNT(CASE WHEN item_type = 'not_prime' THEN square_footage END ) 
      AS np_cnt , 
    SUM(CASE WHEN item_type = 'prime_eligible' THEN square_footage END )
      AS pe_sf , 
    COUNT(CASE WHEN item_type = 'prime_eligible' THEN square_footage END )
      AS pe_cnt
  FROM inventory
) , 
T AS (
  SELECT 500000 - np_sf AS sbt
  FROM Summary
)

SELECT 'prime_eligible' AS item_type , 
  FLOOR( (SELECT sbt FROM T )/pe_sf ) * pe_cnt
    AS item_count
FROM Summary 

UNION ALL 

SELECT 'not_prime' AS item_type ,
  FLOOR( ( ( (SELECT sbt FROM T ) % pe_sf ) + np_sf )/np_sf ) * np_cnt 
    AS item_count
FROM Summary;
