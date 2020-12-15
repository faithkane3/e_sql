-- 1. Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

USE employees;

-- 2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. (709 observations)

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

-- a. In your comments, answer: What was the first and last name in the first row of the results? (10397	1955-11-11	Irena	Reutenauer	M	1993-05-21)

-- b. What was the first and last name of the last person in the table? (10200	1961-12-31	Vidya	Awdeh	M	1985-10-16)

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name DESC;

-- 3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name.  (709 observations)

SELECT *
FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name =  'Maya'
ORDER BY first_name, last_name;

-- a. In your comments, answer: What was the first and last name in the first row of the results? (46986	1964-10-15	Irena	Acton	M	1992-07-11)

-- b. What was the first and last name of the last person in the table? (409124	1961-11-01	Irena	Zuberek	M	1987-04-21)

SELECT *
FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name =  'Maya'
ORDER BY first_name, last_name DESC;

-- 4. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. (709 observations)

SELECT *
FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name =  'Maya'
ORDER BY last_name, first_name;

-- a. In your comments, answer: What was the first and last name in the first row of the results? (46986	1964-10-15	Irena	Acton	M	1992-07-11)

-- b. What was the first and last name of the last person in the table? (479435	1959-07-10	Maya	Zyda	M	1987-08-23)

SELECT *
FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name =  'Maya'
ORDER BY last_name DESC, first_name;

-- 5. Write a query to find all current employees whose last name starts and ends with 'E'. Sort the results by their employee number. 

SELECT *
FROM employees 
WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
ORDER BY emp_no;

-- a. Enter a comment with the number of employees returned, the first employee number and their first and last name... (899 observations), (10021	1960-02-20	Ramzi	Erde	M	1988-02-10) 

-- b. and the last employee number with their first and last name. (499648	1960-09-03	Tadahiro	Erde	F	1992-08-13)

SELECT *
FROM employees 
WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
ORDER BY emp_no DESC;

-- 6. Write a query to to find all current employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest emmployee.



-- 7. Find all previous employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest emmployee who was hired first.


SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
AND birth_date LIKE '%-12-25';
