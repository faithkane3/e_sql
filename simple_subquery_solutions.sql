USE employees;

-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.

SELECT
	hire_date
FROM employees
WHERE emp_no = 101010;

SELECT
	employees.emp_no,
	first_name,
	last_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
	AND to_date > CURDATE()
WHERE hire_date = (
					SELECT
						hire_date
					FROM employees
					WHERE emp_no = 101010
					);

-- 2. Find all the titles ever held by all current employees with the first name Aamod. 

SELECT
	first_name
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no
	AND to_date > CURDATE()
WHERE first_name = 'Aamod';

SELECT
	title
FROM employees AS e
JOIN titles AS t USING(emp_no)
WHERE first_name IN (
					SELECT
						first_name
					FROM employees AS e
					JOIN salaries AS s ON e.emp_no = s.emp_no
						AND to_date > CURDATE()
					WHERE first_name = 'Aamod'
					)
GROUP BY title;

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

SELECT
	emp_no
FROM salaries
WHERE to_date > CURDATE();

SELECT
	emp_no,
	first_name,
	last_name
FROM employees
WHERE emp_no NOT IN (
					SELECT
						emp_no
					FROM salaries
					WHERE to_date > CURDATE()
					);



-- 4. Find all the current department managers that are female. List their names in a comment in your code.

SELECT
	emp_no
FROM dept_manager
WHERE to_date > CURDATE();

SELECT
	first_name,
	last_name
FROM employees
WHERE emp_no IN (
				SELECT
					emp_no
				FROM dept_manager
				WHERE to_date > CURDATE()
				)
	AND gender = 'F';

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary. 

SELECT
	AVG(salary)
FROM salaries;


SELECT
	*
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no
	AND to_date > CURDATE()
WHERE salary > (
				SELECT
					AVG(salary)
				FROM salaries
				);




-- 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) (There are 83 current salaries within 1 standard deviation of the max salary.)

SELECT
	(MAX(salary) - STDDEV(salary)) AS salary_within_one_stddev_of_max
FROM salaries
WHERE to_date > CURDATE();

SELECT
	COUNT(emp_no)
FROM salaries
WHERE to_date > CURDATE()
AND salary > (
			SELECT
				(MAX(salary) - STDDEV(salary)) AS salary_within_one_stddev_of_max
			FROM salaries
			WHERE to_date > CURDATE()
			);

-- What percentage of all salaries is this?

SELECT 
	CONCAT(
		(SELECT
			COUNT(salary)
		FROM salaries 
		WHERE to_date > CURDATE()
		AND salary > (
					  SELECT
						(MAX(salary) - STDDEV(salary))
					  FROM salaries
					  WHERE to_date > CURDATE())
		) 
/ 
		(
		 SELECT COUNT(*)
		 FROM salaries
		 WHERE to_date > CURDATE()) * 100, '%') AS percent_of_salaries_within_1_stddev_of_max;


