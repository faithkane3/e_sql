-- List all available databases, like 'ls'
SHOW DATABASES;

-- Choose and use a database, like cd. Here, I'm using sakila. Backticks can also be used if necessary.
USE sakila;
USE `sakila`;

-- Show the currently selected db, like pwd.
SELECT database();

-- Show the code for how this specific database was created.
SHOW CREATE DATABASE sakila;

-- Note: The structure of a database and the relationships of one table to another is called the schema or database.

-- Switch database to employees.
USE employees;

-- Confirm currently selected db.
SELECT database();