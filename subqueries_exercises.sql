-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.

-- Get the hire date of employee 101010
SELECT
	hire_date
FROM dept_emp
JOIN employees USING(emp_no)
WHERE emp_no = 101010;

-- Use the above query as a scaler subquery. (returns exactly one column value from one row)
SELECT
	first_name,
	last_name,
	hire_date
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
	AND dept_emp.to_date > CURDATE()
WHERE hire_date = (SELECT
						hire_date
					FROM dept_emp
					JOIN employees USING(emp_no)
					WHERE emp_no = 101010
					);

-- 2. Find all the titles ever held by all current employees with the first name Aamod. 
/*
Assistant Engineer
Engineer
Senior Engineer
Senior Staff
Staff
Technique Leader
*/

-- emp_no, first_name, last_name, dept_no, dept_name
SELECT
	*
FROM employees_with_departments;

-- emp_no, title, from_date, to_date
SELECT
	*
FROM titles;


-- Create my subquery to find name Aamod.
SELECT
	first_name
FROM employees_with_departments AS ewd
WHERE first_name = 'Aamod';

-- Use subquery in the WHERE clause of my query to find any titles every held by those with the first name Aamod.

SELECT
	title
FROM employees_with_departments AS ewd
JOIN titles AS t USING(emp_no)
WHERE ewd.first_name IN (SELECT
							first_name
						 FROM employees_with_departments AS ewd
						 WHERE first_name = 'Aamod')
GROUP BY title;




-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code. (59_900 employees are not current employees in the employees table.)

-- My subquery -> All employee numbers of employees currently getting a salary. 

SELECT
	e.emp_no
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no
	AND s.to_date > CURDATE();

-- Count of employees in the employees table whose employee numbers are not getting a salary.

SELECT
	COUNT(emp_no) AS number_of_exemployees
FROM employees
WHERE emp_no NOT IN (
					SELECT
						e.emp_no
					FROM employees AS e
					JOIN salaries AS s ON s.emp_no = e.emp_no
						AND s.to_date > CURDATE()
					);

-- 4. Find all the current department managers that are female. List their names in a comment in your code.

/*
Isamu Legleitner
Karsten Sigstam
Leon DasSarma
Hilary Kambil
*/

-- My subquery -> Employee numbers of all department managers.

SELECT
	emp_no
FROM dept_manager
WHERE to_date > CURDATE();

-- Use my subquery in my WHERE clause to limit names to those with employee numbers in the list of manager employee numbers. Add a condition for female.

SELECT
	CONCAT(first_name, ' ', last_name) AS female_managers
FROM employees
WHERE emp_no IN (
				SELECT
					emp_no
				FROM dept_manager
				WHERE to_date > CURDATE()
				)
AND gender = 'F';


-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.




-- 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?




