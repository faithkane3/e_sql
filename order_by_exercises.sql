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
WHERE last_name LIKE 'E%' OR last_name LIKE '%E';

-- a. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.


-- 6. Find all current or previous employees whose last name starts OR ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. (30_723 observations)


-- How many employees have a last name that ends with E, but does not start with E? (23_393 observations)

SELECT *
FROM employees 
WHERE last_name LIKE '%E' AND last_name NOT LIKE 'E%';

-- 7. Find all current or previous employees employees whose last name starts AND ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. (899 observations)

SELECT *
FROM employees 
WHERE last_name LIKE 'E%' AND last_name LIKE '%E';

-- We can also write our query like this... (899 observations; it matches.)

SELECT *
FROM employees
WHERE last_name LIKE 'E%E';

-- How many employees' last names end with E, regardless of whether they start with E? (24_292 observations)

SELECT *
FROM employees 
WHERE last_name LIKE '%E';

-- 8. Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned. 135_214

SELECT * 
FROM employees
WHERE hire_date LIKE '199%';

-- We can also use WHERE BETWEEN AND. (135_214 observations; it matches.)

SELECT * 
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';

-- 9. Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned. (842 observations)

SELECT *
FROM employees
WHERE birth_date LIKE '%-12-25';

-- 10. Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned. (362 observations)

SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
AND birth_date LIKE '%-12-25';

-- 11. Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned. (1873 observations)

SELECT *
FROM employees
WHERE last_name LIKE '%q%';

-- 12. Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found? (547 observations)

SELECT *
FROM employees
WHERE last_name LIKE '%q%' AND NOT last_name LIKE '%qu%';