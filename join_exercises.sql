-- Join Example Database

-- 1. Use the join_example_db. Select all the records from both the users and roles tables.

USE bayes_825;

SELECT
	*
FROM users;

/*
id  name    email               role_id
_________________________________________
1	bob	    bob@example.com	    1
2	joe	    joe@example.com  	2
3	sally	sally@example.com	3
4	adam	adam@example.com	3
5	jane	jane@example.com	NULL
6	mike	mike@example.com	NULL
*/

SELECT
	*
FROM roles;

/*
id  name
______________
1	admin
2	author
3	reviewer
4	commenter
*/


-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results

-- a. Use JOIN (INNER JOIN). This returns only the rows with matches on both the left AND right tables.

SELECT
	*
FROM users
JOIN roles;

-- (4 rows) (No NULL values, Jane and Mike missing from users table, and commenter role missing from roles table because they don't have matches on BOTH tables.)

/*
id  name     email             role_id  id  name
_____________________________________________________
1	bob	    bob@example.com	       1	1	admin
2	joe	    joe@example.com	       2	2	author
3	sally	sally@example.com	   3	3	reviewer
4	adam	adam@example.com	   3	3	reviewer
*/

-- b. Use LEFT JOIN. This returns all of the rows from the left table and only rows from the right table with a match on the left table.

SELECT
	*
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

-- (6 rows) (Jane and Mike are here now with NULL values for role_id, id, and name because all rows brought from the left table, users, but commenter still missing because no match on the left table.)

/*
id  name     email             role_id  id  name
_____________________________________________________
1	bob	    bob@example.com	       1	1	admin
2	joe	    joe@example.com	       2	2	author
3	sally	sally@example.com	   3	3	reviewer
4	adam	adam@example.com	   3	3	reviewer
5	jane	jane@example.com	 NULL  NULL	NULL
6	mike	mike@example.com	 NULL  NULL	NULL
*/

-- c. Use RIGHT JOIN. This does the opposite of the LEFT JOIN. This is not a common join because you can just reverse the order of your tables in your join and use a LEFT JOIN.

SELECT
	*
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

-- (5 rows) (Jane and Mike are missing now, but the non-matching rows from the right table, roles, are present with NULL values for the missing info from the left table, users.)

/*
id  name     email             role_id  id  name
_____________________________________________________
1	bob	    bob@example.com	       1	1	admin
2	joe	    joe@example.com	       2	2	author
3	sally	sally@example.com	   3	3	reviewer
4	adam	adam@example.com	   3	3	reviewer
NULL NULL	NULL	              NULL	4	commenter
*/

-- 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.