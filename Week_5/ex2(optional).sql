-- 1. The university rules allow an F grade to be overridden by any pass grade (A, B, C, D). Now, create a
-- view that lists information about all fail grades that have not been overridden (the view should
-- contain all attributes from the takes relation).

CREATE VIEW unfailed AS
SELECT t.* FROM takes t
LEFT JOIN takes t2
    ON (t.ID = t2.ID 
    AND t.course_id = t2.course_id
    AND t.sec_id = t2.sec_id
    AND t.semester = t2.semester
    AND t.year = t2.year)
WHERE t.grade = 'F' AND t2.grade IN ('A', 'B', 'C', 'D') IS NULL;    


-- 2. Find all students who have 2 or more non-overridden F grades as per the takes relation, and list them
-- along with the F grades.

SELECT t.ID, t.course_id, t.sec_id, t.semester, t.year, t.grade 
FROM takes t 
JOIN (SELECT ID FROM takes WHERE grade = 'F'
      GROUP BY ID
      HAVING count(*) > 1) p ON (t.ID = p.ID)
WHERE t.grade = 'F' ;


-- 3. Grades are mapped to a grade point as follows: A:10, B:8, C:6, D:4 and F:0. Create a table to store
-- these mappings, and write a query to find the CPI of each student, using this table. Make sure
-- students who have not got a non-null grade in any course are displayed with a CPI of null.

CREATE TABLE mapping (
    Grade CHARACTER(1),
    GradePt INTEGER
);

INSERT INTO mapping VALUES ('A', 10);
INSERT INTO mapping VALUES ('B', 8);
INSERT INTO mapping VALUES ('C', 6);
INSERT INTO mapping VALUES ('D', 4);
INSERT INTO mapping VALUES ('F', 0);

SELECT s.ID, AVG(m.GradePt) as CPI
FROM student s
LEFT JOIN takes t ON (s.ID = t.ID)
LEFT JOIN mapping m ON (m.Grade = t.grade)
GROUP BY s.ID
HAVING SUM(m.GradePt IS NOT NULL);


-- 4. Find all rooms that have been assigned to more than one section at the same time. Display the rooms
-- along with the assigned sections; I suggest you use a with clause or a view to simplify this query.

WITH multiple_assigned_rooms AS (
    SELECT building, room_number, COUNT(time_slot_id) as num_mod
    FROM Section 
    GROUP BY building, room_number 
    HAVING COUNT(time_slot_id) > 1
)
SELECT s.building, s.room_number, t.semester, t.year, t.sec_id
FROM multiple_assigned_rooms s
JOIN Section t
    ON (s.building=t.building AND s.room_number=t.room_number);


-- 5. Create a view faculty showing only the ID, name, and department of instructors.

CREATE VIEW faculty AS
SELECT i.ID, i.name, d.dept_name
FROM instructor i
JOIN department d
    on (i.dept_name = d.dept_name);
