-- 1. Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

USE employees;
SELECT database();

-- 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. (709 observations)



-- a. In your comments, answer: What was the first and last name in the first row of the results? (10397	1955-11-11	Irena	Reutenauer	M	1993-05-21)

-- b. What was the first and last name of the last person in the table? (10200	1961-12-31	Vidya	Awdeh	M	1985-10-16)



-- 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name.  (709 observations)



-- a. In your comments, answer: What was the first and last name in the first row of the results? (46986	1964-10-15	Irena	Acton	M	1992-07-11)

-- b. What was the first and last name of the last person in the table? (409124	1961-11-01	Irena	Zuberek	M	1987-04-21)



-- 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. (709 observations)



-- a. In your comments, answer: What was the first and last name in the first row of the results? (46986	1964-10-15	Irena	Acton	M	1992-07-11)

-- b. What was the first and last name of the last person in the table? (479435	1959-07-10	Maya	Zyda	M	1987-08-23)



-- 5. Write a query to find all employees whose last name starts AND ends with 'E'. Sort the results by their employee number. 



-- a. Enter a comment with the number of employees returned, the first employee number and their first and last name... (899 observations), (10021	1960-02-20	Ramzi	Erde	M	1988-02-10) 

-- b. and the last employee number with their first and last name. (499648	1960-09-03	Tadahiro	Erde	F	1992-08-13)



-- 6. Write a query to to find all employees whose last name starts AND ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. 



-- a. Enter a comment with the number of employees returned, the name of the newest employee (899 observations) (233488	1961-12-16	Sergi	Erde	F	1985-02-02) 

-- b. and the name of the oldest employee. (899 observations)(67892	1958-08-15	Teiji	Eldridge	M	1999-11-27)



-- 7. Find all employees hired in the 90s AND born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. 



-- a. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last (362 observations)(243297	1962-12-25	Alselm	Cappello	F	1990-01-01)


-- b. and the name of the youngest emmployee who was hired first. (362 observations)(33936	1952-12-25	Khun	Bernini	M	1999-08-31)


