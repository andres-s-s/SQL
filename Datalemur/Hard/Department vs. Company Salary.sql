/*
Write a query to compare the average salary of employees in each department to the company's 
average salary for March 2024. Return the comparison result as 'higher', 'lower', or 'same' 
for each department. Display the department ID, payment month (in MM-YYYY format), and 
the comparison result.
*/


with avg_month_salary as (

    select 
        avg(s.amount) 
          as avg_s
    from 
        salary s
    where
        to_char( s.payment_date , 'DD/MM/YYYY' ) like '%03/2024%'
) -- average salary for March 2024


 , avg_month_salary_by_department_id as (

    select 
        e.department_id
      , to_char( s.payment_date , 'MM-YYYY' )
          as mnth
      , avg(s.amount) -- department_id average salary
          as d_id_avg_salary
    from 
        employee e

        join salary s
           on s.employee_id = e.employee_id 

    where
        to_char( s.payment_date , 'DD/MM/YYYY' ) like '%03/2024%'
    
    group by 
        e.department_id
      , to_char( s.payment_date , 'MM-YYYY' )


)



select
    a.department_id
  , a.mnth
  , case 
        when a.d_id_avg_salary > (select avg_s from avg_month_salary)
        then 'higher'

        when a.d_id_avg_salary < (select avg_s from avg_month_salary)
        then 'lower'

        else 'same'
    end

from 
    avg_month_salary_by_department_id a