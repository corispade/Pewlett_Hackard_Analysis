-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name));
	
CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no));

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no));
	
CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no));

DROP TABLE titles CASCADE;
CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
	PRIMARY KEY (emp_no, title, from_date));

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no));
	
-- Confirm code by using select statements
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

-- Find list of employees about to retire
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create retirement table
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

-- Create new table for retiring employees inc the emp_no
DROP TABLE retirement_info;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

-- Use inner join for Departments and Dept_Manager tables
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments AS d
INNER JOIN dept_manager AS dm
ON d.dept_no = dm.dept_no;

-- Use left join on retirement_info and dept_emp tables.
-- Create a new table to hold joined data for currently elligible for retirement
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

SELECT * FROM current_emp;

-- Join current_emp and dept_emp tables to get employee count by dept number.
-- Create a table from joined data
SELECT COUNT(ce.emp_no), de.dept_no
INTO current_dept_count
FROM current_emp AS ce
LEFT JOIN dept_emp AS de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM current_dept_count;

-- Find employee information for retiring employees
SELECT * FROM salaries
ORDER BY to_date DESC;

-- 1. Create new table with emp_info
SELECT emp_no, first_name, last_name, gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM emp_info;

DROP TABLE emp_info;

-- 2. Join employee to the salaries table to create emp_info table
SELECT e.emp_no, 
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
	ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
	AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01');
	
SELECT * FROM emp_info;

-- Get Management Information for retiring employees

-- get list of managers per department
SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
--INTO manager_info
FROM dept_manager AS dm
INNER JOIN departments AS d
	ON (dm.dept_no = d.dept_no)
INNER JOIN current_emp AS ce
	ON (dm.emp_no = ce.emp_no);
	
-- Find department retirees 
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
--INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as de
	ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
	ON (de.dept_no = d.dept_no);
	
-- Find department retirees for sales team
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO sales_info
FROM current_emp as ce
INNER JOIN dept_emp as de
	ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
	ON (de.dept_no = d.dept_no)
WHERE dept_name = 'Sales';

SELECT * FROM sales_info;

-- Find department retirees for sales and development team
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dev_sales_info
FROM current_emp as ce
INNER JOIN dept_emp as de
	ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
	ON (de.dept_no = d.dept_no)
WHERE dept_name IN ('Sales', 'Development')
ORDER BY dept_name;

SELECT * FROM dev_sales_info;