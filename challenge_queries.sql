
--CHALLENGE--
-- Create a Retirement Titles table 
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (t.to_date = '9999-01-01')
ORDER BY emp_no ASC;


-- Use Dictinct with Orderby to remove duplicate rows to create unique_titles table
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY rt.emp_no ASC, rt.to_date DESC;

SELECT * FROM unique_titles

-- Retrieve the number of employees about to retire by job title
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

SELECT * FROM titles

--Create a mentorship Eligibility table
SELECT DISTINCT ON(e.emp_no)e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	 AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no ASC;



-- Readme Overview details
-- find the year Pwelett- Hackard was established
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.hire_date
--INTO ph_start_date
FROM employees AS e
ORDER BY e.hire_date ASC;
--established 1985

--find total# of current employees
SELECT DISTINCT ON(e.emp_no)e.emp_no,
	e.first_name,
	e.last_name,
	t.to_date
INTO current_employees
FROM employees AS e
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE (t.to_date = '9999-01-01')
ORDER BY e.emp_no ASC;
--240,124 current emp

--readme results details
-- Retrieve the number of employees who are eligible for the mentorship program
SELECT COUNT(me.title), me.title
INTO mentorship_titles
FROM mentorship_eligibility as me
GROUP BY me.title
ORDER BY COUNT(me.title) DESC;


--1a.find complete list of remaining employees
SELECT DISTINCT ON(e.emp_no)e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	t.title,
	t.from_date,
	t.to_date
INTO remaining_employees 
FROM employees AS e
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE (e.birth_date NOT BETWEEN '1952-01-01' AND '1955-12-31')
	AND (t.to_date = '9999-01-01')
ORDER BY e.emp_no ASC;

-- 1b.Organize remaining employees to show only engineering related titles, 
-- Order by the title first, starting date second.
SELECT * FROM remaining_employees AS re
WHERE title IN ('Assistant Engineer','Engineer','Senior Engineer')
ORDER BY (title, from_date) ASC;

--Run a query to count the number of individuals who would be eligible for the mentorship program if the criteria was modified
SELECT COUNT(emp_no) FROM remaining_employees
WHERE (birth_date BETWEEN '1962-01-01' AND '1965-12-31')