-- 1. Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).

SELECT CONCAT(
    name, "(", SUBSTR(occupation,1,1), ")"
    )
FROM occupations
ORDER BY name;

-- 2. Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:
-- There are a total of [occupation_count] [occupation]s.

SELECT CONCAT(
    'There are a total of', ' ', COUNT(*), ' ', LOWER(occupation), 's.'
    )
FROM occupations
GROUP BY occupation
ORDER BY COUNT(*), occupation;

/*
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

Note: Print NULL when there are no more names corresponding to an occupation.
*/

SET @r1=0, @r2=0, @r3=0, @r4=0;

SELECT MIN(Doctor), 
       MIN(Professor), 
       MIN(Singer), 
       MIN(Actor)
FROM(
  SELECT CASE WHEN Occupation='Doctor' THEN (@r1:=@r1+1)
              WHEN Occupation='Professor' THEN (@r2:=@r2+1)
              WHEN Occupation='Singer' THEN (@r3:=@r3+1)
              WHEN Occupation='Actor' THEN (@r4:=@r4+1) 
         END AS RowNumber,
    CASE WHEN Occupation='Doctor' THEN Name END AS Doctor,
    CASE WHEN Occupation='Professor' THEN Name END AS Professor,
    CASE WHEN Occupation='Singer' THEN Name END AS Singer,
    CASE WHEN Occupation='Actor' THEN Name END AS Actor
  FROM OCCUPATIONS
  ORDER BY Name
) Temp
GROUP BY RowNumber;

/*
Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:

Equilateral: It's a triangle with  sides of equal length.
Isosceles: It's a triangle with  sides of equal length.
Scalene: It's a triangle with  sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle.
*/
SELECT CASE 
            WHEN A + B > C AND B + C > A AND C + A > B THEN
                CASE WHEN A = B AND B = C THEN 'Equilateral'
                     WHEN A = B OR A = C OR B = C THEN 'Isosceles'
                     ELSE 'Scalene'
                END
            ELSE 'Not A Triangle'
       END
FROM triangles;

/*
Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.

*/

SELECT country.continent,
       FLOOR(AVG(city.population))
FROM city
JOIN country ON city.countrycode = country.code
GROUP BY country.continent;

/*
You are given two tables: Students and Grades. Students contains three columns ID, Name and Marks.

Student -> id, name, marks
Grades -> grade, min_mark, max_mark

Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.

Write a query to help Eve.

This last statement could easily be interpreted as, "ALL records with grade lower than 8 should be listed by their marks in ascending order. (And not in descending order by grade.)"

However, the test code is expecting these to be ordered by grade first (descending) then by mark (ascending).
*/

SELECT IF(grade < 8, NULL, name), 
       grade, 
       marks
FROM students 
JOIN grades
WHERE marks BETWEEN min_mark AND max_mark
ORDER BY grade DESC, name;

/*
Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.

Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. If more than one wand has same power, sort the result in order of descending age.

This query requires a self-join to obtain the minimum number of coins for power and age.
*/

SELECT w.id,
       wp.age,
       w.coins_needed,
       w.power
FROM wands AS w
JOIN wands_property AS wp ON w.code=wp.code 
WHERE wp.is_evil = 0
    AND w.coins_needed = (SELECT MIN(coins_needed)
                          FROM wands AS w2
                          JOIN wands_property AS wp2 ON w2.code=wp2.code
                          WHERE w.power=w2.power
                          AND wp.age=wp2.age)
ORDER BY w.power DESC, wp.age DESC;

/*
You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!

The total score of a hacker is the sum of their maximum scores for all of the challenges. Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. Exclude all hackers with a total score of  from your result.

Getting closer on being able to do subqueries like this, but still way more learning to do.
*/

SELECT h.hacker_id, 
       name, 
       SUM(score) AS total_score
FROM hackers AS h 
INNER JOIN
            /* find max_score */
            (select hacker_id, 
                    MAX(score) AS score 
             FROM submissions 
             GROUP BY challenge_id, hacker_id) AS max_score
        ON h.hacker_id=max_score.hacker_id
GROUP BY h.hacker_id, name
HAVING total_score > 0
ORDER BY total_score DESC, h.hacker_id ASC;

/*
List each continent and the name of the country that comes first alphabetically. Here I use ALL with a subquery.
*/

SELECT continent,
       name
FROM country x
WHERE x.name <= ALL(
                    SELECT y.name
                    FROM country y
                    WHERE x.continent = y.continent
                    )
ORDER BY continent;

/*
Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name, and the total number of challenges created by each student. 

Sort your results by the total number of challenges in descending order. If more than one student created the same number of challenges, then sort the result by hacker_id. 

If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.
*/



/*You are given two sets.
Set A = {1,2,3,4,5,6}
Set B = {2,3,4,5,6,7,8}

How many elements are present in A Union B?

8 elements are present in A Union B.
*/

