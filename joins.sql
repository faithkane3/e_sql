-- 1. Use the employees database. 

USE employees;

-- 2.  Write a query that shows each department along with the name of the current manager for that department.

SELECT d.dept_name AS 'Department Name', 
       CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager'
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no AND dm.to_date > CURDATE()
JOIN departments AS d ON dm.dept_no = d.dept_no
ORDER BY d.dept_name;

--3. Find the name of all departments currently managed by women.

SELECT d.dept_name AS 'Department Name', 
       CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager'
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no AND to_date > CURDATE()
JOIN departments AS d ON dm.dept_no = d.dept_no
WHERE e.gender = 'F'
ORDER BY d.dept_name;

-- 4. Find the current titles of employees currently working in the Customer Service department.

SELECT t.title AS Title, 
       COUNT(t.title) AS Count
FROM titles AS t
JOIN dept_emp AS de ON de.emp_no = t.emp_no 
    AND de.to_date > CURDATE() 
    AND t.to_date > CURDATE()
JOIN departments AS d ON d.dept_no = de.dept_no AND d.dept_name = 'Customer Service'
GROUP BY t.title;

-- 5. Find the current salary of all current managers.

SELECT d.dept_name AS 'Department Name', 
       CONCAT(e.first_name, ' ', e.last_name) AS Name,
       s.salary AS Salary
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no AND s.to_date > CURDATE()
JOIN dept_manager AS dm ON s.emp_no = dm.emp_no AND dm.to_date > CURDATE()
JOIN departments AS d ON dm.dept_no = d.dept_no
ORDER BY d.dept_name;

-- 6. Find the number of employees in each department. Hint: Use current not historic information.

SELECT d.dept_no, 
		d.dept_name, 
		COUNT(*) AS num_employees
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no AND de.to_date > CURDATE()
JOIN departments AS d ON d.dept_no = de.dept_no
GROUP BY dept_no, dept_name;

-- 7. Which department has the highest average salary? Hint: Use current not historic information.

SELECT d.dept_name, ROUND(AVG(s.salary),2) AS average_salary
FROM departments AS d
JOIN dept_emp AS de ON de.dept_no = d.dept_no AND de.to_date > CURDATE()
JOIN salaries AS s ON s.emp_no = de.emp_no AND s.to_date > CURDATE()
GROUP BY d.dept_name
ORDER BY average_salary DESC
LIMIT 1;

-- 8. Who is the highest paid employee in the Marketing department?

SELECT e.first_name, e.last_name
FROM departments AS d
JOIN dept_emp AS de ON de.dept_no = d.dept_no AND de.to_date > CURDATE() AND d.dept_name = 'Marketing'
JOIN salaries AS s ON s.emp_no = de.emp_no AND s.to_date > CURDATE()
JOIN employees AS e ON e.emp_no = s.emp_no
ORDER BY s.salary DESC
LIMIT 1;

-- 9. Which current department manager has the highest salary?

SELECT e.first_name, 
		e.last_name, 
		s.salary,
		d.dept_name 
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no AND s.to_date > CURDATE()
JOIN dept_manager AS dm ON s.emp_no = dm.emp_no AND dm.to_date > CURDATE()
JOIN departments AS d ON dm.dept_no = d.dept_no
ORDER BY s.salary DESC
LIMIT 1;

-- 10. Bonus: Find the names of all current employees, their department name, and their current manager's name.

-- Using a subquery.

SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name',
       d.dept_name AS 'Department Name',
       b.dept_manager AS 'Manager Name'		
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no AND de.to_date > CURDATE()
JOIN departments AS d USING(dept_no)
JOIN (
      SELECT dm.dept_no,
             CONCAT(e.first_name, ' ', e.last_name) AS dept_manager
      FROM employees AS e        
      JOIN dept_manager AS dm ON dm.emp_no = e.emp_no AND dm.to_date > CURDATE()
    ) AS b USING(dept_no)
ORDER BY d.dept_name;

-- Using a self join.

SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name',
       d.dept_name AS 'Department Name',
       CONCAT(managers.first_name, ' ', managers.last_name) AS 'Manager_name'
FROM dept_emp AS de
JOIN employees AS e USING(emp_no)
JOIN departments AS d ON d.dept_no = de.dept_no
JOIN dept_manager AS dm ON dm.dept_no = d.dept_no AND dm.to_date > CURDATE()
JOIN employees AS managers ON managers.emp_no = dm.emp_no
WHERE de.to_date > CURDATE()
ORDER BY d.dept_name;