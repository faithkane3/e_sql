-- Create a file named case_exercises.sql and craft queries to return the results for the following criteria:
-- (Use CASE statements or IF() function to explore information in the employees database
)

-- 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

USE employees;

-- Subquery to get the most recent departments for each employee.

SELECT 
	emp_no,
	MAX(to_date) AS max_date
FROM dept_emp
GROUP BY emp_no;

-- Use my subquery to get rid of the duplicate entries for employees older departments.

SELECT
	dept_emp.emp_no,
	dept_no,
	to_date,
	from_date,
	CASE
		WHEN to_date = '9999-01-01' THEN 1
		ELSE 0
	END AS 'is_current_employee'
FROM dept_emp
JOIN (SELECT 
		emp_no,
		MAX(to_date) AS max_date
	FROM dept_emp
	GROUP BY emp_no) AS last_dept
ON dept_emp.emp_no = last_dept.emp_no;



-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT
	CONCAT(first_name, ' ', last_name) AS employee_name,
	CASE
		WHEN LEFT(last_name, 1) IN('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h') THEN 'A-H'
		WHEN LEFT(last_name, 1) IN('i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q') THEN 'I-Q'
		ELSE 'R-Z'
	END AS alpha_group
FROM employees;


--3. How many employees (current or previous) were born in each decade?





-- Bonus: What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?



