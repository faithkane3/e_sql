-- List all available databases, like 'ls'
SHOW DATABASES;

/*
information_schema
albums_db
bayes
bayes_825
chipotle
elo_db
employees
fruits_db
iris_db
join_example_db
mall_customers
mysql
numbers
quotes_db
sakila
svi_db
telco_churn
titanic_db
tsa_item_demand
world
zillow
*/

-- Choose and use a database, like cd. Here, I'm using sakila. Backticks can also be used if necessary.
USE sakila;
USE `sakila`;

/*
sakila
*/

-- Show the currently selected db, like pwd.
SELECT database();

-- Show the code for how this specific database was created.
SHOW CREATE DATABASE sakila;

-- Note: The structure of a database and the relationships of one table to another is called the schema or database.

-- Switch database to employees.
USE employees;

-- Confirm currently selected db.
SELECT database();

/*
employees
*/

-- Display a list of all of the tables in a database.
SHOW tables;