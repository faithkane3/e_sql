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