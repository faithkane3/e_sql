-- 1. Create a new SQL script named limit_exercises.sql.

-- 2. MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:

USE employees;
SELECT database();
SHOW tables;

SELECT DISTINCT title 
FROM titles;

-- List the first 10 distinct last name sorted in descending order. 

SELECT DISTINCT last_name 
FROM employees 
ORDER BY last_name DESC 
LIMIT 10;

/* 
Zykh
Zyda
Zwicker
Zweizig
Zumaque
Zultner
Zucker
Zuberek
Zschoche
Zongker 
*/

-- Find all employees hired in the 90s AND born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.

SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
AND birth_date LIKE '%-12-25';
ORDER BY birth_date ASC, hire_date DESC
LIMIT 5;

/* 
Khun Bernini
Pohua Sudkamp
Xiaopeng Uehara
Irene Isaak
Dulce Wrigley 
*/


-- 4. Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results. 

/*
Page 1 -> LIMIT = 5, OFFSET = 0, Records 1-5
Page 2 -> LIMIT = 5, OFFSET = 5, Records 6-10
Page 3 -> LIMIT = 5, OFFSET = 10, Records 11-15
...

Page # * Limit = offset for next page.
Page 9 * 5 = 45, so page 10 is offset 45 or 9 pages with limits of 5 each.
*/

SELECT * FROM employees
WHERE hire_date > '1990' AND hire_date < '2000' AND birth_date like '%12-25'
ORDER BY birth_date ASC, hire_date DESC
LIMIT 5 OFFSET 45;


/* 
Piyawadee Bultermann
Heng Luft
Yuqun Kandlur
Basil Senzako
Mabo Zobel 
*/

-- LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?

