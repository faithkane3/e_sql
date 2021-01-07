-- Use my user db.

USE bayes_825;

-- 1. Using the example from the lesson, re-create the employees_with_departments table.

CREATE TEMPORARY TABLE employees_with_departments AS
SELECT
	*
FROM employees.employees_with_departments;

-- a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.

ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);

-- b. Update the table so that full name column contains the correct data

UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

-- Check my table so far.

SELECT
	*
FROM employees_with_departments;

-- c. Remove the first_name and last_name columns from the table.

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- Validate my drops.

SELECT
	*
FROM employees_with_departments;

-- d. What is another way you could have ended up with this same table? Here I get exactly what I want in my SELECT while creating the temporary table.

CREATE TEMPORARY TABLE employees_with_departments_2 AS
SELECT
	emp_no,
	CONCAT(first_name, ' ', last_name) AS full_name,
	dept_no,
	dept_name
FROM employees.employees_with_departments;

SELECT
	*
FROM employees_with_departments_2;

-- 2. Create a temporary table based on the payment table from the sakila database.

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

CREATE TEMPORARY TABLE sakila_payment AS
SELECT
	*
FROM sakila.payment;

ALTER TABLE sakila_payment
ADD cents INT;

UPDATE sakila_payment
SET cents = amount * 100;

SELECT
	*
FROM sakila_payment
LIMIT 10;


-- 3. Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

