--MySQL  &  MS SQL Server
SELECT CASE 
        WHEN A = B AND B = C THEN "Equilateral"
        WHEN A + B <= C  THEN "Not A Triangle"
        WHEN A = B OR A = C THEN "Isosceles"
        ELSE "Scalene" END
FROM TRIANGLES;



--MySQL  &  MS SQL Server
SELECT CASE 
        WHEN A = B AND B = C THEN "Equilateral"
        WHEN A + B <= C OR B + C <= A OR A + C <= B THEN "Not A Triangle"
        WHEN A = B OR C = B OR A = C OR B = C THEN "Isosceles"
        ELSE "Scalene" END
FROM TRIANGLES;



--MySQL  &  MS SQL Server
SELECT CASE 
        WHEN A + B > C THEN
          CASE WHEN A = B AND B = C THEN "Equilateral"
               WHEN A = B OR A = C  THEN "Isosceles"
               ELSE "Scalene" END
          ELSE "Not A Triangle" END
FROM TRIANGLES;



--MySQL 
SELECT IF(A+B <= C,"Not A Triangle",IF( A=B AND B=C,"Equilateral",IF(A=B OR A=C ,"Isosceles","Scalene") ) ) 
FROM TRIANGLES;
