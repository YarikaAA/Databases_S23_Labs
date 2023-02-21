-- 1) Find the maximum and minimum enrolment across all sections, considering only sections that had 
-- some enrolment, don't worry about those that had no students taking that section.

SELECT max(stu_count), min(stu_count)
FROM (
    SELECT count(takes.ID) as stu_count 
    FROM section 
    INNER JOIN takes ON section.course_id = takes.course_id AND section.sec_id = takes.sec_id AND section.semester = takes.semester AND section.year = takes.year
    GROUP BY takes.course_id, takes.sec_id, takes.semester, takes.year
)AS StudentCounts


-- 2) Find all sections that had the maximum enrolment (along with the maximum enrolment), using the
-- subquery.

SELECT course_id, sec_id, semester, year
FROM Takes 
GROUP BY course_id, sec_id, semester, year 
HAVING count(ID) = (SELECT max(stu_count)
        FROM (
            SELECT count(takes.ID) as stu_count 
            FROM section 
            INNER JOIN takes ON section.course_id = takes.course_id AND section.sec_id = takes.sec_id AND section.semester = takes.semester AND section.year = takes.year
            GROUP BY takes.course_id, takes.sec_id, takes.semester, takes.year
        ) AS StudentCounts
    ); 

-- 3) Modify 1 to include sections with no students taking them; the enrolment for such sections should
-- be treated as 0. Do this in two different ways (and create require data for testing)
-- a) Using a scalar subquery

SELECT max(stu_count), min(stu_count)
FROM (
    SELECT count(takes.ID) as stu_count
    FROM section
    LEFT OUTER JOIN takes ON section.course_id = takes.course_id AND section.sec_id = takes.sec_id AND section.semester = takes.semester AND section.year = takes.year
    GROUP BY section.course_id, section.sec_id, section.semester, section.year
) AS StudentCounts 


-- b) Using aggregation on a left outer join (use the SQL natural left outer join syntax)

SELECT MAX(stu_count), MIN(stu_count) 
FROM(
    SELECT COALESCE(COUNT(takes.ID), 0) AS stu_count
    FROM Section LEFT OUTER JOIN takes 
    USING (course_id, sec_id, semester, year) 
    GROUP BY course_id, sec_id, semester, year
) AS StudentCounts 

-- 4) Find all courses whose identifier starts with the string 'CS-1'

SELECT * 
FROM Course 
WHERE course_id LIKE 'CS-1%';

-- 5) Find the names of all instructors from Biology department

SELECT name 
FROM instructor 
WHERE dept_name = 'Biology';

-- 6) Find the enrolment of each section that was offered in Autumn 2022

SELECT course_id, sec_id, COUNT(ID) AS Enrolment
FROM Takes 
WHERE semester = 'Autumn' OR semester = 'Fall' AND year = 2022 
GROUP BY course_id, sec_id;

-- 7) Find the maximum enrolment, across all sections, in Autumn 2022

SELECT MAX(Enrolment) 
FROM (
    SELECT COUNT(ID) AS Enrolment 
    FROM Takes 
    WHERE semester = 'Autumn' OR semester = 'Fall' AND year = 2022 
    GROUP BY course_id, sec_id
) as StudentCounts;