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