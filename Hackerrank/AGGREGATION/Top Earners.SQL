--mysql  &  ms sql server
select salary * months , count(*) from employee     
where  salary * months = ( select max(salary * months) from employee )
group by salary * months;



--mysql 
select salary * months as te, count(*) from employee     
group by salary * months
having te = ( select max(salary * months) from employee );



--mysql 
select salary * months as te, count(*) from employee     
group by te
order by te desc limit 1 ;



--ms sql server
select salary * months , count(*) from employee     
group by salary * months
having salary * months = ( select max(salary * months) from employee );



--ms sql server
select top 1 salary * months , count(*) from employee     
group by salary * months
order by salary * months desc;
