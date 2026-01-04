--creating department table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

column dept_id format 999999;
column dept_name format a20;
select *from departments;
--inserting values into departments
-- Departments
INSERT INTO departments VALUES (1, 'HR');
INSERT INTO departments VALUES (2, 'Data Science');
INSERT INTO departments VALUES (3, 'IT');
INSERT INTO departments VALUES (4, 'Finance');
select *from departments;

--creating employee TABLE
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    salary INT,
    dept_id INT
);

column emp_id format 999999;
column emp_name format a20;
column gender format a20;
column salary format 999999;
column dept_id format 999999;

-- Employees
INSERT INTO employees VALUES (1, 'sindhu', 'F', 50000, 2);
INSERT INTO employees VALUES (2, 'hari', 'M', 60000,3);
INSERT INTO employees VALUES (3, 'deepthi', 'F', 70000,2);
INSERT INTO employees VALUES (4, 'akhila', 'F', 65000,4);
INSERT INTO employees VALUES (5, 'raju', 'M', 55000, NULL); 
INSERT INTO employees VALUES (6, 'ravi', 'M', 50000,1); 
select *from employees;

--Basic Queries
--Employees with salary > 55000
SELECT * FROM employees WHERE salary > 55000;

--Employees whose name starts with 'A'
SELECT * FROM employees WHERE emp_name LIKE 'A%';

--Aggregates / GROUP BY
--Count of employees per department
select d.dept_name,count(e.emp_id) as total_no_employee from departments d join employees e on e.dept_id=d.dept_id
group by d.dept_name;

--Average salary per department
select d.dept_name,avg(e.salary) as average_salary from departments d join employees e on e.dept_id=d.dept_id
group by d.dept_name;

--Departments with average salary > 60000
select d.dept_name,avg(e.salary) from departments d join employees e on d.dept_id=e.dept_id
group by d.dept_name
having avg(e.salary)>60000;

--joins
--Employee names with department names
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;

--Employees without a department
SELECT e.emp_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL;

--Total salary per department
select d.dept_name,sum(e.salary) as total_salary from departments d join employees e on e.dept_id=d.dept_id
group by d.dept_name;

--Subqueries
--Employees earning more than the average salary
select emp_name,salary from employees where salary>(select avg(salary) from employees);

--Second highest salary
select max(salary) from employees where salary<(select max(salary) from employees);

--Employees earning more than their department’s average
select emp_name,salary from employees e where salary>(select avg(salary) from employees where dept_id=e.dept_id);

--Remove duplicate employees (same name)
DELETE FROM employees
WHERE emp_id NOT IN (
    SELECT MIN(emp_id)
    FROM employees
    GROUP BY emp_name
);

--Top 3 highest paid employees
select emp_name,salary from employees
order by salary desc
fetch first 3 row only;

--Count employees by gender
SELECT gender, COUNT(*) AS total
FROM employees
GROUP BY gender;

