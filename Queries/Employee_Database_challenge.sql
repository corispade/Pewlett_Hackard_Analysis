-- DELIVERABLE 1

-- Retrieve Employee information from Employees table
SELECT emp_no, first_name, last_name
FROM employees;

-- Retrieve Title information from Titles table
SELECT title, from_date, to_date
FROM titles;

-- Find all names and titles for all employees retiring soon
SELECT e.emp_no, e.first_name, e.last_name,
	ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
	ON (e.emp_no = ti.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows from retirement_titles
SELECT DISTINCT ON (emp_no) emp_no, 
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;

-- Retrieve number of employees by most recent job title about to retire
SELECT COUNT(title) as count_title, title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count_title DESC;

SELECT * FROM retiring_titles;

-- DELIVERABLE 2

-- Retrieve Employee information from Employees table
SELECT emp_no, first_name, last_name, birth_date
FROM employees;

-- Retrieve dates from dept_emp table
SELECT from_date, to_date
FROM dept_emp;

SELECT * FROM dept_emp;

-- Retrieve title from titles table
SELECT title
FROM titles;

SELECT * FROM titles;

-- Find all employees eligible for mentorship and create new table
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
	de.from_date, de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
	ON e.emp_no = de.emp_no
INNER JOIN titles as ti
	ON de.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') 
	AND (ti.to_date = '9999-01-01')
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibility;

-- DELIVERABLE 3

-- Find department retirees based on department
SELECT COUNT(ut.emp_no) as count_emp, d.dept_name
FROM dept_emp as de
INNER JOIN departments as d
	ON (de.dept_no = d.dept_no)
INNER JOIN unique_titles as ut
	ON (de.emp_no = ut.emp_no)
GROUP BY dept_name
ORDER BY count_emp DESC;

-- Expand employee eligibility for mentorship program by one year
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
	de.from_date, de.to_date,
	ti.title
INTO practice_table
FROM employees as e
INNER JOIN dept_emp as de
	ON e.emp_no = de.emp_no
INNER JOIN titles as ti
	ON de.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1964-01-01' AND '1965-12-31') 
	AND (ti.to_date = '9999-01-01')
ORDER BY e.emp_no;

SELECT COUNT(*) FROM practice_table;

