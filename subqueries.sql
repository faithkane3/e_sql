-- 1. Find all the employees with the same hire date as employee 101010 using a sub-query.

SELECT *
FROM employees
WHERE hire_date IN
	(SELECT hire_date
	FROM employees
	WHERE emp_no = 101010);
	
-- 2. Find all the titles held by all employees with the first name Aamod.

SELECT title
FROM titles
WHERE emp_no IN
	(SELECT emp_no
	FROM employees
	WHERE first_name = 'Aamod');
	
-- 3. How many people in the employees table are no longer working for the company?

SELECT *
FROM employees
WHERE emp_no NOT IN (
	SELECT emp_no
	FROM salaries
	WHERE to_date > CURDATE());

-- 4. Find all the current department managers that are female.

SELECT first_name,
		last_name
FROM employees
WHERE gender = 'F'
AND emp_no IN(
	SELECT emp_no
	FROM dept_manager
	WHERE to_date > CURDATE()
);

-- 5. Find all the employees that currently have a higher than average salary.

SELECT e.first_name,
		e.last_name,
		s.salary
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no AND s.to_date > CURDATE()
WHERE s.salary >
	(SELECT AVG(salary)
	FROM salaries);

-- 6. How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

SELECT COUNT(salary)
FROM salaries
WHERE to_date > CURDATE()
AND salary >= (SELECT(MAX(salary) - STDDEV(salary))
				FROM salaries);

-- The percent of employees whose salaries are within one standard deviation of the highest salary.
SELECT
	((SELECT COUNT(salary)
	FROM salaries
	WHERE to_date > CURDATE()
	AND salary >= (SELECT(MAX(salary) - STDDEV(salary))
					FROM salaries)) /
	(SELECT COUNT(*) AS total_emp
	FROM employees)) * 100 AS percent_employees;