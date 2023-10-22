/*
Show patient_id and first_name from patients 
where their first_name start and ends with 's' 
and is at least 6 characters long.
*/
SELECT patient_id , first_name
FROM patients
WHERE first_name LIKE 's____%s';




/*
Show all of the patients grouped into weight groups.
Show the total amount of patients in each weight group.
Order the list by the weight group decending.
*/
SELECT COUNT(*) , 
  FLOOR(weight/10)*10 AS group_by_weight
FROM patients
GROUP BY FLOOR(weight/10)*100
ORDER BY FLOOR(weight/10)*100 DESC;




/*
Show patient_id, weight, height, isObese from the patients table.

Display isObese as a boolean 0 or 1.

Obese is defined as weight(kg)/(height(m)2) >= 30.
*/
SELECT  patient_id, weight, height, 
  CASE WHEN weight/POWER( (height/100.0) , 2)>= 30
    THEN 1 ELSE 0 
  END AS isObese 
FROM patients




/*
Show patient_id, first_name, last_name, and attending doctor's specialty.
Show only the patients who has a diagnosis as 'Epilepsy' 
and the doctor's first name is 'Lisa'
*/
SELECT  P.patient_id, P.first_name , 
P.last_name , D.specialty
FROM patients P
JOIN admissions A
  ON P.patient_id = A.patient_id 
JOIN doctors D 
  ON D.doctor_id = A.attending_doctor_id 
where diagnosis = 'Epilepsy'
AND D.first_name = 'Lisa'



/*
All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.

The password must be the following, in order:
1. patient_id
2. the numerical length of patient's last_name
3. year of patient's birth_date
*/
SELECT DISTINCT P.patient_id , 
CONCAT(P.patient_id , LEN(P.last_name) , YEAR(birth_date) ) AS temp_password
FROM admissions A
JOIN patients P
  on A.patient_id = P.patient_id 




/*
Each admission costs $50 for patients without insurance, and $10 for patients with insurance. 
All patients with an even patient_id have insurance.

Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the 
admission_total cost for each has_insurance group.
*/
SELECT 
  CASE WHEN patient_id % 2 = 0 THEN "Yes" ELSE "No"
  END AS insurance , 
  SUM( CASE WHEN patient_id % 2 = 0 THEN 10 ELSE 50 END ) AS cnt
FROM  admissions 
GROUP BY insurance





/*
Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name
*/
SELECT province_name 
FROM patients P
JOIN province_names Pn
  on P.province_id = Pn.province_id
GROUP BY province_name
HAVING COUNT(CASE WHEN gender = "M" then 1 end ) >
	     COUNT(CASE WHEN gender = "F" then 1 end )




/*
We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
- First_name contains an 'r' after the first two letters.
- Identifies their gender as 'F'
- Born in February, May, or December
- Their weight would be between 60kg and 80kg
- Their patient_id is an odd number
- They are from the city 'Kingston'
*/
SELECT * FROM 
patients
WHERE first_name LIKE '__r%'
AND gender = 'F'
AND MONTH(birth_date) IN (2,3,12)
AND weight BETWEEN 60 AND 80 
AND patient_id % 2 != 0 
AND city = 'Kingston'





/*
Show the percent of patients that have 'M' as their gender. 
Round the answer to the nearest hundreth number and in percent form.
*/
SELECT CONCAT(
  ROUND( 
    AVG(CASE WHEN gender = 'M' THEN 1.0 ELSE 0.0 END )*100 , 2 
  )
, '%' )
FROM patients



/*
For each day display the total amount of admissions on that day. 
Display the amount changed from the previous date.
*/
SELECT admission_date , COUNT(*) , 
  COUNT(*)  - LAG( COUNT(*) ) OVER(ORDER BY admission_date ) 
FROM admissions
GROUP BY admission_date






/*
Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.
*/
SELECT province_name
FROM province_names
ORDER BY 
  CASE WHEN province_name = 'Ontario' THEN 'AAA' ELSE 'Z' END ASC,
province_name


SELECT province_name
FROM province_names
ORDER BY 
  CASE WHEN province_name = 'Ontario' THEN 5 ELSE 6 END ASC,
province_name






/*
We need a breakdown for the total amount of admissions each doctor has started each year. 
Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.
*/
SELECT doctor_id , CONCAT(first_name , ' ' , last_name ) , 
specialty , YEAR(admission_date) , COUNT(*)
FROM admissions A
JOIN doctors D
  ON A.attending_doctor_id = D.doctor_id
GROUP BY doctor_id , YEAR(admission_date) 
