-- SQL Questions  

# 1. Find the longest ongoing project for each department ? 

select  p.id , p.name as project_name  , concat(datediff( p.end_date, p.start_date), " " 'days') project_duration ,d.name as department_name
from projects p 
join departments d 
using ( id )
limit 3 ; 

# 2. Find all employees who are not managers.
select * from employees
where job_title not like "%manager%" ; 

# 3 . Find all employees who have been hired after the start of a project in their department.

select e.name , e.job_title , p.start_date , e.hire_date from employees e 
join projects p 
using ( department_id ) 
where hire_date> start_date ;

# 4. Rank employees within each department based on their hire date (earliest hire gets the highest rank).

select  name , hire_date , job_title , 
dense_rank () over( partition by department_id order by hire_date) as rnk 
from employees ;

# 5.Find the duration between the hire date of each employee and the hire date of the next employee hired in the same department.

select  e.name as e_name   , d.name as d_name , hire_date , datediff( lead(hire_date) over( partition by d.name order by e.hire_date ), hire_date ) as duration 
from employees e
join departments d
on d.id = e.department_id 


