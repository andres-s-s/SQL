--MySQL
SELECT DATE_FORMAT(record_date , "%c") , MAX(data_value) , MIN(data_value) , 
ROUND( AVG(CASE WHEN data_type = "avg" THEN data_value END) )
FROM TEMPERATURE_RECORDS 
GROUP BY DATE_FORMAT(record_date , "%c");



--MS SQL SERVER
SELECT MONTH( record_date ) , 
MAX(data_value) , MIN(data_value) , 
CAST( ROUND( AVG( CAST( CASE WHEN data_type = "avg" THEN data_value END AS DECIMAL(8,4) )  ), 0 ) AS INT)
FROM TEMPERATURE_RECORDS
GROUP BY MONTH( record_date );
