use employees;
select * from employees;
select * from departments;
-- 1. List of employee by Department
-- write a query to list all employees along with their respective department names. 
-- Including employee number, first name,last name, department number, and department name.

select e.emp_no,e.first_name,e.last_name,d.dept_no,d.dept_name from employees e 
join dept_emp de
on e.emp_no = de.emp_no
join departments d 
on de.dept_no = d.dept_no;
-- 331603

-- 2. Current and Past Salary of Employee
-- write a query to retrieve all the salary records of a given employee (by employee number).
-- including employee number, salary, from_date, and to_date and highest salary
select e.emp_no,s.salary,s.from_date,s.to_date from employees e 
join salaries s 
on e.emp_no = s.emp_no
where e.emp_no ='10044'
order by salary desc
limit 1;
select * from salaries;

-- or 
select * from salaries
where emp_no='10044' order by salary desc
limit 1;

-- 3. employee with specific titles
-- write a query to find all employees wo have held a specific title (e.g:- Staff).
-- Including employee number, first_name, last_name, and title.
select e.emp_no,e.first_name,e.last_name,t.title from employees e
join titles t 
on e.emp_no = t.emp_no
where t.title = 'Staff';

-- 4. Department with their managers
-- write a query to list all departments along with their current manager.
-- Include department number, department name, manager's employee number, first name, and last name.
select d.dept_no,d.dept_name,e.emp_no,e.first_name,e.last_name from departments d
join dept_manager dm
on d.dept_no = dm.dept_no
join employees e
on dm.emp_no = e.emp_no; 

-- 5. employee count by department
-- write a query to count the number of employee in each department.
-- Including department number, department name ,and employee count
select d.dept_no,d.dept_name,count(de.emp_no) from departments d join dept_emp de on d.dept_no=de.dept_no
group by d.dept_no,d.dept_name; 

-- 6. . Employees' Birthdates in a Given Year
-- Question: Write a query to find all employees born in a specific year (e.g., 1953). Include
-- employee number, first name, last name, and birth date.
select e.emp_noe.first_name,e.last_name,birth_date from employees e;
select e.emp_no, e.first_name, e.last_name,e.birth_date from employees e where year(birth_date) = '1953';

-- 7.Employees Hired in the Last 5 Years
-- Question: Write a query to find all employees hired in the last 50 years.
-- Include employee number, first name, last name, and hire date. 
select e.emp_no, e.first_name, e.last_name,e.hire_date from employees e 
where e.hire_date >= date_sub(curdate(),interval 50 year); 

-- 8. Average Salary by Department
-- Question: Write a query to calculate the average
-- salary for each department. Include department
-- number, department name, and average salary
-- dept_no,department_name
select d.dept_no,d.dept_name,avg(s.salary) as avg_salary from departments d -- dept_no, dept_name
join dept_emp de on d.dept_no = de.dept_no join  -- emp_no, dept_no
salaries s on de.emp_no = s.emp_no
group by d.dept_no,d.dept_name;  -- emp_no, salary

-- 9.Gender Distribution in Each Department
-- Question: Write a query to find the gender distribution (number
-- of males and females) in each department. Include department
-- number, department name, count of males, and count of
-- females. 
select * from departments d; -- dept_no, dept_name
select d.dept_no,d.dept_name,e.gender,count(e.gender)as gender_count from departments d
join dept_emp de on de.dept_no = d.dept_no                                         
join employees e on de.emp_no = e.emp_no
group by d.dept_no,d.dept_name,e.gender; 

select d.dept_no, d.dept_name,
sum(case when e.gender = 'M' then 1 else 0 end) as male_count,
sum(case when e.gender = 'F' then 1 else 0 end) as female_count
from departments d
join dept_emp de on de.dept_no = d.dept_no                                         
join employees e on de.emp_no = e.emp_no
group by d.dept_no,d.dept_name; 

-- 10 Longest Serving Employees
-- - Question: Write a query to find the employees who have
-- served the longest in the company. Include employee number,
-- first name, last name, and number of years served.
select e.emp_no,e.first_name,e.last_name,timestampdiff(year,hire_date,curdate()) as servered_years from employees e order by servered_years desc limit 10;