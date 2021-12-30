# Datasets used: employee_details.csv and Department_Details.csv
# Use subqueries to answer every question

create database day1_sql2_takehome;
use day1_sql2_takehome;
# import csv files in Employee database.

SELECT * FROM DEPARTMENT_DETAILS;
SELECT * FROM EMPLOYEE_DETAILS;


#Q1. Retrive employee_id , first_name , last_name and salary details of those employees whose salary is greater than the average salary of all the employees.

select employee_id,first_name,last_name,salary from employee_details
 where salary>(select avg(salary) from employee_details);
#Q2. Display first_name , last_name and department_id of those employee where the location_id of their department is 1700
select first_name,last_name,department_id from employee_details where department_id in
 (select department_id from 
 department_details where location_id=1700);

#Q3. From the table employees_details, extract the employee_id, first_name, last_name, job_id and department_id who work in  any of the departments of Shipping, Executive and Finance.
select employee_id,first_name,last_name,job_id,department_id from employee_details where department_id 
in (select department_id from department_details
where department_name =any(select department_name from department_details where department_name in ('shipping','executive','finance')));


#Q4. Extract employee_id, first_name, last_name,salary, phone_number and email of the CLERKS who earn more than the salary of any IT_PROGRAMMER.
select * from employee_details;
select e.employee_id,e.first_name,e.last_name,e.salary,e.phone_number,e.email
from employee_details e, employee_details a where e.job_id like '%clerk%'  
and  e.salary>any
(select a.salary from employee_details a where a.job_id='IT_PROG')  ;


#Q5. Extract employee_id, first_name, last_name,salary, phone_number, email of the AC_ACCOUNTANTs who earn a salary more than all the AD_VPs.
select emploYee_id,first_name,last_name,salary,phone_number,email,JOB_ID 
from employee_details where salary>all
(select salary from employee_details where job_id='AD_VP') AND
job_id='AC_ACCOUNTANT';




#Q6. Write a Query to display the employee_id, first_name, last_name, department_id of the employees who have been recruited in the recent half timeline since the recruiting began. 
select distinct employee_id,first_name,last_name,department_id,hire_date
from employee_Details where hire_date>(Select avg(hire_date)from employee_Details);

#Q7. Extract employee_id, first_name, last_name, phone_number, salary and job_id of the employees belonging to the 'Contracting' department 
select employee_id,first_name,last_name,phone_number,salary,job_id,department_id 
from employee_details where department_id in 
(select department_id  from department_Details where department_name='contracting');

#Q8. Extract employee_id, first_name, last_name, phone_number, salary and job_id of the employees who does not belong to 'Contracting' department
select employee_id,first_name,last_name,phone_number,salary,job_id,department_id 
from employee_details where department_id in 
(select department_id  from department_Details where department_name<>'contracting');


#Q9. Display the employee_id, first_name, last_name, job_id and department_id of the employees who were recruited first in the department
select  employee_id,first_name,last_name,job_id,department_id,hire_date from employee_Details 
where (department_id,employee_id) in(select department_id ,min(employee_id) from employee_details   group by department_id)  ;
select  employee_id,first_name,last_name,job_id,department_id,hire_date from employee_Details 
where  department_id in (select distinct department_id from employee_details) group by department_id order by department_id;

#Q10. Display the employee_id, first_name, last_name, salary and job_id of the employees who earn maximum salary for every job.
select  distinct employee_id, first_name, last_name, salary , job_id from employee_Details
 where salary in(select max(salary) from employee_Details group by job_id order by max(salary)) order by salary ;
 